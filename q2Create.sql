-- this file should contain the code required to create the auxiliary structures, for query 2
-- this file will be given 10 minutes to run. Then it will be killed
-- The file will be invoked with timeout 10m psql -d uni -f q2Create.sql
-- Remember that the database (including the auxiliary structures) needs to be less than 11 GB.
-- This file will be executed with postgres -d uni -f q2Create.sql 

-- q6:
CREATE MATERIALIZED VIEW ExcellentCourseStudents(StudentId, NumberOfCoursesWhereExcellent) AS
    WITH
        HighestGradeCourseOffers AS (
            SELECT cr.CourseOfferId, Max(Grade) AS highestGrade 
                FROM CourseRegistrations AS cr, CourseOffers AS co 
                    WHERE co.CourseOfferId=cr.CourseOfferId AND co.Quartile=1 AND co.Year=2018 
                        GROUP BY cr.CourseOfferId
        )
    SELECT st2deg.StudentId, COUNT(st2deg.StudentId) AS numberOfCoursesWhereExcellent 
        FROM HighestGradeCourseOffers AS gco, StudentRegistrationsToDegrees AS st2deg, CourseRegistrations AS cr 
            WHERE gco.CourseOfferId=cr.CourseOfferId AND cr.StudentRegistrationId=st2deg.StudentRegistrationId AND cr.Grade=gco.highestGrade 
                GROUP BY st2deg.StudentId;