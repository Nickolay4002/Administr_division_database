
/*1. Выбрать все данные о странах. Результат отсортировать 
по названию в лексикографическом порядке.*/
SELECT *
FROM Existing_subject
ORDER BY Subject_name;

/*2. Выбрать все имена правителей без повторений. Результат 
отсортировать в порядке обратном лексикографическому. */
SELECT DISTINCT Rul_name
FROM Ruler
ORDER BY Rul_name DESC;

/*3. Выбрать фамилию и первую букву имени правителей, для 
которых не указано отчество. Результат отсортировать по длине 
фамилии. */
SELECT Rul_surname || ' ' || SUBSTRING(Rul_name FROM 1 FOR 1) || '.'
FROM Ruler
WHERE Rul_patronimic IS NULL
ORDER BY CHAR_LENGTH(Rul_surname);

/*4. Выбрать фамилию и инициалы правителей с двойной фа
милией и именем, начинающимся на И.*/
SELECT CONCAT(Rul_surname, ' ' , 
		SUBSTRING(Rul_name FROM 1 FOR 1) , ' ',
		SUBSTRING(Rul_patronimic FROM 1 FOR 1), ' ', 
		SUBSTRING(Rul_second_name FROM 1 FOR 1))
FROM Ruler
WHERE Rul_surname LIKE('%-%') AND NOT  Rul_surname LIKE ('%-%-%') AND Rul_name LIKE('И%');

/*5. Выбрать название и описание климата. В результат долж
ны войти такие данные, в описании которых есть окончание  
«-кий» и нет символов «%», «*», «$».*/
SELECT Zone_name, Description
FROM Climat_zone
WHERE Description LIKE('%_кий%') AND Description NOT SIMILAR TO '%(\%|\*|\$)%';

/*6. Выбрать фамилию и инициалы правителя с именем из 
двух букв и c id равным 3, 4, 6, 1, 20. Результат отсортировать по 
фамилии в лексикографическом порядке, по имени и отчеству в 
порядке обратном лексикографическому.*/
SELECT CONCAT(Rul_surname, ' ' , 
		SUBSTRING(Rul_name FROM 1 FOR 1) , ' ',
		SUBSTRING(Rul_patronimic FROM 1 FOR 1), ' ', 
		SUBSTRING(Rul_second_name FROM 1 FOR 1)),ID_RULER
FROM Ruler
WHERE /*CHAR_LENGTH(Rul_name) = 2 AND*/ ID_ruler IN(3,4,6,1,20)
ORDER BY Rul_surname, Rul_name DESC, Rul_patronimic DESC;

/*7. Выбрать названия стран с id из диапазона от 2 до 13.*/
SELECT Subject_name, ID_subject
FROM Existing_subject 
WHERE ID_type = (
		SELECT id_type 
		FROM type_of_subject
		WHERE type_name = 'Страна' 
	) AND ID_Subject BETWEEN 2 AND 13
UNION ALL
SELECT Subject_name, ID_subject
FROM Historical_subject
	WHERE ID_type = (
		SELECT id_type
		FROM type_of_subject
		WHERE type_name = 'Страна'
	 	) AND ID_Subject BETWEEN 2 AND 13;

/*8. Выбрать название города в одном столбце, а в другом 
столбце тип города: малый – до 50 тыс. человек, средний – от 50 
до 100 тыс. человек, большой – от 100 до 250 тыс. человек, круп
ный – от 250 до 1 млн человек, крупнейший (миллионер) – более 
1млн человек. Результат отсортировать по численности в убы
вающем порядке.*/


/*9. Выбрать дату основания старейшего города.*/
SELECT MIN(date_of_foundation) as The_oldest_city
FROM
	(SELECT MIN(date_of_foundation) as date_of_foundation
	FROM Existing_subject
	WHERE id_type = (
		SELECT id_type
		FROM type_of_subject
		WHERE type_name = 'Город'
	 	)
	UNION ALL
	SELECT MIN(date_of_foundation) as date_of_foundation
	FROM Historical_subject
	WHERE id_type = (
		SELECT id_type
		FROM type_of_subject
		WHERE type_name = 'Город'
	 	));

/*10. Выбрать дату основания самого молодого города
миллионера.*/
SELECT MAX(date_of_foundation)
FROM
	(SELECT MAX(E.date_of_foundation) as date_of_foundation
	FROM Existing_subject E JOIN Population_census PC 
		ON E.ID_Subject = PC.ID_Subject
	WHERE E.id_type = (
		SELECT id_type
		FROM type_of_subject
		WHERE type_name = 'Город'
	 	) AND PC.Count_of_people > 1000000
		 	AND NOT EXISTS (SELECT 1
			 				FROM Population_census
							WHERE year_of_census < PC.year_of_census AND count_of_people < 1000000)
	UNION ALL
	SELECT MAX(H.date_of_foundation) as date_of_foundation
	FROM Historical_subject H JOIN Population_census PC 
		ON H.ID_Subject = PC.ID_Subject
	WHERE H.id_type = (
		SELECT id_type
		FROM type_of_subject
		WHERE type_name = 'Город'
	 	) AND PC.Count_of_people > 1000000
		 	AND NOT EXISTS (SELECT 1
			 				FROM Population_census
							WHERE year_of_census < PC.year_of_census AND count_of_people < 1000000)
);