-- This file should create the tables
-- An example follows, replace it with your own commands.
-- SQL files can be executed from command-line using psql -d THE_DATABASE_NAME -f THE_FILENAME
-- Notice the UNLOGGED option, which drastically increases performance and reduces space usage

CREATE UNLOGGED TABLE IF NOT EXISTS Students(StudentId int PRIMARY KEY, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char);
CREATE UNLOGGED TABLE IF NOT EXISTS Degrees(DegreeId int PRIMARY KEY, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int);
CREATE UNLOGGED TABLE IF NOT EXISTS StudentRegistrationsToDegrees(StudentRegistrationId int PRIMARY KEY, StudentId int REFERENCES Students(StudentId), DegreeId int REFERENCES Degrees(DegreeId), RegistrationYear int);
CREATE UNLOGGED TABLE IF NOT EXISTS Teachers(TeacherId int PRIMARY KEY, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char); 
CREATE UNLOGGED TABLE IF NOT EXISTS Courses(CourseId int PRIMARY KEY, CourseName varchar(50), CourseDescription varchar(200), DegreeId int REFERENCES Degrees(DegreeId), ECTS int);
CREATE UNLOGGED TABLE IF NOT EXISTS CourseOffers(CourseOfferId int PRIMARY KEY, CourseId int REFERENCES Courses(CourseId), Year int, Quartile int);
CREATE UNLOGGED TABLE IF NOT EXISTS TeacherAssignmentsToCourses(CourseOfferId int REFERENCES CourseOffers(CourseOfferId), TeacherId int REFERENCES Teachers(TeacherId));
CREATE UNLOGGED TABLE IF NOT EXISTS StudentAssistants(CourseOfferId int REFERENCES CourseOffers(CourseOfferId), StudentRegistrationId int REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId));
CREATE UNLOGGED TABLE IF NOT EXISTS CourseRegistrations(CourseOfferId int REFERENCES CourseOffers(CourseOfferId), StudentRegistrationId int REFERENCES StudentRegistrationsToDegrees(StudentRegistrationId), Grade int);
