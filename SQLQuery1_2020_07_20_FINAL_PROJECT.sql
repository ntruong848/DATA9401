SELECT * FROM GradeRecordsModuleV

--set primary key //achieve 1NF
ALTER TABLE GradeRecordsModuleV
ADD PRIMARY KEY (studentID);

--2NF-drop partial dependencies, not all attributes dependent on PK --create two child tables, set PK, set FK

--create studentTable and gradesTable
SELECT studentID, First_name, Lastname
INTO studentTable
FROM GradeRecordsModuleV

--set primary key
ALTER TABLE studentTable
ADD PRIMARY KEY (studentID);

SELECT studentID, Midtermexam, Finalexam, assignment1, assignment2, Totalpoints, Studentaverage, Grade
INTO gradesTable
FROM GradeRecordsModuleV

--Define foreign key
ALTER TABLE gradesTable
ADD CONSTRAINT fk_studentID FOREIGN KEY(studentID)
REFERENCES studentTable(studentID)

--3NF-remove transistive dependence, create new child table finalGradesTable,
--drop studentaverage and Grades from previous table, define foreign key
SELECT studentID, Studentaverage, Grade
INTO finalGradesTable
FROM gradesTable

ALTER TABLE gradesTable
DROP COLUMN studentaverage

ALTER TABLE gradesTable
DROP COLUMN Grade

--Define foreign key
ALTER TABLE finalGradesTable
ADD CONSTRAINT fk_studentID1 FOREIGN KEY(studentID)

--perform two JOIN operations with 3 tables
SELECT
REFERENCES studentTable(studentID)

SELECT * FROM studentTable
SELECT * FROM gradesTable
SELECT * FROM finalGradesTable

--Join tables together
/*SELECT * FROM table1 a
JOIN table2 b ON a.ID = b.ID
JOIN table3 c ON a.ID = c.ID*/

SELECT studentTable.studentID, studentTable.First_Name, studentTable.Lastname, gradesTable.midtermexam, gradesTable.Finalexam,
gradesTable.assignment1, gradesTable.assignment2, gradesTable.TotalPoints, finalGradesTable.Studentaverage, finalGradesTable.Grade
FROM ((studentTable
INNER JOIN gradesTable ON studentTable.studentID = gradesTable.studentID)
INNER JOIN finalGradesTable ON studentTable.studentID = finalGradesTable.studentID);
