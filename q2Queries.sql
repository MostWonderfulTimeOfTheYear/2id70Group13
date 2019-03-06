-- q1:

WITH studentGrades (studentregistrationid,courseofferid,grade) AS(
    SELECT studentregistrationstodegrees.studentregistrationid,courseregistrations.courseofferid,courseregistrations.grade
    FROM courseregistrations,studentregistrationstodegrees
    WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND courseregistrations.grade>5 
	AND studentregistrationstodegrees.studentid=%1% AND studentregistrationstodegrees.degreeid=%2%)
SELECT courses.coursename, studentGrades.grade
FROM studentGrades, courses, courseoffers
WHERE courseoffers.courseid=courses.courseid AND courseoffers.courseofferid=studentGrades.courseofferid 
ORDER BY courseoffers.year, courseoffers.quartile,courseoffers.courseofferid;

-- q2:

SELECT DISTINCT (studentid)
    FROM excellentStudents
        WHERE excellentStudents.gpa >=9.1
            ORDER BY studentid;

-- q3:

WITH totalStudents(degreeid,total) AS (
	SELECT activeStudents.degreeid,COUNT(*)
	FROM students,activeStudents
	WHERE students.studentid=activeStudents.studentid
	GROUP BY degreeid),
totalFemaleStudents(degreeid,totalFemale) AS(
	SELECT activeStudents.degreeid,COUNT(*)
	FROM students,activeStudents
	WHERE students.studentid=activeStudents.studentid AND students.gender='F'
	GROUP BY degreeid)
SELECT totalStudents.degreeiD,CAST(totalFemaleStudents.totalFemale AS FLOAT)/CAST(totalStudents.total AS FLOAT) AS percentage
FROM totalStudents,totalFemaleStudents
WHERE totalStudents.degreeid=totalFemaleStudents.degreeid
ORDER BY totalStudents.degreeiD

-- q4:

WITH 
    StudentsInDegree AS (
        SELECT st.StudentId, st.Gender 
            FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg 
                WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept='thou shalt'
    )
SELECT (100. * COUNT(*) / (SELECT COUNT(*) FROM StudentsInDegree)) AS percentage 
    FROM StudentsInDegree 
        WHERE Gender='F';

-- q5:

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

-- q6:

SELECT StudentId, numberOfCoursesWhereExcellent 
    FROM ExcellentCourseStudents 
        WHERE numberOfCoursesWhereExcellent >= 2;

-- q7:

SELECT deg.DegreeId, st.BirthyearStudent, st.Gender, AVG(cr.Grade) 
    FROM Degrees AS deg, Students AS st, CourseRegistrations AS cr, StudentRegistrationsToDegrees AS st2deg 
        WHERE st2deg.StudentId=st.StudentId AND st2deg.StudentRegistrationId=cr.StudentRegistrationId AND st2deg.DegreeId=deg.DegreeId 
            GROUP BY CUBE (deg.DegreeId, st.BirthyearStudent, st.Gender);

-- q8:

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