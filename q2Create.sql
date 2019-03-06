CREATE MATERIALIZED VIEW excellentStudents(studentid,gpa) AS
	With noFailure(studentid,degreeid) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid
			FROM studentregistrationstodegrees,courseregistrations
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid
			HAVING MIN(courseregistrations.grade)>=5),
	maxGrade(studentid,degreeid,courseid,maxgrade,ect) AS(
			SELECT studentregistrationstodegrees.studentid,studentregistrationstodegrees.degreeid,courseoffers.courseid,max(courseregistrations.grade),courses.ects
			FROM studentregistrationstodegrees,courseregistrations,courses,courseoffers
			WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND
			  courseoffers.courseofferid=courseregistrations.courseofferid AND courses.courseid=courseoffers.courseid AND 
			  (studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid) IN (SELECT studentid,degreeid
										FROM noFailure)
			GROUP BY studentregistrationstodegrees.studentid, studentregistrationstodegrees.degreeid,courseoffers.courseid,courses.ects),
	nerdyStudents(studentid,degreeid,weightedtotalgrades,totalects) AS(
	SELECT studentid,degreeid, SUM (maxgrade*ect) AS weightedtotalgrades, SUM (ect) AS totalects
	FROM maxGrade
	GROUP BY studentid, degreeid), 	
	studentsGpa(studentid,GPA) AS(
	SELECT nerdyStudents.studentid,CAST (nerdyStudents.weightedtotalgrades AS FLOAT)/CAST(nerdyStudents.totalects AS FLOAT) as GPA
	FROM nerdyStudents, degrees
	WHERE nerdyStudents.degreeid=degrees.degreeid AND nerdyStudents.totalects>=degrees.totalects)
	SELECT studentid,GPA
	FROM studentsGpa
	WHERE GPA BETWEEN 9 AND 10;