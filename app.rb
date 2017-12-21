require "sinatra"
require "sqlite3"

@@db = SQLite3::Database.new "data.db"

Dir['./controllers/**/*.rb'].each { |file| require file }


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	@PAGE_TITLE = "Ремонт компьютеров | Главная"
	erb :index
end

get '/services' do
	@PAGE_TITLE = "Ремонт компьютеров | Прайс"
	@data = {}
	@data[:services] = all_services
	erb :services
end

get '/services/:id' do 
	halt 404 unless params[:id].numeric?
	@PAGE_TITLE = "Элемент прайс-листа"
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
	'Услуга изменена'
end

get '/clients' do
	@PAGE_TITLE = "Ремонт компьютеров | Клиенты"
	@data = {}
	@data[:clients] = all_clients
	erb :clients
end

get '/clients/:id' do 
	halt 'Неверный id' unless params[:id].numeric?
	@PAGE_TITLE = "Информация о клиенте"
	@data = {}
	@data[:client] = client(params[:id])
	halt 404 if @data[:client] == []
	@data[:orders] = orders_by_client(params[:id])
	erb :client
end

post '/clients/:id' do
	halt 'Неверный id' unless params[:id].numeric?
	halt 'Произошла ошибка при попытке отредактировать запись' unless edit_client(params);
	'Запись изменена'
end

get '/orders' do
	@PAGE_TITLE = "Ремонт компьютеров | Заказы"
	@data = {}
	@data[:orders] = all_orders
	erb :orders
end

get '/orders/:id' do
	halt 'Неверный id' unless params[:id].numeric?
	@PAGE_TITLE = "Информация о заказе"
	@data = {}
	@data[:order] = order(params[:id])
	halt 404 if @data[:order] == []
	@data[:work_performed] = work_performed(params[:id])
	erb :order
end

post '/orders/:id' do
	puts params.inspect
	halt 'Неверный id' unless params[:id].numeric?
	halt 'Произошла ошибка при попытке отредактировать запись' unless edit_order(params);
	'Запись изменена'
end

delete '/work_performed/:order_id/:service_id' do
	halt "Неверный id" unless params[:order_id].numeric? && params[:service_id].numeric?
	halt "Эта услуга не может быть удалена, т.к. она используется в записях" unless delete_work_performed(params);
	'Услуга удалена'
end

not_found do
	@PAGE_TITLE = "Что могло пойти не так? :("
	erb :error
end