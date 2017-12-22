require "sinatra"
require "sqlite3"
require 'active_support'
require 'active_support/core_ext'

@@db = SQLite3::Database.new "data.db"

Dir['./controllers/**/*.rb'].each { |file| require file }


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	@PAGE_TITLE = "Ремонт компьютеров | Главная"
	erb :index
end

get '/clients/new' do
	@PAGE_TITLE = "Новый клиент"
	erb :new_client
end

get '/services/new' do
	@PAGE_TITLE = "Новая услуга"
	erb :new_service
end

get '/orders/new' do
	@PAGE_TITLE = "Новый заказ"
	@data = {}
	@data[:clients] = all_clients
	erb :new_order
end

post '/clients/new' do
	@PAGE_TITLE = "Новый клиент"
	halt "Произошла ошибка при добвлении записи" unless new_client(params)
	'Запись добавлена'
end

post '/services/new' do
	@PAGE_TITLE = "Новая услуга"

	halt "Произошла ошибка при добвлении записи" unless new_service(params)
	'Запись добавлена'
end

post '/orders/new' do
	@PAGE_TITLE = "Новый заказ"
	halt "Произошла ошибка при добвлении записи" unless new_order(params)
	'Запись добавлена'
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
	@data[:services]=[]
	@data[:services] = all_services
	halt 404 if @data[:order] == []
	@data[:work_performed] = work_performed(params[:id])
	erb :order
end

delete '/orders/:id' do
	halt "Неверный id" unless params[:id].numeric?
	halt "Эта услуга не может быть удалена, т.к. она используется в записях" unless delete_order(params[:id]);
	'Запись удалена'
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

post '/add/performed_work/:id' do
	halt 'Неверный id' unless params[:id].numeric?
	halt 'Произошла ошибка при попытке добавить запись' unless add_work_performed(params);
	'Запись добавлена'
end

get '/report' do
	@PAGE_TITLE = "Отчет"
	halt 404 unless params[:month].numeric? && params[:month].to_i <= 12 && params[:month].to_i > 0
	@data = {}
	@data[:report] = report(params[:month])
	# data[:orders] = orders_by_month(params[:month])
	erb :report
end


not_found do
	@PAGE_TITLE = "Что могло пойти не так? :("
	erb :error
end