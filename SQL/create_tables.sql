PRAGMA foreign_keys = on;

CREATE TABLE orders ( -- Заказы
	id INTEGER PRIMARY KEY ASC,
	client_id INTEGER NOT NULL,
	description VARCHAR(255) NOT NULL,
	order_date DATE NOT NULL,
	deadline DATE NOT NULL
);

CREATE TABLE clients ( -- Клиенты
	id INTEGER PRIMARY KEY ASC,
	first_name VARCHAR(15) NOT NULL,
	second_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	organisation VARCHAR(80) NOT NULL,
	address VARCHAR(255) NOT NULL,
	phone VARCHAR(25) NOT NULL
);

CREATE TABLE services ( -- список услуг с ценами
	id INTEGER PRIMARY KEY ASC,
	description VARCHAR(80) NOT NULL,
	price DECIMAL NOT NULL
);

CREATE TABLE work_performed ( -- выполненные работы по заказам.
	service_id INTEGER NOT NULL,
	order_id INTEGER NOT NULL,
	FOREIGN KEY (service_id) REFERENCES services(id)
	FOREIGN KEY (order_id) REFERENCES orders(id)
);