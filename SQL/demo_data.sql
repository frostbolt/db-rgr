-- Безработные 

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) VALUES (
	'Иван',
	'Иванов',
	'Иванович',
	'м',
	'1990-11-11',
	'г. Москва у. Пушкина д. Колотушкина',
	'89123456789',
	1,
	1
);

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) VALUES (
	'Марина',
	'Иванова',
	'Геннадьевна',
	'ж',
	'1991-12-12',
	'г. Москва у. Пушкина д. Колотушкина',
	'89123456789',
	1,
	1
);

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) VALUES (
	'Виктор',
	'Петров',
	'Семенович',
	'м',
	'1999-10-10',
	'г. Москва у. Пушкина д. Колотушкина',
	'89123456789',
	0,
	0
);

-- Учебные заведения

INSERT INTO edu_inst(title) VALUES (
	'МБОУ СШ №35'
);

INSERT INTO edu_inst(title) VALUES (
	'Университет Всего И Вся'
);

INSERT INTO edu_inst(title) VALUES (
	'САФУ'
);

-- Компании

INSERT INTO companies(company_title) VALUES (
	'Почта России'
);

INSERT INTO companies(company_title) VALUES (
	'Росстат'
);

INSERT INTO companies(company_title) VALUES (
	'СЭС'
);

INSERT INTO companies(company_title) VALUES (
	'Мерия'
);

-- Профессии

INSERT INTO professions(profession_title) VALUES (
	'Логист'
);

INSERT INTO professions(profession_title) VALUES (
	'Сварщик'
);

INSERT INTO professions(profession_title) VALUES (
	'Повар'
);

INSERT INTO professions(profession_title) VALUES (
	'Супервайзер'
);

INSERT INTO professions(profession_title) VALUES (
	'Мерчандайзер'
);

-- Специальности

INSERT INTO specialties(specialty_title) VALUES (
	'Прикладная математика'
);

INSERT INTO specialties(specialty_title) VALUES (
	'Медицина катастроф'
);

INSERT INTO specialties(specialty_title) VALUES (
	'Кораблестроение'
);

INSERT INTO specialties(specialty_title) VALUES (
	'Строительство'
);

INSERT INTO specialties(specialty_title) VALUES (
	'Управление качеством'
);

-- Должности

INSERT INTO positions(position_title) VALUES (
	'Сортировщик писем'
);

INSERT INTO positions(position_title) VALUES (
	'Переносчик бумажек'
);

INSERT INTO positions(position_title) VALUES (
	'Ревизорро'
);

INSERT INTO positions(position_title) VALUES (
	'Секретарь'
);

-- Связи: Образование безработных

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, specialty_id, finish_year) VALUES (
	2,
	3,
	1,
	'2014'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, specialty_id, finish_year) VALUES (
	2,
	1,
	1,
	'2010'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, specialty_id, finish_year) VALUES (
	3,
	2,
	2,
	'2014'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, specialty_id, finish_year) VALUES (
	1,
	3,
	5,
	'2010'
);

-- Связи: Места работы безработных

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position_id) VALUES (
	1,
	1,
	'2000-11-11',
	'2015-10-11',
	1
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position_id) VALUES (
	1,
	2,
	'2015-12-11',
	'2017-11-12',
	2
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position_id) VALUES (
	2,
	3,
	'2007-10-10',
	'2017-12-12',
	3
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position_id) VALUES (
	3,
	4,
	'2008-10-10',
	'2017-12-12',
	4
);

-- Связи: Профессии безработных

INSERT INTO unemployed_professions(unemployed_id, profession_id) VALUES (
	1,
	1
);

INSERT INTO unemployed_professions(unemployed_id, profession_id) VALUES (
	1,
	2
);

INSERT INTO unemployed_professions(unemployed_id, profession_id) VALUES (
	2,
	3
);

INSERT INTO unemployed_professions(unemployed_id, profession_id) VALUES (
	3,
	4
);



