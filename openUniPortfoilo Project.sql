--Retrive the information about the openUni dataset

SELECT *
FROM courses

SELECT *
FROM studentAssessment

SELECT *
FROM studentInfo

SELECT *
FROM studentRegistration

SELECT COUNT(*)
FROM studentRegistration

-- Checking for NULL values
SELECT COUNT(*) - COUNT (date_unregistration) AS Missing
FROM studentRegistration


SELECT COUNT(date_unregistration) AS Not_nuLL
FROM studentRegistration
where date_unregistration IS NOT NULL


SELECT id_student,date_registration,date_unregistration
FROM studentRegistration
WHERE  date_unregistration IS  NULL
ORDER BY date_registration DESC


-- REtrive courses and assessments 
SELECT *
FROM assessments
JOIN courses ON assessments.code_module = courses.code_module

-- Students score below 10
SELECT id_assessment,id_student,score AS Failed
from studentAssessment
WHERE score < = 10

--Student Information By Region

SELECT studentAssessment.id_student AS studentID ,id_assessment AS AssessementID,score,gender,region 
FROM studentAssessment
JOIN studentInfo ON studentAssessment.id_student = studentInfo.id_student 

--USE CTE
 With studRegion (id_student,id_assessment,score,gender,region,code_module,highest_education,age_band)
 as
(
SELECT studentAssessment.id_student AS studentID ,id_assessment AS AssessementID,score,gender,region,code_module,highest_education,age_band
FROM studentAssessment
JOIN studentInfo ON studentAssessment.id_student = studentInfo.id_student 
)

SELECT *
FROM studRegion

--Temp Table

CREATE TABLE #studentInformation(
id_student int NOT NULL,
id_assessment int NOT NULL,
score float NULL,
gender nvarchar(50)NOT NULL,
region nvarchar(50)NOT NULL,
code_module nvarchar (50)NOT NULL,
highest_education nvarchar(50)NOT NULL,
age_band nvarchar(50)NOT NULL
)

INSERT INTO #studentInformation
SELECT studentAssessment.id_student AS studentID ,id_assessment AS AssessementID,score,gender,region,highest_education,age_band
FROM studentAssessment
JOIN studentInfo ON studentAssessment.id_student = studentInfo.id_student 

ALTER TABLE #studentInformation
ADD code_module nvarchar (50)NOT NULL,
id_student int NOT NULL,
id_assessment int NOT NULL,
score float NULL,
gender nvarchar(50)NOT NULL,
region nvarchar(50)NOT NULL,
highest_education nvarchar(50)NOT NULL,
age_band nvarchar(50)NOT NULL


DROP TABLE IF EXISTS studentInformation

--Creat view for later visualization

CREATE VIEW studentInformation AS
SELECT studentAssessment.id_student AS studentID ,id_assessment AS AssessementID,score,gender,region,code_module ,highest_education,age_band
FROM studentAssessment
JOIN studentInfo ON studentAssessment.id_student = studentInfo.id_student 


SELECT *
FROM studentInformation