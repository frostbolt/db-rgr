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

def orders_by_client(id)
	@@db.execute("SELECT * FROM orders WHERE client_id = #{id}")
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
