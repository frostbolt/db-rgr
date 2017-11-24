namespace :db do

	desc "refresh tables"
	task :refresh do
		sh 'rm -f data.db'
		sh "echo .read SQL/create_tables.sql | sqlite3 data.db"
	end

	desc "fill in with demo data"
	task :demo do
		sh "echo .read SQL/demo_data.sql | sqlite3 data.db"
	end
	
end