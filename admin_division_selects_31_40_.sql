/*31. Выбрать названия всех климатических зон и, если есть 
города в зоне, то их количество.*/
SELECT ClZ.zone_name, COUNT(CASE WHEN ToS.Type_name = 'Город' THEN 1 END)
FROM Climat_zone ClZ LEFT JOIN Climat_included ClIn  
	ON ClIn.Id_climat = ClZ.ID_zone
	LEFT JOIN (
	SELECT ID_subject, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_type
	FROM Historical_subject
	) AS Subject ON Subject.ID_subject = ClIn.ID_subject
	LEFT JOIN Type_of_subject ToS ON Subject.ID_type = ToS.ID_type
GROUP BY ClZ.ID_zone, ClZ.zone_name;

/*32. Выбрать для каждой страны количество различных кли
матических зон, в которых лежат ее города, учитывать только те 
города, в которых численность более 10 000.*/
SELECT Country.Subject_name, COUNT(ClIn.ID_climat)
FROM (
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
	) AS Country
	JOIN (
	SELECT ID_subject, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject
	FROM Historical_subject
	) AS City
	ON Country.ID_subject = City.ID_parent_subject
	JOIN Climat_included ClIn 
	ON ClIn.ID_subject = City.ID_subject
	JOIN Population_census PC 
	ON PC.ID_subject = City.ID_subject
WHERE PC.year_of_census = (SELECT MAX(PC2.Year_of_census)
							FROM Population_census PC2
							WHERE PC2.ID_subject = PC.ID_subject)
	AND PC.count_of_people > 10000
GROUP BY Country.ID_subject, Country.Subject_name;
	
/*33. Выбрать названия всех стран, названия всех городов, 
фамилии, имена, отчества всех правителей и периоды правления. 
Учесть, что в БД могут быть страны без городов, города без пра
вителей и правители, которые никогда не управляли.*/
SELECT Subject.Subject_name, ToS.Type_name, Rul.rul_surname, Rul.rul_name, Rul.rul_patronimic, 
PoR.date_of_start, PoR.date_of_end
FROM (
	SELECT ID_subject, Subject_name, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_type
	FROM Historical_subject
	) AS Subject
	JOIN Type_of_subject ToS
	ON ToS.ID_type = Subject.ID_type
	LEFT JOIN Period_of_reign PoR
	ON Subject.ID_subject = PoR.ID_subject
	FULL JOIN Ruler Rul
	ON PoR.ID_ruler = Rul.ID_ruler;
	
/*34. Выбрать для каждой страны все климатические зоны.*/
SELECT Country.Subject_name, ClZ.Zone_name
FROM (
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS Country 
	JOIN Climat_included ClIn
	ON Country.ID_subject = ClIn.ID_subject
	JOIN Climat_zone ClZ
	ON ClIn.ID_climat = ClZ.ID_zone
WHERE Country.ID_parent_subject IS NULL;


/*35. Выбрать для каждой страны все климатические зоны и, 
если есть в какой-либо зоне города этой страны, то выбрать коли
чество городов.*/
SELECT Country.Subject_name, ClZ.Zone_name, COUNT(
	CASE WHEN City.ID_parent_subject IS NOT NULL THEN 1 END)
FROM (
	SELECT ID_subject, Subject_name, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_type
	FROM Historical_subject
	) AS Country 
	JOIN Type_of_subject ToS 
	ON ToS.ID_type = Country.ID_type
	AND ToS.Type_name = 'Страна'
	CROSS JOIN Climat_zone ClZ
	LEFT JOIN Climat_included ClIn
	ON ClZ.ID_zone = ClIn.ID_climat
	LEFT JOIN  (
	SELECT ID_subject, ID_parent_subject, ID_type
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, ID_parent_subject, ID_type
	FROM Historical_subject
	) AS City
	ON ClIn.ID_subject = City.ID_subject
WHERE City.ID_parent_subject = Country.ID_subject OR City.ID_parent_subject IS NULL
GROUP BY Country.Subject_name, Country.ID_subject, ClZ.Zone_name;

/*36. Выбрать пары городов с одинаковыми названиями, но из 
разных стран.*/
--добавить Петербург в США и в РФ
SELECT City1.Subject_name, City2.Subject_name
FROM (
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS City1
	CROSS JOIN (
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS City2
WHERE City1.ID_parent_subject IS NOT NULL
	AND City2.ID_parent_subject IS NOT NULL
	AND City1.Subject_name = City2.Subject_name 
	AND City1.ID_subject < City2.ID_subject 
	AND City1.ID_parent_subject != City2.ID_parent_subject;
	

/*37. Выбрать страну и названия городов, которые встречают
ся в этой стране более одного раза.*/
SELECT Country.Subject_name, City.Subject_name
FROM(
	SELECT ID_subject, Subject_name
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name
	FROM Historical_subject
	) AS Country 
	JOIN
	(
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS City
	ON City.ID_parent_subject = Country.ID_subject
GROUP BY Country.Subject_name, City.Subject_name
HAVING COUNT(City.ID_subject) > 1;

/*38. Выбрать фамилию, имя, отчество правителя, который 
правил во всех городах какой-либо страны.*/
SELECT Rul.rul_surname, Rul.rul_name, Rul.rul_patronimic
FROM Period_of_reign PoR 
	JOIN (
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS City 
	ON PoR.ID_subject = City.ID_subject
	JOIN Ruler Rul
	ON PoR.ID_ruler = Rul.ID_ruler
WHERE City.ID_parent_subject IS NOT NULL
GROUP BY Rul.rul_surname, Rul.rul_name, Rul.rul_patronimic, ID_parent_subject
HAVING COUNT(DISTINCT City.ID_subject) = (
	SELECT COUNT(allCity.ID_subject)
	FROM (
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject, Subject_name, ID_parent_subject
	FROM Historical_subject
	) AS allCity
	WHERE allCity.ID_parent_subject = City.ID_parent_subject
);

/*39. Выбрать среди правителей количество тезок с одинако
выми отчествами.*/
SELECT SUM(Ruls.Patr_count)
FROM (
	SELECT COUNT(ID_ruler) AS Patr_count
	FROM Ruler
	WHERE rul_patronimic IS NOT NULL
	GROUP BY rul_patronimic
	HAVING COUNT(ID_ruler) > 1
	) AS Ruls;

/*40. Выбрать год и количество правителей, вступивших в 
правление в этом году. Количество правителей должно быть рас
пределено по временам года. В результирующей таблице должно 
быть пять столбцов (год в первом столбце и названия времен года 
в последующих). */
SELECT EXTRACT(YEAR FROM date_of_start) AS Год, 
	COUNT(CASE WHEN EXTRACT(MONTH FROM date_of_start) IN (3,4,5) THEN 1 END) AS Весна,
	COUNT(CASE WHEN EXTRACT(MONTH FROM date_of_start) IN (6,7,8) THEN 1 END) AS Лето,
	COUNT(CASE WHEN EXTRACT(MONTH FROM date_of_start) IN (9,10,11) THEN 1 END) AS Осень,
	COUNT(CASE WHEN EXTRACT(MONTH FROM date_of_start) IN (12,1,2) THEN 1 END) AS Зима
FROM Period_of_reign
GROUP BY EXTRACT(YEAR FROM date_of_start)
ORDER BY  EXTRACT(YEAR FROM date_of_start);