-- remove all comments before submitting
-- and have each query on 1 line

-- q1:

-- q2:

-- q3:

-- q4:

CREATE INDEX idx_studentToDegree ON StudentRegistrationsToDegrees(DegreeId, StudentId);
CREATE INDEX idx_gender ON Students(Gender);

EXPLAIN ANALYZE 
WITH StudentsInDegree AS (SELECT st.StudentId, st.Gender FROM Students AS st, StudentRegistrationsToDegrees AS st2deg, Degrees AS deg WHERE st2deg.DegreeId=deg.DegreeId AND st.StudentId=st2deg.StudentId AND deg.Dept='thou shalt')
SELECT (100. * COUNT(*) / (SELECT COUNT(*) FROM StudentsInDegree)) AS Percentage FROM StudentsInDegree WHERE Gender='F';

DROP INDEX idx_studentToDegree;
DROP INDEX idx_gender;

-- q5:

-- q6:

-- q7:

-- q8:
