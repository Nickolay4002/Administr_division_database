/*11. Выбрать средний срок правления правителей города с 
id = 2.*/
SELECT AVG(date_of_end - date_of_start)
FROM Period_of_reign PoR
WHERE PoR.id_subject = 2 AND EXISTS(
	SELECT 1
	FROM (
		SELECT id_type
		FROM Existing_subject
		WHERE id_subject = PoR.id_subject
			AND id_type = (
				SELECT id_type
				FROM type_of_subject
				WHERE type_name = 'Город'
			)
		UNION ALL
		SELECT id_type
		FROM Historical_subject
		WHERE id_subject = PoR.id_subject
			AND id_type = (
				SELECT id_type
				FROM type_of_subject
				WHERE type_name = 'Город'
			)
	)
);
/*12. Выбрать общее количество городов страны с id = 3.*/
SELECT COUNT(*)
FROM (
	SELECT ID_parent_subject
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)
	UNION ALL
	SELECT ID_parent_subject
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)) Cities 
WHERE Cities.ID_parent_subject = 3;


/*13. Выбрать количество различных имен правителей. */
SELECT COUNT(DISTINCT rul_name)
FROM Ruler;

/*14. Выбрать климатические зоны, в описании которых нет 
%. Результат отсортировать следующим образом: в первую оче
редь климатические зоны с четным id.*/
SELECT ID_zone, Zone_name, Description
FROM Climat_zone
WHERE Description NOT SIMILAR TO '%(\%)%'
ORDER BY id_zone % 2 ASC, id_zone ASC;

/*15. Выбрать название страны, идущей первой по списку, 
упорядоченному по названию в лексикографическом порядке. */
SELECT Subject_name
FROM (
	SELECT Subject_name
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)
	UNION ALL
	SELECT SUbject_name
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)
) 
ORDER BY Subject_name
LIMIT 1;

/*16. Выбрать название, численность населения территори
альной единицы, которой управлял Иванов Иван Иванович.*/
SELECT S.Subject_name, PC.count_of_people
FROM Ruler R JOIN 
Period_of_reign PoR ON R.id_ruler = PoR.id_ruler
	JOIN
	(
		SELECT Subject_name, (id_subject) as ID_
		FROM Existing_subject
		UNION ALL
		SELECT Subject_name, (id_subject) as ID_
		FROM Historical_subject
	) S ON PoR.id_subject = S.ID_
	LEFT JOIN Population_census PC
		ON S.ID_ = PC.id_subject 
WHERE R.rul_surname = 'Иванов' AND 
	 	R.rul_name = 'Иван' AND
		R.rul_patronimic = 'Иванович' AND
	NOT EXISTS(
		SELECT 1
		FROM Population_census
		WHERE year_of_census < PC.year_of_census
	);
		
/*17. Выбрать название страны, название города, фамилию, 
имя, отчество правителя и период правления. Результат отсорти
ровать по названию страны в лексикографическом порядке, по на
званию города в порядке обратном лексикографическому, по дате 
вступления в должность правления в возрастающем порядке.*/
SELECT (Country.Subject_name) as Country, (City.Subject_name) as City, 
		R.rul_surname, R.rul_name, R.rul_patronimic, 
	   (PoR.date_of_start) as Reign_start, (PoR.date_of_end) as Reign_end
FROM (
	SELECT Subject_name, ID_subject
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)
	UNION ALL
	SELECT Subject_name, ID_subject
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)
	) Country JOIN 
	(
	SELECT Subject_name, ID_subject, ID_parent_subject
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)
	UNION ALL
	SELECT Subject_name, ID_subject, ID_parent_subject
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)
	) City ON Country.ID_subject = City.ID_parent_subject
	JOIN Period_of_reign PoR 
	ON PoR.id_subject = City.ID_subject
	JOIN Ruler R ON PoR.id_ruler = R.id_ruler
ORDER BY Country.Subject_name ASC, City.Subject_name DESC, PoR.date_of_start ASC;
	

/*18. Выбрать название города и фамилию, имя, отчество те
кущего правителя для российских городов. Результат отсортиро
вать по названию города в лексикографическом порядке.*/
SELECT Es.Subject_name, R.Rul_surname, R.Rul_name, R.Rul_patronimic
FROM Ruler R JOIN Period_of_reign PoR ON R.id_ruler = PoR.id_ruler
			 JOIN  Existing_subject Es ON PoR.id_subject = Es.ID_subject
WHERE PoR.date_of_end IS NULL AND Es.id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		) AND
		Es.id_parent_subject = (
			SELECT ID_subject
			FROM Existing_subject
			WHERE Subject_name = 'Российская Федерация'
		);

/*19. Выбрать фамилию и инициалы правителей, которые пра
вили в прошлом веке. В результат должны войти правители в воз
расте от 25 до 45 лет.*/
SELECT CONCAT(R.Rul_surname, ' ' , 
		SUBSTRING(R.Rul_name FROM 1 FOR 1) , ' ',
		SUBSTRING(R.Rul_patronimic FROM 1 FOR 1), ' ', 
		SUBSTRING(R.Rul_second_name FROM 1 FOR 1)) as Ruler_full_name
FROM Ruler R JOIN Period_of_reign PoR
	ON R.id_ruler = PoR.id_ruler
WHERE PoR.date_of_start > '01-01-1900'::DATE AND PoR.date_of_end < '01-01-2000'::DATE 
	AND R.date_of_birth + INTERVAL '25 years' <= PoR.date_of_start
	AND R.date_of_birth + INTERVAL '45 years' >= PoR.date_of_end;

/*20. Выбрать название страны и количество городов в этой 
стране. Результат отсортировать по названию страны в лексико
графическом порядке.*/
SELECT Countries.Subject_name, COUNT(Cities.ID_parent_subject)
FROM (
	SELECT ID_parent_subject
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)
	UNION ALL
	SELECT ID_parent_subject
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Город'
		)) Cities JOIN
	(SELECT Subject_name, ID_subject
	FROM Existing_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)
	UNION ALL
	SELECT Subject_name, ID_subject
	FROM Historical_subject
	WHERE id_type = (
			SELECT id_type
			FROM type_of_subject
			WHERE type_name = 'Страна'
		)) Countries 
	ON Countries.ID_subject= Cities.ID_parent_subject
GROUP BY (Countries.Subject_name), Countries.ID_subject
ORDER BY (Countries.Subject_name);