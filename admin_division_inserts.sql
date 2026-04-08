

--ТИПЫ--
INSERT INTO Type_of_subject(ID_type, Type_name) VALUES 
	(1, 'Страна'),
	(4, 'Город');
--КЛИМАТЫ--
INSERT INTO Climat_zone(ID_zone, Zone_name, Description) VALUES
	(DEFAULT, 'Умеренный', 'Умеренному климату присущи частые и сильные изменения атмосферного давления, температуры воздуха и направления ветра, происходящие из-за интенсивной деятельности циклонов.'),
	(DEFAULT, 'Полярный', 'Характеризуется круглогодичными отрицательными температурами воздуха и скудными осадками (100—200 мм в год)'),
	(DEFAULT, 'Экваториальный','Характеризуется слабыми ветрами, очень малыми колебаниями средней месячной температуры (до 2 °С), высокой влажностью воздуха и облачностью.'),
	(DEFAULT, 'Тропический','В такой местности свойственны высокие температуры (среднегодовые от 21 °C до 30 °C). Количество осадков здесь может достигать более 100 дюймов (2540 мм) в год, более 9-ти месяцев в год здесь идет дождь.');
INSERT INTO Climat_zone(ID_zone, Zone_name, Description) VALUES
    (DEFAULT, 'Субтропический', 'Характеризуется сменой умеренного воздуха летом и тропического зимой. Лето жаркое и сухое, зима мягкая и влажная.');

INSERT INTO Climat_zone(ID_zone, Zone_name, Description) VALUES
	(DEFAULT, 'Марсианский', '100% не встречается на Земле. Марсианский климат бывает только на Марсе.'),
	(DEFAULT, 'Душный','Он же ботанский. Характеризуется желанием уснуть на паре. Существует здесь только из-за запроса.');
	
	
--ПРАВИТЕЛИ--
INSERT INTO Ruler(ID_ruler, Rul_surname, Rul_name, Rul_second_name, Rul_patronimic, Date_of_birth, Date_of_death) VALUES
	(DEFAULT, 'Рюрикович','Иван III',NULL,'Васильевич','1440-01-22'::date,'1505-10-27'::date),
	(DEFAULT, 'Путин','Владимир',NULL,'Владимирович','1952-05-07'::date,NULL),
	(DEFAULT, 'Трамп', 'Дональд','Джон',NULL,'1946-06-14'::DATE,NULL),
	(DEFAULT, 'Си','Цзиньпин',NULL,NULL,'1953-06-15'::DATE,NULL);
INSERT INTO Ruler(ID_ruler, Rul_surname, Rul_name, Rul_second_name, Rul_patronimic, Date_of_birth, Date_of_death) VALUES
	(DEFAULT, 'Нунеш','Рикарду',NULL,NULL,'1967-11-13'::DATE,NULL), --Сан-паулу
	(DEFAULT, 'Баузер', 'Мюриел','Элизабет',NULL,'1972-08-02'::DATE,NULL), --Вашингтон
	(DEFAULT, 'Басс', 'Карен','Рут',NULL,'1953-10-03'::DATE,NULL), --Лос-Анджелес
	(DEFAULT, 'Собянин','Сергей',NULL,'Семенович','1958-06-21'::DATE,NULL), --Пермь
	(DEFAULT, 'Соснин','Эдуард',NULL,'Олегович','1982-11-27'::DATE,NULL); --Москва
INSERT INTO Ruler(ID_ruler, Rul_surname, Rul_name, Rul_second_name, Rul_patronimic, Date_of_birth, Date_of_death) VALUES
    (DEFAULT, 'Инь', 'Юн', NULL, NULL, '1969-08-01'::DATE, NULL), --Пекин
    (DEFAULT, 'Гун', 'Чжэн', NULL, NULL, '1960-03-01'::DATE, NULL); --Шанхай
INSERT INTO Ruler(ID_ruler, Rul_surname, Rul_name, Rul_second_name, Rul_patronimic, Date_of_birth, Date_of_death) VALUES
    (DEFAULT, 'Трюдо', 'Джастин', 'Пьер Джеймс', NULL, '1971-12-25'::DATE, NULL), --Премьер-министр Канады
    (DEFAULT, 'Чоу', 'Оливия', NULL, NULL, '1957-03-24'::DATE, NULL),            --Торонто
    (DEFAULT, 'Планте', 'Валери', NULL, NULL, '1974-06-14'::DATE, NULL);         --Монреаль
INSERT INTO Ruler(ID_ruler, Rul_surname, Rul_name, Rul_second_name, Rul_patronimic, Date_of_birth, Date_of_death) VALUES
    --Индия
    (DEFAULT, 'Моди', 'Нарендра', 'Дамодардас', NULL, '1950-09-17'::DATE, NULL),
    (DEFAULT, 'Оберой', 'Шелли', NULL, NULL, '1983-01-01'::DATE, NULL), --Дели
    (DEFAULT, 'Чахал', 'Икбал', 'Сингх', NULL, '1966-01-20'::DATE, NULL), --Мумбаи
    --Бразилия
    (DEFAULT, 'да Силва', 'Луис', 'Инасиу Лула', NULL, '1945-10-27'::DATE, NULL);



--СУБЪЕКТЫ АДМИНИСТРАТИВНОГО ДЕЛЕНИЯ--	
--СТРАНЫ--
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,ID_type,
		Date_of_foundation) VALUES(
	(SELECT max(ID_subject) FROM Subject_key),
	NULL,
	'Российская Федерация',
	(SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
	'1995-12-25'::date
);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		NULL,
		'Китайская Народная Республика',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
		'1949-10-01'::DATE
		);
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		NULL,
		'Соединенные Штаты Америки',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
		'1776-07-04'::DATE
		);
SELECT * FROM Existing_subject;
SELECT * FROM Subject_key;
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		NULL,
		'Федеративная Республика Бразилия',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
		'1822-09-07'::DATE
		);
		
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Historical_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation,
		Date_of_disappearing) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		NULL,
		'Русское государство',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
		'1478-01-01'::DATE,
		'1721-08-30'::DATE
		);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    NULL,
    'Канада',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
    '1867-07-01'::DATE
);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    NULL,
    'Республика Индия',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Страна'),
    '1947-08-15'::DATE
);





--ГОРОДА--
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'),
		'Переяславль-Залесский',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'962-01-01'::DATE	
		);
INSERT INTO Subject_historical_parents VALUES(
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Переяславль-Залесский'),
	(SELECT ID_subject FROM Historical_subject WHERE Subject_name='Русское государство')
);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'),
		'Москва',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'1147-01-01'::DATE
		);

INSERT INTO Subject_historical_parents VALUES(
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Москва'),
	(SELECT ID_subject FROM Historical_subject WHERE Subject_name='Русское государство')
);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'),
		'Пермь',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'1723-05-04'::DATE
		);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'),
		'Вашингтон',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'1790-01-01'::DATE
		);
INSERT INTO Subject_key VALUES (DEFAULT);
SELECT * FROM Subject_key;
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'),
		'Лос-Анджелес',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'1781-09-04'::DATE
		);
		
INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject,
		ID_parent_subject,
		Subject_name,
		ID_type,
		Date_of_foundation) VALUES(
		(SELECT max(ID_subject) FROM Subject_key),
		(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'),
		'Сан-Паулу',
		(SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
		'1554-01-25'::DATE
		);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'),
    'Пекин',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1045-01-01'::DATE 
);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'),
    'Шанхай',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1291-01-01'::DATE
);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'),
    'Торонто',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1793-08-27'::DATE
);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'),
    'Монреаль',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1642-05-17'::DATE
);

INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'),
    'Нью-Дели',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1911-12-15'::DATE
);


INSERT INTO Subject_key VALUES (DEFAULT);
INSERT INTO Existing_subject(ID_subject, 
	ID_parent_subject, 
	Subject_name, 
	ID_type, 
	Date_of_foundation) VALUES(
    (SELECT max(ID_subject) FROM Subject_key),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'),
    'Мумбаи',
    (SELECT ID_type FROM Type_of_subject WHERE Type_name='Город'),
    '1507-01-01'::DATE
);

--ПЕРИОДЫ (У)ПРАВЛЕНИЯ--	
--Страны--
INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_Surname='Путин'),
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'),
	'2000-05-07'::DATE,
	'2008-05-07'::DATE
);
INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_Surname='Путин'),
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'),
	'2000-05-07'::DATE,
	'2008-05-07'::DATE
);
SELECT * FROM PERIOD_OF_REIGN;
DELETE FROM PERIOD_OF_REIGN WHERE ID_PERIOD = 4;

INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_surname='Рюрикович'),
	(SELECT ID_subject FROM Historical_subject WHERE Subject_name='Русское государство'),
	'1462-03-28'::DATE,
	'1505-10-27'::DATE
);

INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_surname='Трамп'),
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'),
	'2017-01-20'::DATE,
	'2021-01-20'::DATE
);
INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_surname='Трамп'),
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'),
	'2025-01-20'::DATE,
	NULL
);

INSERT INTO Period_of_reign VALUES (
	DEFAULT,
	(SELECT ID_ruler FROM Ruler WHERE rul_surname='Си'),
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'),
	'2013-03-14'::DATE,
	NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Трюдо' AND Rul_name='Джастин'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'),
    '2015-11-04'::DATE,
    NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Моди' AND Rul_name='Нарендра'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'),
    '2014-05-26'::DATE,
    NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='да Силва' AND Rul_name='Луис'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'),
    '2023-01-01'::DATE,
    NULL
);



--Города--

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname = 'Нунеш' AND Rul_name = 'Рикарду'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name = 'Сан-Паулу'),
    '2021-05-16'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname = 'Баузер' AND Rul_name = 'Мюриел'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name = 'Вашингтон'),
    '2015-01-02'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname = 'Басс' AND Rul_name = 'Карен'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name = 'Лос-Анджелес'),
    '2022-12-12'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname = 'Собянин' AND Rul_name = 'Сергей'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name = 'Москва'),
    '2010-10-21'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname = 'Соснин' AND Rul_name = 'Эдуард'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name = 'Пермь'),
    '2023-08-28'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Инь' AND Rul_name='Юн'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Пекин'),
    '2022-10-28'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Гун' AND Rul_name='Чжэн'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Шанхай'),
    '2020-03-23'::DATE, 
    NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Чоу' AND Rul_name='Оливия'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Торонто'),
    '2023-07-12'::DATE,
    NULL
);

INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Планте' AND Rul_name='Валери'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Монреаль'),
    '2017-11-16'::DATE,
    NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Оберой' AND Rul_name='Шелли'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Нью-Дели'),
    '2023-02-22'::DATE,
    NULL
);


INSERT INTO Period_of_reign VALUES (
    DEFAULT,
    (SELECT ID_ruler FROM Ruler WHERE Rul_surname='Чахал' AND Rul_name='Икбал'),
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Мумбаи'),
    '2020-05-08'::DATE,
    NULL
);


--КЛИМАТИЧЕСКИЕ ЗОНЫ С ПРИВЯЗКОЙ К СУБЪЕКТУ-- --STOPPED HERE--

--СТРАЫН--

--Российская Федерация 
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-05-10'::DATE);
	
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Полярный'), 
	'2023-05-10'::DATE);

--Соединенные Штаты Америки
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2022-11-15'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Тропический'), 
	'2022-11-15'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2022-11-15'::DATE);

--Федеративная Республика Бразилия
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Экваториальный'), 
	'2024-01-20'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Тропический'), 
	'2024-01-20'::DATE);

--Китайская Народная Республика 
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-08-12'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2023-08-12'::DATE);

--Республика Индия 
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Тропический'), 
	'2024-03-01'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2024-03-01'::DATE);

--Канада
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2026-02-20'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Полярный'), 
	'2026-02-20'::DATE);

--ГОРОДА--

-- Россия
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Москва'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-12-01'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Пермь'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-12-01'::DATE);

-- США
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Вашингтон'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-10-10'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Лос-Анджелес'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2023-10-10'::DATE);

-- Бразилия
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Сан-Паулу'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Тропический'), 
	'2024-02-15'::DATE);

-- Китай
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Пекин'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
	'2023-07-20'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Шанхай'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2023-07-20'::DATE);

-- Индия
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Нью-Дели'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Субтропический'), 
	'2024-04-05'::DATE);
INSERT INTO Climat_included VALUES (
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Мумбаи'), 
	(SELECT ID_zone FROM Climat_zone WHERE Zone_name='Тропический'), 
	'2024-04-05'::DATE);


--Канада
INSERT INTO Climat_included VALUES (
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Торонто'), 
    (SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
    '2026-02-18'::DATE
);
INSERT INTO Climat_included VALUES (
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Монреаль'), 
    (SELECT ID_zone FROM Climat_zone WHERE Zone_name='Умеренный'), 
    '2026-02-15'::DATE
);



--ПЕРЕПИСИ НАСЕЛЕНИЯ (ЧИСЛЕННОСТЬ)--

--СТРАНЫ--

--Российская Федерация
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'), 
	146890000, 
	2010);
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'), 
	146150000, 
	2021);

--Соединенные Штаты Америки
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
	308745000,
	2010);
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
	331449000, 
	2020);

---Китайская Народная Республика
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'), 
	1339724000, 
	2010);
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'), 
	1411750000, 
	2020);

--Республика Индия
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'), 
	1210854000, 
	2011);
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'), 
	1408000000, 
	2021);

--Федеративная Республика Бразилия
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'), 
	190755000, 
	2010);
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'), 
	203062000, 
	2022);

--Канада
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'), 
	35151000, 
	2016);
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'), 
	38246000, 
	2021);

--ГОРОДА--

--Россия
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Москва'), 
	13104000, 
	2023);
INSERT INTO Population_census VALUES (
	DEFAULT, (
	SELECT ID_subject FROM Existing_subject WHERE Subject_name='Пермь'), 
	1027000, 
	2023);

--США
INSERT INTO Population_census VALUES (
	DEFAULT, (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Вашингтон'), 
	671000, 
	2022);
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Лос-Анджелес'), 
	3822000,
	2022);

--Китай
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Пекин'), 
	21893000, 
	2020);
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Шанхай'), 
	24870000, 
	2020);

--Индия
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Нью-Дели'), 
	250000, 
	2021);
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Мумбаи'), 
	12442000, 
	2011);

--Бразилия
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Сан-Паулу'), 
	12330000, 
	2022);

-- -анада
INSERT INTO Population_census VALUES (
	DEFAULT, 
	(SELECT ID_subject FROM Existing_subject WHERE Subject_name='Торонто'), 
	2794000, 
	2021);
INSERT INTO Population_census VALUES (
	DEFAULT, (
	SELECT ID_subject FROM Existing_subject WHERE Subject_name='Монреаль'), 
	1762000, 
	2021);


--ПлОЩАДИ--
---Российская Федерация 
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Российская Федерация'), 
    17125191.0, 
    '2023-01-01'::DATE
);

---Москва (Уточнение площади после расширения «Новой Москвы»)
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Москва'), 
    2561.5, 
    '2012-07-01'::DATE
);

---Соединенные Штаты Америки 
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Соединенные Штаты Америки'), 
    9833517.0, 
    '2020-11-20'::DATE
);

--- Китайская Народная Республика
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Китайская Народная Республика'), 
    9596961.0, 
    '2023-08-28'::DATE
);

--Республика Индия (Данные после демаркации границ)
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Республика Индия'), 
    3287263.0, 
    '2024-05-15'::DATE
);

---Канада (Официальное уточнение площади суши и озер)
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Канада'), 
    9984670.0, 
    '2021-01-01'::DATE
);

---Федеративная Республика Бразилия
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Федеративная Республика Бразилия'), 
    8515767.0, 
    '2022-10-10'::DATE
);

--Шанхай (Рост города за счет намывных территорий к 2026 году)
INSERT INTO Area_change (ID_change, ID_subject, Area_size, Date_of_change) VALUES (
    DEFAULT, 
    (SELECT ID_subject FROM Existing_subject WHERE Subject_name='Шанхай'), 
    6340.5, 
    '2025-12-31'::DATE
);




