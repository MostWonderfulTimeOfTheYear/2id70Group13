WITH studentGrades (studentregistrationid,courseofferid,grade) AS(
    SELECT studentregistrationstodegrees.studentregistrationid,courseregistrations.courseofferid,courseregistrations.grade
    FROM courseregistrations,studentregistrationstodegrees
    WHERE studentregistrationstodegrees.studentregistrationid=courseregistrations.studentregistrationid AND courseregistrations.grade>5 
	AND studentregistrationstodegrees.studentid=%1% AND studentregistrationstodegrees.degreeid=%2%)
SELECT courses.coursename, studentGrades.grade
FROM studentGrades, courses, courseoffers
WHERE courseoffers.courseid=courses.courseid AND courseoffers.courseofferid=studentGrades.courseofferid 
ORDER BY courseoffers.year, courseoffers.quartile,courseoffers.courseofferid;

