Create TEMP VIEW sufficientGrade(studentid,degreeid,courseid,ect) AS
	SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid,courseoffers.courseid,max(courseregistrations.grade),courses.ects
	FROM studentregistrationstodegrees, courseregistrations,courses,courseoffers
	WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND
		courses.courseid=courseoffers.courseid AND courseoffers.courseofferid=courseregistrations.courseofferid 
	AND courseregistrations.grade>=5
	GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid,courseoffers.courseid,courses.ects;
Create TEMP VIEW totalECTS(studentid,degreeid,totalECTS) AS
	SELECT sufficientGrade.studentid,sufficientGrade.degreeid, SUM(sufficientGrade.ect) AS totalECTS
	FROM sufficientGrade
	GROUP BY sufficientGrade.studentid,sufficientGrade.degreeid;
CREATE TEMP VIEW activeStudents(studentid,degreeid) AS 
	SELECT totalECTS.studentid,degrees.degreeid
	FROM totalECTS, degrees
	WHERE totalECTS.degreeid=degrees.degreeid AND totalECTS.totalECTS<degrees.totalects;
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