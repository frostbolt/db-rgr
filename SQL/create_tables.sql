PRAGMA foreign_keys = on;

CREATE TABLE unemployed ( -- Безработные.
	id INTEGER PRIMARY KEY ASC,
	first_name VARCHAR(15) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	second_name VARCHAR(20) NOT NULL,
	sex CHAR(1) NOT NULL,
	birthdate DATE NOT NULL,
	address TEXT NOT NULL,
	phone VARCHAR(20) NOT NULL,
	married BOOLEAN NOT NULL,
	has_children BOOLEAN NOT NULL,
	registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE edu_inst ( -- Учебные заведения.
	id INTEGER PRIMARY KEY ASC,
	title VARCHAR(100) NOT NULL
);

CREATE TABLE companies ( -- Компании.
	id INTEGER PRIMARY KEY ASC,
	company_title VARCHAR(50) NOT NULL,
);

CREATE TABLE professions ( -- Профессии.
	id INTEGER PRIMARY KEY ASC,
	profession VARCHAR(50) NOT NULL,
);

CREATE TABLE unemployed_education ( -- Сведения об образовании.
	unemployed_id INT NOT NULL,
	edu_inst_id INT NOT NULL,
	finish_year VARCHAR(4) NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (edu_inst_id) REFERENCES edu_inst(id)
);

CREATE TABLE unemployed_career ( -- Сведения о местах работы безработных.
	unemployed_id INT NOT NULL,
	company_id INT NOT NULL,
	date_from DATE NOT NULL,
	date_until DATE NOT NULL,
	position VARCHAR(50) NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (company_id) REFERENCES companies(id)
);

CREATE TABLE unemployed_professions ( -- Сведения о профессиях безработных.
	unemployed_id INT NOT NULL,
	profession_id INT NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (profession_id) REFERENCES professions(id)
);