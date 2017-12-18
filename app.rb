require "sinatra"
require "sqlite3"

@@db = SQLite3::Database.new "data.db"

Dir['./controllers/**/*.rb'].each { |file| require file }


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	@PAGE_TITLE = "Ремонт компьютеров | Главная"
	erb :index
end

get '/orders' do
	@PAGE_TITLE = "Ремонт компьютеров | Заказы"
	erb :orders
end

get '/clients' do
	@PAGE_TITLE = "Ремонт компьютеров | Клиенты"
	erb :clients
end

get '/services' do
	@PAGE_TITLE = "Ремонт компьютеров | Прайс"
	@data = {}
	@data[:services] = all_services
	erb :services
end

get '/services/:id' do 
	halt 404 unless params[:id].numeric?
	@PAGE_TITLE = "Редактирование элемента прайс-листа"
	@data = {}
	@data[:service] = service(params[:id])
	halt 404 if @data[:service] == []
	erb :service
end

delete '/services/:id' do
	halt "Неверный id" unless params[:id].numeric?
	halt "Эта услуга не может быть удалена, т.к. она используется в записях" unless delete_service(params[:id]);
	'Услуга удалена'
end

post '/services/:id' do
	halt 'Неверный id' unless params[:id].numeric?
	halt 'Произошла ошибка при попытке отредактировать запись' unless edit_service(params);
	puts params.inspect
	'Услуга изменена'
end


not_found do
	@PAGE_TITLE = "Что могло пойти не так? :("
	erb :error
end