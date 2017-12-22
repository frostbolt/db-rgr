class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end
end 

def all_services
	@@db.execute("SELECT * FROM services")
end

def all_clients
	@@db.execute("SELECT * FROM clients")
end

def all_orders
	@@db.execute("""
		SELECT orders.id, orders.description, orders.order_date, orders.deadline,
		clients.first_name, clients.second_name, clients.last_name
		FROM orders LEFT JOIN clients ON orders.client_id = clients.id;
	""")
end

def service(id)
	@@db.execute("SELECT * FROM services WHERE id = #{id}")
end

def client(id) 
	@@db.execute("SELECT * FROM clients WHERE id = #{id}")
end

def order(id) 
	@@db.execute("
		SELECT orders.id, orders.description, orders.order_date, orders.deadline,
		clients.first_name, clients.second_name, clients.last_name, orders.client_id
		FROM orders LEFT JOIN clients ON orders.client_id = clients.id
		WHERE orders.id = #{id}")
end

def orders_by_client(id)
	@@db.execute("SELECT * FROM orders WHERE client_id = #{id}")
end

def work_performed(id)
	@@db.execute("""
		SELECT services.description, services.price, services.id
		FROM work_performed 
		LEFT JOIN services ON work_performed.service_id = services.id
		WHERE work_performed.order_id = #{id}
		ORDER BY service_id;
		""")
end

def delete_service(id)
	work_performed_list = @@db.execute("SELECT * FROM work_performed WHERE service_id = #{id}")
	if work_performed_list == []
		@@db.execute("DELETE FROM services WHERE id = #{id}")
		return true
	else
		return false
	end
end

def edit_service(params)
	return false if params["description"] == "" || params["price"].to_i < 0.01 || @@db.execute("SELECT * FROM services WHERE id = #{params["id"]}") == []
	@@db.execute("""
		UPDATE services
		SET description = '#{params["description"]}',
		price = #{params["price"]}
		WHERE id = #{params["id"]}
	""")
	return true
end

def edit_client(params)
	return false if params.any? { |k, v| v=="" } || @@db.execute("SELECT * FROM clients WHERE id = #{params["id"]}") == []
	@@db.execute("""
		UPDATE clients
		SET first_name = '#{params["first_name"]}',
		second_name = '#{params["second_name"]}',
		last_name = '#{params["last_name"]}',
		organisation = '#{params["organisation"]}',
		address = '#{params["address"]}',
		phone = '#{params["phone"]}'
		WHERE id = #{params["id"]};
	""")
	return true
end

def edit_order(params)
	return false if params.any? { |k, v| v=="" } || @@db.execute("SELECT * FROM orders WHERE id = #{params["id"]}") == []
	@@db.execute("""
		UPDATE orders
		SET description = '#{params["description"]}',
		order_date = '#{params["order_date"]}',
		deadline = '#{params["deadline"]}'
		WHERE id = #{params["id"]}
	""")
	return true
end

def delete_work_performed(params)
	@@db.execute("""
		DELETE 
		FROM work_performed
		WHERE
		service_id = #{params["service_id"]}
		AND
		order_id = #{params["order_id"]}
		AND EXISTS (
			SELECT * FROM work_performed
			WHERE
			service_id = #{params["service_id"]}
			AND
			order_id = #{params["order_id"]}
		)
		LIMIT 1
		""")
end

def add_work_performed(params)
	@@db.execute("""
		INSERT INTO work_performed(service_id, order_id) VALUES (
			#{params["service_id"]},
			#{params["id"]}
		)
	""")
end

def delete_order(id)
	@@db.execute("""
		DELETE 
		FROM work_performed
		WHERE
		order_id = #{id}
		AND EXISTS (
			SELECT * FROM work_performed
			WHERE
			order_id = #{id}
		)
		""")
	@@db.execute("""
		DELETE FROM orders
		WHERE
		id = #{params["id"]};
		AND EXISTS (
			SELECT * FROM order
			WHERE 
			order_id = #{id}
		)
		""")
end

def new_order(params)
	return false if params.any? { |k, v| v=="" }
	@@db.execute("""
		INSERT INTO orders(client_id, description, order_date, deadline)
		VALUES(
			#{params['client_id']},
			'#{params['description']}',
			'#{params['order_date']}',
			'#{params['deadline']}'
		)
	""")
end

def new_client(params)
	return false if params.any? { |k, v| v=="" }
	@@db.execute("""
		INSERT INTO clients(first_name, second_name, last_name, organisation, address, phone)
		VALUES(
			'#{params['first_name']}',
			'#{params['second_name']}',
			'#{params['last_name']}',
			'#{params['organisation']}',
			'#{params['address']}',
			'#{params['phone']}'
		)
	""")
end

def new_service(params)
	return false if params.any? { |k, v| v=="" } || params["price"].to_i < 0.01 || !params["price"].numeric?
	@@db.execute("""
		INSERT INTO services(description, price)
		VALUES(
			'#{params['description']}',
			#{params['price']}
		)
	""")
end

def report(month)

	@@db.execute("""SELECT * FROM (
	SELECT SUM(price) as sigma, un.order_id as order_id, un.description as description, un.order_date as order_date
	FROM (
		SELECT orders.description, work.order_id, work.price, orders.order_date as order_date
		FROM orders
		LEFT JOIN (
			SELECT work_performed.order_id, services.price
			FROM work_performed
			LEFT JOIN services
			ON services.id = work_performed.service_id
		) AS work
		ON work.order_id = orders.id
	) AS un	
	GROUP BY order_id
	)
	WHERE strftime('%m', order_date) = '#{month}';""")

end