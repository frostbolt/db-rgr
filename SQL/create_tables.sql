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
	company_title VARCHAR(50) NOT NULL
);

CREATE TABLE professions ( -- Профессии.
	id INTEGER PRIMARY KEY ASC,
	profession_title VARCHAR(50) NOT NULL
);

CREATE TABLE specialties ( -- Специальности.
	id INTEGER PRIMARY KEY ASC,
	specialty_title VARCHAR(100) NOT NULL
);

CREATE TABLE positions ( -- Должности.
	id INTEGER PRIMARY KEY ASC,
	position_title VARCHAR(50) NOT NULL
);

CREATE TABLE unemployed_education ( -- Сведения об образовании.
	unemployed_id INTEGER NOT NULL,
	edu_inst_id INTEGER NOT NULL,
	specialty_id INTEGER NOT NULL,
	finish_year VARCHAR(4) NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (edu_inst_id) REFERENCES edu_inst(id)
	FOREIGN KEY (specialty_id) REFERENCES specialties(id)
);

CREATE TABLE unemployed_career ( -- Сведения о местах работы безработных.
	unemployed_id INTEGER NOT NULL,
	company_id INTEGER NOT NULL,
	date_from DATE NOT NULL,
	date_until DATE NOT NULL,
	position_id INTEGER NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (company_id) REFERENCES companies(id)
	FOREIGN KEY (position_id) REFERENCES positions(id)
);

CREATE TABLE unemployed_professions ( -- Сведения о профессиях безработных.
	unemployed_id INTEGER NOT NULL,
	profession_id INTEGER NOT NULL,
	FOREIGN KEY (unemployed_id) REFERENCES unemployed(id)
	FOREIGN KEY (profession_id) REFERENCES professions(id)
);