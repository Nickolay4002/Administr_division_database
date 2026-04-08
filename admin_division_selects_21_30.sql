/*21. Выбрать год и количество городов, основанных в этот 
год. Результат отсортировать по году в убывающем порядке. */
SELECT EXTRACT(YEAR FROM Cities.date_of_foundation) AS Год, COUNT(Cities.ID_subject) AS Кол_во_городов
FROM (
	SELECT ID_subject,ID_type, date_of_foundation
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject,ID_type, date_of_foundation
	FROM Historical_subject
) AS Cities JOIN Type_of_subject ToS
ON Cities.ID_type = ToS.ID_type
WHERE ToS.type_name = 'Город'
GROUP BY EXTRACT(YEAR FROM Cities.date_of_foundation)
ORDER BY EXTRACT(YEAR FROM Cities.date_of_foundation) DESC;

/*22. Выбрать название страны, название города и количество 
правителей, правивших в городе.*/
SELECT Countries.Subject_name AS Страна, Cities.Subject_name AS Город, COUNT(DISTINCT PoR.ID_ruler)
FROM (
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Historical_subject
) AS Cities JOIN 
(
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
) AS Countries ON Cities.ID_parent_subject = Countries.ID_subject
	JOIN Period_of_reign PoR ON Cities.ID_subject = PoR.ID_subject
GROUP BY Countries.Subject_name, Countries.ID_Subject, Cities.Subject_name, Cities.ID_Subject;

/*23. Выбрать id и название административно
территориальной единицы, фамилию, имя, отчество текущего 
правителя и количество правивших правителей. В результат 
должны войти только города старше 250 лет.*/
SELECT Subject.Subject_name AS Субъект,Rul.rul_surname, Rul.rul_name, Rul.rul_patronimic, COUNT(DISTINCT PoR.ID_ruler)
FROM (
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Historical_subject
) AS Subject
	JOIN Period_of_reign PoR ON Subject.ID_subject = PoR.ID_subject
	JOIN Period_of_reign PoR_curr ON Subject.ID_subject = PoR_curr.ID_subject 
	JOIN Ruler Rul ON PoR_curr.ID_ruler = Rul.ID_ruler
WHERE PoR_curr.date_of_end IS NULL OR PoR_curr.date_of_end > CURRENT_DATE
GROUP BY Subject.Subject_name, Subject.ID_Subject, Rul.rul_surname, Rul.rul_name, Rul.rul_patronimic;

/*24. Для каждого города найти средний возраст его правите
лей в XVIII веке.*/
SELECT Subject.Subject_name, AVG((PoR.date_of_end - PoR.date_of_start) / 2 + PoR.date_of_start - Rul.date_of_birth)
FROM (
	SELECT ID_subject, ID_type, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_type, Subject_name
	FROM Historical_subject
	) AS Subject ON Subject.ID_subject = ClIn.ID_subject
	JOIN Type_of_subject ToS ON Subject.ID_type = ToS.ID_type
	JOIN Period_of_reign PoR ON Subject.ID_subject = PoR.ID_subject
	JOIN Ruler Rul ON PoR.ID_ruler = Rul.ID_ruler
WHERE ToS.Type_name = 'Город' AND Por.date_of_start > '01.01.1700'::DATE
	AND PoR.date_of_end < '01.01.1800'::DATE
GROUP BY Subject.Subject_name, Subject.ID_subject;


/*25. Выбрать название климатической зоны, в которой лежит 
только один город.*/
--Заинсертить Якутск(?)
SELECT ClZ.zone_name
FROM Climat_included ClIn JOIN Climat_zone ClZ
	ON ClIn.Id_climat = ClZ.ID_zone
	JOIN (
	SELECT ID_subject, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_type
	FROM Historical_subject
	) AS Subject ON Subject.ID_subject = ClIn.ID_subject
	JOIN Type_of_subject ToS ON Subject.ID_type = ToS.ID_type
WHERE ToS.Type_name = 'Город'
GROUP BY ClZ.ID_zone, ClZ.zone_name
HAVING COUNT(ClIn.ID_subject) = 1;

/*26. Выбрать название страны, название города, в которых 
было более 5 правителей. Результат отсортировать по названию 
страны и названию города в порядке обратном лексикографиче
скому.*/
--ДОБАВИТЬ 5 ПРАВИТЕЛЕЙ МСК
SELECT Countries.Subject_name AS Страна, Cities.Subject_name AS Город 
FROM (
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Historical_subject
) AS Cities JOIN 
(
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
) AS Countries ON Cities.ID_parent_subject = Countries.ID_subject
	JOIN Period_of_reign PoR ON Cities.ID_subject = PoR.ID_subject
GROUP BY Countries.Subject_name, Countries.ID_Subject, Cities.Subject_name, Cities.ID_Subject
HAVING COUNT(PoR.ID_ruler) > 5;

/*27. Для климатических зон, в которых более одного города, 
выбрать название климатической зоны и количество городов в 
этой зоне. В результат должны войти города России, США, Китая, 
Канады, Бразилии и Индии.*/
--ДОБАВИТЬ БЛЬШЕ ГОРОДОВ(?) в разных зонах, оставить арктическую для Якутска
SELECT ClZ.zone_name, COUNT(ClIn.ID_subject)
	--Subject.Subject_name
FROM Climat_included ClIn JOIN Climat_zone ClZ
	ON ClIn.Id_climat = ClZ.ID_zone
	JOIN (
	SELECT ID_subject, Subject_name, ID_type, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_type, ID_parent_subject
	FROM Historical_subject
	) AS Subject ON Subject.ID_subject = ClIn.ID_subject
	JOIN Type_of_subject ToS ON Subject.ID_type = ToS.ID_type
WHERE ToS.Type_name = 'Город' AND Subject.ID_parent_subject IN(
	SELECT PSubject.ID_Subject
	FROM (
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
	) AS PSubject
	WHERE PSubject.Subject_name IN('Российская Федерация', 
				'Китайская Народная Республика', 
				'Соединенные Штаты Америки',
				'Федеративная Республика Бразилия',
				'Канада',
				'Республика Индия')
)
GROUP BY ClZ.ID_zone, ClZ.zone_name
HAVING COUNT(ClIn.ID_subject) > 1;

/*28. Выбрать фамилию и имя (без отчества) правителей, 
управлявших за время своей жизни двумя и более городами.*/
SELECT Rul.rul_surname, Rul.rul_name
FROM Ruler Rul JOIN Period_of_reign PoR
ON Rul.ID_ruler = PoR.ID_ruler
GROUP BY Rul.ID_ruler, Rul.rul_surname, Rul.rul_surname
HAVING COUNT(DISTINCT PoR.ID_subject) > 1;

/*29. Выбрать название города, в котором один правитель 
правил три срока и более.*/
--добавить данные
SELECT Subject.Subject_name
FROM (
	SELECT ID_subject,  Subject_name, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject,  Subject_name, ID_type
	FROM Historical_subject
) AS Subject JOIN Type_of_subject ToS 
ON Subject.ID_type = ToS.ID_type
JOIN Period_of_reign PoR ON Subject.ID_subject = PoR.ID_subject
WHERE ToS.Type_name = 'Город'
GROUP BY Subject.ID_subject, Subject.Subject_name, PoR.ID_ruler
HAVING COUNT(PoR.ID_period) > 2;

/*30. Выбрать названия всех стран и, если есть города в стра
не, то названия городов.*/
--ДОБАВТЬ СТРАНУ БЕЗ ГОРОДОВ
SELECT Countries.Subject_name AS Страна, Cities.Subject_name AS Город 
FROM (
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject, Subject_name
	FROM Historical_subject
) AS Cities LEFT JOIN 
(
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
) AS Countries ON Cities.ID_parent_subject = Countries.ID_subject;