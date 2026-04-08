/*41. Выбрать название старейшего города.*/
SELECT City.Subject_name 
FROM (
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation
	FROM Historical_subject
	) AS City
	JOIN Type_of_subject ToS
	ON ToS.ID_type = City.ID_type
WHERE ToS.Type_name = 'Город' AND City.date_of_foundation = (
		SELECT MIN(City2.date_of_foundation)
		FROM (
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation
			FROM Existing_subject
			UNION ALL
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation
			FROM Historical_subject
			) AS City2
			JOIN Type_of_subject ToS2
			ON ToS2.ID_type = City2.ID_type
			WHERE ToS2.Type_name = 'Город');
	

/*42. Выбрать название страны, в которой находится старей
ший город.*/
SELECT Country.Subject_name 
FROM (
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
	FROM Historical_subject
	) AS City
	JOIN Type_of_subject ToS
	ON ToS.ID_type = City.ID_type
	JOIN (
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation
		FROM Existing_subject
		UNION ALL
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation
		FROM Historical_subject
		) AS Country
	ON City.ID_parent_subject = Country.ID_subject
WHERE ToS.Type_name = 'Город' AND  City.date_of_foundation = (
		SELECT MIN(City2.date_of_foundation)
		FROM (
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation
			FROM Existing_subject
			UNION ALL
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation
			FROM Historical_subject
			) AS City2
			JOIN Type_of_subject ToS2
			ON ToS2.ID_type = City2.ID_type
			WHERE ToS2.Type_name = 'Город');
			
/*43. Для каждой страны выбрать названия старейшего и са
мого молодого городов, а также годы их основания. Результат от
сортировать по названию страны в лексикографическом порядке.*/
SELECT Country.Subject_name, 
	CityYoung.Subject_name AS Самый_молодой_город, EXTRACT(YEAR FROM CityYoung.date_of_foundation) AS Год_основания,
	CityOld.Subject_name AS Самый_старый_город,  EXTRACT(YEAR FROM CityOld.date_of_foundation)  AS Год_основания
FROM (
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation
	FROM Existing_subject
	UNION ALL
	SELECT ID_subject,Subject_name, ID_type, date_of_foundation
	FROM Historical_subject
	) AS Country
	JOIN (
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
		FROM Existing_subject
		UNION ALL
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
		FROM Historical_subject
	) AS CityYoung
	ON CityYoung.ID_parent_subject = Country.ID_subject
	JOIN (
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
		FROM Existing_subject
		UNION ALL
		SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
		FROM Historical_subject
	) AS CityOld
	ON CityOld.ID_parent_subject = Country.ID_subject
WHERE CityOld.date_of_foundation = (
		SELECT MIN(City2.date_of_foundation)
		FROM (
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
			FROM Existing_subject
			UNION ALL
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
			FROM Historical_subject
			) AS City2
			JOIN Type_of_subject ToS2
			ON ToS2.ID_type = City2.ID_type
			WHERE ToS2.Type_name = 'Город' AND City2.ID_parent_subject = CityYoung.ID_parent_subject)
		AND CityYoung.date_of_foundation = (
		SELECT MAX(City2.date_of_foundation)
		FROM (
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
			FROM Existing_subject
			UNION ALL
			SELECT ID_subject,Subject_name, ID_type, date_of_foundation, ID_parent_subject
			FROM Historical_subject
			) AS City2
			JOIN Type_of_subject ToS2
			ON ToS2.ID_type = City2.ID_type
			WHERE ToS2.Type_name = 'Город' AND City2.ID_parent_subject = CityOld.ID_parent_subject)
ORDER BY Country.Subject_name;

/*44. Найти ошибки пересечения периодов правления.*/
SELECT PoR1.ID_period
FROM Period_of_reign PoR1
WHERE EXISTS (
    SELECT 1
    FROM Period_of_reign PoR2
    WHERE PoR1.ID_period != PoR2.ID_period
      AND (
          (PoR1.ID_ruler = PoR2.ID_ruler AND PoR1.ID_subject != PoR2.ID_subject)
          OR 
          (PoR1.ID_ruler != PoR2.ID_ruler AND PoR1.ID_subject = PoR2.ID_subject)
		  OR 
		  (PoR1.ID_ruler = PoR2.ID_ruler AND PoR1.ID_subject = PoR2.ID_subject)
      )
      AND (
          PoR1.date_of_start BETWEEN PoR2.date_of_start AND COALESCE(PoR2.date_of_end, CURRENT_DATE)
          OR 
          COALESCE(PoR1.date_of_end, CURRENT_DATE) BETWEEN PoR2.date_of_start AND COALESCE(PoR2.date_of_end, CURRENT_DATE)
      )
);
			

