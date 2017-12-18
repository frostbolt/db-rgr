class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end
end 

def all_services
	@@db.execute("SELECT * FROM services")
end

def service(id)
	@@db.execute("SELECT * FROM services WHERE id = #{id}")
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
	unless params["description"] == "" || params["price"].to_i < 0.01 || @@db.execute("SELECT * FROM services WHERE id = #{params["id"]}") == []
		@@db.execute("UPDATE services SET description = '#{params["description"]}', price = #{params["price"]} WHERE id = #{params["id"]}")
		return true
	else
		return false
	end
end