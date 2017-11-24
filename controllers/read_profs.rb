def criteria
	a = {}
	a['professions']=@@db.execute("SELECT * FROM professions").to_h
	a['specialties']=@@db.execute("SELECT * FROM specialties").to_h
	a['positions']=@@db.execute("SELECT * FROM positions").to_h
	return a
end
