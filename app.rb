require "sinatra"
require "sqlite3"


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	@PAGE_TITLE = "Главная"
	erb :index
end

get '/by_profession' do
	@PAGE_TITLE = "Поиск по профессии"
	erb :by_profession
end

get '/by_edu' do
	@PAGE_TITLE = "Поиск по месту учебы"
	erb :by_edu
end

