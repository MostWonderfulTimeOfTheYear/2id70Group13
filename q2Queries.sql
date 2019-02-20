-- remove all comments before submitting
-- and have each query on 1 line

-- q1:

-- q2:

-- q3:

-- q4:
--EXPLAIN ANALYZE 
WITH StudentsInDegree AS (SELECT st.StudentId, st.Gender FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept='thou shalt'),
GenderPercentage AS (SELECT Gender, (100 * COUNT(*) / sum(COUNT(*)) OVER()) AS Percentage FROM StudentsInDegree GROUP BY Gender)
SELECT Percentage FROM GenderPercentage WHERE Gender='F';

-- q5:

-- q6:

-- q7:

-- q8:
