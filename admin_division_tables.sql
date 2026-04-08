/*СОЗДАНИЕ ТАБЛИЦЦ*/

CREATE TABLE Type_of_subject(
	ID_type SERIAL PRIMARY KEY,
	Type_name VARCHAR(50) NOT NULL
);

CREATE TABLE Climat_zone(
	ID_zone SERIAL PRIMARY KEY,
	Zone_name VARCHAR(50) NOT NULL,
	Description VARCHAR(200)
);

CREATE TABLE Population_census(
	ID_census SERIAL PRIMARY KEY,
	ID_subject INTEGER NOT NULL, 
	Count_of_people INTEGER NOT NULL,
	Year_of_census INTEGER NOT NULL 
);

CREATE TABLE Area_change(
	ID_change SERIAL PRIMARY KEY,
	ID_subject INTEGER NOT NULL, 
	Area_size REAL NOT NULL, 
	Date_of_change DATE NOT NULL 
);

CREATE TABLE Subject_key( --для записи "живых" и "мертвых" субъектов в общих таблицах
	ID_subject SERIAL PRIMARY KEY
);

CREATE TABLE Existing_subject(
	ID_subject INT PRIMARY KEY, 
	ID_parent_subject INT,
	Subject_name VARCHAR(100) NOT NULL,
	ID_type INT NOT NULL,
	Date_of_foundation DATE NOT NULL
);

CREATE TABLE Historical_subject(
	ID_subject INT PRIMARY KEY,
	ID_parent_subject INT,
	ID_existing_parent INT,
	Subject_name VARCHAR(100) NOT NULL,
	ID_type INT NOT NULL,
	Date_of_foundation DATE NOT NULL,
	Date_of_disappearing DATE NOT NULL
);

CREATE TABLE Ruler(
	ID_ruler SERIAL PRIMARY KEY,
	Rul_surname VARCHAR(100) NOT NULL, 
	Rul_name VARCHAR(100) NOT NULL, -- МОЖЕТ ВКЛЮЧАТЬ РИМСКИЕ ЦИФРЫ (ЛЮДОВИК XIV)
	Rul_patronimic VARCHAR(100),
	Rul_second_name VARCHAR(100),
	Date_of_birth DATE NOT NULL,
	Date_of_death DATE
);


CREATE TABLE Period_of_reign(
	ID_period SERIAL PRIMARY KEY, 
	ID_ruler INTEGER NOT NULL,
	ID_subject INTEGER NOT NULL,
	Date_of_start DATE NOT NULL,
	Date_of_end DATE
);

CREATE TABLE Climat_included( 
	ID_subject INTEGER,
	ID_climat INTEGER,
	Date_of_record DATE NOT NULL,
	PRIMARY KEY(ID_subject, ID_climat)
);

CREATE TABLE Subject_historical_parents(
	ID_subject INTEGER,
	ID_parent INTEGER,
	PRIMARY KEY(ID_subject, ID_parent)
);

/*0ГРАНИЧЕНИЯ*/
--СВЯЗИ--
ALTER TABLE Existing_subject ADD 
	CONSTRAINT FK_ID_subject_existing_subject 
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);

ALTER TABLE Historical_subject ADD 
	CONSTRAINT FK_ID_subject_historical_subject 
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);
	
ALTER TABLE Existing_subject ADD 
	CONSTRAINT FK_ID_existing_subject_ID_parent_subject 
	FOREIGN KEY (ID_parent_subject) REFERENCES Existing_subject(ID_subject);

ALTER TABLE Historical_subject ADD 
	CONSTRAINT FK_ID_historical_subject_ID_parent_subject 
	FOREIGN KEY (ID_parent_subject) REFERENCES Historical_subject(ID_subject);

ALTER TABLE Historical_subject ADD 
	CONSTRAINT FK_ID_existing_subject_ID_existing_parent 
	FOREIGN KEY (ID_existing_parent) REFERENCES Existing_subject(ID_subject);

ALTER TABLE Existing_subject ADD
	CONSTRAINT FK_ID_type_Existing_subject
	FOREIGN KEY (ID_type) REFERENCES Type_of_subject(ID_type);

ALTER TABLE Historical_subject ADD
	CONSTRAINT FK_ID_type_Historical_subject
	FOREIGN KEY (ID_type) REFERENCES Type_of_subject(ID_type);

ALTER TABLE Climat_included ADD 
	CONSTRAINT FK_Climat_ID_zone
	FOREIGN KEY (ID_climat) REFERENCES Climat_zone(ID_zone);

ALTER TABLE Climat_included ADD 
	CONSTRAINT FK_Climat_ID_subject
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);

ALTER TABLE Area_change ADD
	CONSTRAINT FK_ID_subject_Area_change
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);

ALTER TABLE Population_census ADD
	CONSTRAINT FK_ID_subject_Population_census
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);

ALTER TABLE Period_of_reign ADD
	CONSTRAINT FK_ID_subject_Period_of_reign
	FOREIGN KEY (ID_subject) REFERENCES Subject_key(ID_subject);

ALTER TABLE Period_of_reign ADD
	CONSTRAINT FK_ID_ruler_Period_of_reign
	FOREIGN KEY (ID_ruler) REFERENCES Ruler(ID_ruler);
	
ALTER TABLE Subject_historical_parents ADD
	CONSTRAINT FK_ID_subject_Subject_historical_parents
	FOREIGN KEY (ID_subject) REFERENCES Existing_subject(ID_subject);

ALTER TABLE Subject_historical_parents ADD
	CONSTRAINT FK_ID_parent_Subject_historical_parents
	FOREIGN KEY (ID_parent) REFERENCES Historical_subject(ID_subject);

--ПРОВЕРКИ ДОПУСТИМЫХ ЗНАЧЕНИЙ--
--СТРОКОВЫЕ--
ALTER TABLE Existing_subject ADD
	CONSTRAINT CH_Subject_name
	CHECK(Subject_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Historical_subject ADD
	CONSTRAINT CH_Hist_subject_name
	CHECK(Subject_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Climat_zone ADD
	CONSTRAINT CH_Zone_name
	CHECK(Zone_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Ruler ADD
	CONSTRAINT CH_Rul_surname
	CHECK(Rul_surname NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Ruler ADD
	CONSTRAINT CH_Rul_name
	CHECK(Rul_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');	

ALTER TABLE Ruler ADD
	CONSTRAINT CH_Rul_patronimic
	CHECK(Rul_patronimic NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Ruler ADD
	CONSTRAINT CH_Rul_second_name
	CHECK(Rul_second_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');

ALTER TABLE Type_of_subject ADD
	CONSTRAINT CH_Type_name
	CHECK(Type_name NOT LIKE '%*[1234567890#*&()?!\/|$@^+=]%');
	
--ДАТЫ--
ALTER TABLE Ruler ADD
	CONSTRAINT CH_date_of_birth
	CHECK (Date_of_birth<CURRENT_DATE);
ALTER TABLE Ruler ADD
	CONSTRAINT CH_date_of_death
	CHECK (Date_of_death<=CURRENT_DATE AND Date_of_death>Date_of_birth);

ALTER TABLE Period_of_reign ADD
	CONSTRAINT CH_date_of_start
	CHECK (Date_of_start<CURRENT_DATE);
ALTER TABLE Period_of_reign ADD
	CONSTRAINT CH_date_of_end
	CHECK (Date_of_end<=CURRENT_DATE AND Date_of_end>Date_of_start);

ALTER TABLE Existing_subject ADD
	CONSTRAINT CH_date_of_foundation
	CHECK (Date_of_foundation<=CURRENT_DATE);
ALTER TABLE Historical_subject ADD
	CONSTRAINT CH_hist_date_of_foundation
	CHECK (Date_of_foundation<=CURRENT_DATE);
ALTER TABLE Historical_subject ADD
	CONSTRAINT CH_date_of_disappearing
	CHECK (Date_of_disappearing<=CURRENT_DATE AND Date_of_disappearing>Date_of_foundation);

ALTER TABLE Area_change ADD
	CONSTRAINT CH_date_of_change
	CHECK (Date_of_change<=CURRENT_DATE);

ALTER TABLE Population_census ADD
	CONSTRAINT CH_year_of_census
	CHECK (Year_of_census<=EXTRACT(YEAR FROM CURRENT_DATE));

--ЧИСЛА--
ALTER TABLE Population_census ADD
	CONSTRAINT CH_count_of_people
	CHECK (Count_of_people>0);

ALTER TABLE Area_change ADD
	CONSTRAINT CH_area_size
	CHECK (Area_size>0);

	
--УНИКАЛЬНОСТЬ--
ALTER TABLE Climat_zone ADD
	CONSTRAINT UN_Zone_name
	UNIQUE(Zone_name);

ALTER TABLE Type_of_subject ADD
	CONSTRAINT UN_type_name
	UNIQUE(Type_name);

ALTER TABLE Ruler ADD
	CONSTRAINT UN_ruler_name
	UNIQUE(Rul_surname,Rul_name,Rul_patronimic,Rul_second_name);