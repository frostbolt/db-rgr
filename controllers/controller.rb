def criteria
	a = Hash.new
	return a
end

def search(arg)
	a = Hash.new
	a["query"] = Array.new
	a["query"] +=  @@db.execute("")

end

def add_new_unemployed(arg)
	