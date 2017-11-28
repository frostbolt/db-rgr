def criteria
	a = Hash.new
	a['professions']=@@db.execute("SELECT * FROM professions;").to_h
	a['specialties']=@@db.execute("SELECT * FROM specialties;").to_h
	a['positions']=@@db.execute("SELECT * FROM positions;").to_h
	return a
end

def search(arg)
	a = Hash.new
	a["query"] = Array.new
	a["query"] +=  @@db.execute("SELECT profession_title FROM professions WHERE id = #{arg["profession"]}")[0] unless arg["profession"] == "0"
	a["query"] +=  @@db.execute("SELECT specialty_title FROM specialties WHERE id = #{arg["spetiality"]}")[0] unless arg["spetiality"] == "0"
	a["query"] +=  @@db.execute("SELECT position_title FROM positions WHERE id = #{arg["position"]}")[0] unless arg["position"] == "0"
	query = <<-SQL
		SELECT first_name, last_name, phone, registration_date
		FROM unemployed
		WHERE id IN
		(
			SELECT unemployed_id
			FROM unemployed_education
			WHERE specialty_id = #{arg["spetiality"]}
		)
	SQL
	a["search_results"] = @@db.execute(query)
	a
end