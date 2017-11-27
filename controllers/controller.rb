def criteria
	a = Hash.new
	a['professions']=@@db.execute("SELECT * FROM professions;").to_h
	a['specialties']=@@db.execute("SELECT * FROM specialties;").to_h
	a['positions']=@@db.execute("SELECT * FROM positions;").to_h
	return a
end

def search(arg)
	query = <<-SQL
		SELECT first_name || ' ' || last_name AS "full_name", phone
		FROM unemployed 
		INNER JOIN 
	SQL
	@@db.execute(query)
end