CREATE MATERIALIZED VIEW excellentStudents(studentid,gpa) AS
With noFailure(studentid,degreeid) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid
			FROM studentregistrationstodegrees,courseregistrations
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid
			HAVING MIN(courseregistrations.grade)>=5),
	nerdyStudents(studentid,degreeid,weightedtotalgrades,totalects) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid,SUM(courseregistrations.grade*courses.ects) as weightedtotalgrades ,SUM(courses.ects) as totalects
			FROM studentregistrationstodegrees,courseregistrations,courses,courseoffers
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND
			  courseoffers.courseofferid=courseregistrations.courseofferid AND courses.courseid=courseoffers.courseid AND 
			  (studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid) IN (SELECT studentid,degreeid
										FROM noFailure)
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid),
	studentsGpa(studentid,GPA) AS(
	SELECT nerdyStudents.studentid,CAST (nerdyStudents.weightedtotalgrades AS FLOAT)/CAST(nerdyStudents.totalects AS FLOAT) as GPA
	FROM nerdyStudents, degrees
	WHERE nerdyStudents.degreeid=degrees.degreeid AND nerdyStudents.totalects>=degrees.totalects)
	SELECT studentid,GPA
	FROM studentsGpa 
	WHERE GPA BETWEEN 9 AND 10;