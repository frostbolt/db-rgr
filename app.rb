require "sinatra"
require "sqlite3"

@@db = SQLite3::Database.new "data.db"

Dir['./controllers/**/*.rb'].each { |file| require file }


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	@criteria = criteria
	@PAGE_TITLE = "Центр занятости"
	erb :index
end


get '/search' do
	@search_results = search(params)
	halt 400, erb(:error) if @search_results == 0
	@PAGE_TITLE = "Результаты поиска"
	erb :search_results
end
