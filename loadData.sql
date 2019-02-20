-- this file should load all data in the previously-created tables
-- the data will be stored under /mnt/ramdisk/tables
-- for example, the Students file is under /mnt/ramdisk/tables/Students.table 
-- The files of the folder are as follows (mind the lower-case/upper-case): 
--   CourseOffers.table, CourseRegistrations.table, Courses.table, Degrees.table
--   StudentAssistants.table, StudentRegistrationsToDegrees.table, Students.table
--   TeacherAssignmentsToCourses.table, Teachers.table
-- Don't forget to analyze at the end. It can make a difference in query performance.
-- Example:

COPY Students(StudentId, StudentName, Address, BirthyearStudent, Gender) FROM 'c:/dis/data/students.table' DELIMITER ',' CSV HEADER;
COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM 'c:/dis/data/degrees.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM 'c:/dis/data/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER; 
COPY Teachers(TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM 'c:/dis/data/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM 'c:/dis/data/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM 'c:/dis/data/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM 'c:/dis/data/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM 'c:/dis/data/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM 'c:/dis/data/CourseRegistrations.table' DELIMITER ',' CSV HEADER; 

ANALYZE VERBOSE
