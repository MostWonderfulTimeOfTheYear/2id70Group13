-- remove all comments before submitting
-- and have each query on 1 line

-- q1:

-- q2:

-- q3:

-- q4:

--CREATE INDEX idx_studentToDegree ON StudentRegistrationsToDegrees(DegreeId, StudentId);

--EXPLAIN ANALYZE 
--WITH StudentsInDegree AS (SELECT st.StudentId, st.Gender FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept='thou shalt')
--SELECT (100. * COUNT(*) / (SELECT COUNT(*) FROM StudentsInDegree)) AS percentage FROM StudentsInDegree WHERE Gender='F';

--DROP INDEX idx_studentToDegree;

-- q5:

--EXPLAIN ANALYZE 
--WITH CourseOfferGradesTotal AS (SELECT cr.CourseOfferId, COUNT(cr.CourseOfferId) AS Total FROM CourseRegistrations as cr WHERE cr.Grade < 8 GROUP BY cr.CourseOfferId),
--CourseOfferGradesAbove AS (SELECT cr.CourseOfferId, COUNT(cr.CourseOfferId) AS Above FROM CourseRegistrations as cr WHERE cr.Grade >= 8 GROUP BY cr.CourseOfferId)
--SELECT cogt.CourseOfferId, (100. * (coga.Above) / (cogt.Total + coga.Above)) as percentagePassing FROM CourseOfferGradesTotal AS cogt, CourseOfferGradesAbove coga WHERE cogt.CourseOfferId=coga.CourseOfferId GROUP BY cogt.CourseOfferId, coga.Above, cogt.Total ORDER BY cogt.CourseOfferId;

-- q6:

--WITH 
--ExcellentStudents AS (SELECT st2deg.StudentId, COUNT(st2deg.StudentId) AS numberOfCoursesWhereExcellent FROM CourseRegistrations AS cr CourseOffers AS co, StudentRegistrationsToDegrees AS st2deg WHERE co.CourseOfferId=cr.CourseOfferId AND Quartile=1 AND Year=2018 AND cr.StudentRegistrationId=st2deg.StudentRegistrationId GROUP BY cr.CourseOfferId HAVING cr.Grade=MAX(cr.Grade) GROUP BY st2deg.StudentId)
--SELECT StudentId, numberOfCoursesWhereExcellent FROM ExcellentStudents WHERE numberOfCoursesWhereExcellent >= 2;

-- q7:

-- q8:
