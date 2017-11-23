-- Безработные 

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) (
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

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) (
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

INSERT INTO unemployed(first_name, last_name, second_name, sex, birthdate, address, phone, married, has_children) (
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

INSERT INTO edu_inst(title) (
	'МБОУ СШ №35'
);

INSERT INTO edu_inst(title) (
	'Университет Всего И Вся'
);

INSERT INTO edu_inst(title) (
	'САФУ'
);

-- Компании

INSERT INTO companies(company_title) (
	'Почта России'
);

INSERT INTO companies(company_title) (
	'Росстат'
);

INSERT INTO companies(company_title) (
	'СЭС'
);

INSERT INTO companies(company_title) (
	'Мерия'
);

-- Профессии

INSERT INTO professions(profession) (
	'Логист'
);

INSERT INTO professions(profession) (
	'Сварщик'
);

INSERT INTO professions(profession) (
	'Повар'
);

INSERT INTO professions(profession) (
	'Супервайзер'
);

INSERT INTO professions(profession) (
	'Мерчандайзер'
);

-- Связи: Образование безработных

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, finish_year)(
	2,
	3,
	'2014'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, finish_year)(
	2,
	1,
	'2010'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, finish_year)(
	3,
	2,
	'2014'
);

INSERT INTO unemployed_education(unemployed_id, edu_inst_id, finish_year)(
	1,
	4,
	'2010'
);

-- Связи: Места работы безработных

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position)(
	1,
	1,
	'2000-11-11',
	'2015-10-11',
	'Сортировщик писем'
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position)(
	1,
	2,
	'2015-12-11',
	'2017-11-12',
	'Переносчик бумажек'
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position)(
	2,
	3,
	'2007-10-10',
	'2017-12-12',
	'Ревизорро'
);

INSERT INTO unemployed_career(unemployed_id, company_id, date_from, date_until, position)(
	3,
	4,
	'2008-10-10',
	'2017-12-12',
	'Секретарь'
);

-- Связи: Профессии безработных

INSERT INTO unemployed_professions(unemployed_id, profession_id)(
	1,
	1
);

INSERT INTO unemployed_professions(unemployed_id, profession_id)(
	1,
	2
);

INSERT INTO unemployed_professions(unemployed_id, profession_id)(
	2,
	3
);

INSERT INTO unemployed_professions(unemployed_id, profession_id)(
	3,
	4
);



