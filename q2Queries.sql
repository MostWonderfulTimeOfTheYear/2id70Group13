SELECT DISTINCT (studentid)
FROM excellentStudents
WHERE excellentStudents.gpa >=%1%
ORDER BY studentid;

<<<<<<< HEAD
=======
-- q1:

-- q2:

-- q3:

-- q4:
/*
CREATE INDEX idx_studentToDegree ON StudentRegistrationsToDegrees(DegreeId, StudentId);

EXPLAIN ANALYZE 
WITH 
    StudentsInDegree AS (
        SELECT st.StudentId, st.Gender 
            FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg 
                WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept=%1%
    )
SELECT (100. * COUNT(*) / (SELECT COUNT(*) FROM StudentsInDegree)) AS percentage 
    FROM StudentsInDegree 
        WHERE Gender='F';

DROP INDEX idx_studentToDegree;
*/
-- q5:
--CREATE INDEX idx_Grade ON CourseOffers(CourseOfferId, CourseId);

/*
EXPLAIN ANALYZE 
WITH 
    CourseOfferGradesBelow AS (
        SELECT co.CourseId, COUNT(co.CourseId) AS Below 
            FROM CourseRegistrations as cr, CourseOffers as co
                WHERE cr.Grade < 8 AND co.CourseOfferId=cr.CourseOfferId
                    GROUP BY co.CourseId
    ),
    CourseOfferGradesAbove AS (
        SELECT co.CourseId, COUNT(co.CourseId) AS Above 
            FROM CourseRegistrations as cr, CourseOffers as co
                WHERE cr.Grade >= 8 AND co.CourseOfferId=cr.CourseOfferId
                    GROUP BY co.CourseId
    )
SELECT cogb.CourseId, (100. * (coga.Above) / (cogb.Below + coga.Above)) as percentagePassing 
    FROM CourseOfferGradesBelow AS cogb, CourseOfferGradesAbove coga
        WHERE cogb.CourseId=coga.CourseId
            GROUP BY cogb.CourseId, coga.Above, cogb.Below 
                ORDER BY cogb.CourseId;
*/

--DROP INDEX idx_Grade;
-- q6:
/*
EXPLAIN ANALYZE 
WITH 
    HighestGradeCourseOffers AS (
        SELECT cr.CourseOfferId, Max(Grade) AS highestGrade 
            FROM CourseRegistrations AS cr, CourseOffers AS co 
                WHERE co.CourseOfferId=cr.CourseOfferId AND co.Quartile=1 AND co.Year=2018 
                    GROUP BY cr.CourseOfferId
    ),
    ExcellentStudents AS (
        SELECT st2deg.StudentId, COUNT(st2deg.StudentId) AS numberOfCoursesWhereExcellent 
            FROM HighestGradeCourseOffers AS gco, StudentRegistrationsToDegrees AS st2deg, CourseRegistrations AS cr 
                WHERE gco.CourseOfferId=cr.CourseOfferId AND cr.StudentRegistrationId=st2deg.StudentRegistrationId AND cr.Grade=gco.highestGrade 
                    GROUP BY st2deg.StudentId
    )
SELECT StudentId, numberOfCoursesWhereExcellent 
    FROM ExcellentStudents 
        WHERE numberOfCoursesWhereExcellent >= 2;
*/
-- q7:

SELECT deg.DegreeId, st.BirthyearStudent, st.Gender, AVG(cr.Grade) 
    FROM Degrees AS deg, Students AS st, CourseRegistrations AS cr, StudentRegistrationsToDegrees AS st2deg 
        WHERE st2deg.StudentId=st.StudentId AND st2deg.StudentRegistrationId=cr.StudentRegistrationId AND st2deg.DegreeId=deg.DegreeId 
            GROUP BY CUBE (deg.DegreeId, st.BirthyearStudent, st.Gender);

-- q8:
/*
SELECT c.courseName, co.year, co.quartile 
    FROM courses AS c, courseOffers AS co 
        WHERE c.courseId = co.CourseId AND 
            (
                SELECT COUNT(sa.StudentRegistrationId) 
                    FROM StudentAssistants AS sa 
                        WHERE co.courseOfferId = sa.CourseOfferId AND co.CourseId = c.CourseId
            ) < (
                SELECT COUNT(cr.StudentRegistrationId) 
                    FROM CourseRegistrations AS cr 
                        WHERE cr.CourseOfferId=co.CourseOfferId and co.courseId = c.courseId
                )/50
                ORDER BY co.courseOfferId;
*/
>>>>>>> f958086331fd5434a9efa531a5801964f7fa48e1
