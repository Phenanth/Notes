SELECT DISTINCT ID FROM takes 
WHERE course_id="CS-101" AND ID not in (
SELECT ID FROM takes WHERE course_id="CS-190"
);

SELECT takes.ID,name FROM takes JOIN student ON takes.ID=student.ID 
WHERE course_id="CS-101" AND takes.ID in (
SELECT DISTINCT takes.ID FROM takes WHERE course_id="CS-190"
);

SELECT DISTINCT A.ID,student.name FROM takes AS A JOIN student ON A.ID=student.ID 
WHERE course_id="CS-101" AND EXISTS (
SELECT DISTINCT B.ID FROM takes AS B WHERE course_id="CS-190" AND A.ID=B.ID
);


计算机科学导论的课程号：
SELECT DISTINCT course_id FROM course WHERE title="Intro. to Computer Science";
图像处理的课程号：
SELECT DISTINCT course_id FROM course WHERE title="Image Processing";

SELECT ID FROM takes AS B WHERE B.course_id in (
SELECT DISTINCT course_id FROM course WHERE title="Image Processing"
);

SELECT DISTINCT name FROM takes AS A JOIN student ON A.ID=student.ID
WHERE A.course_id in (
SELECT DISTINCT course_id FROM course WHERE title="Intro. to Computer Science"
) AND A.ID not in (
SELECT ID FROM takes AS B WHERE B.course_id in (
SELECT DISTINCT course_id FROM course WHERE title="Image Processing"
));


SELECT avg(tot_cred) AS avg_cred FROM student WHERE dept_name="Comp. Sci.";

SELECT course_id FROM course WHERE title="Intro. to Computer Science";

SELECT A.ID FROM takes AS A WHERE A.course_id in (
SELECT course_id FROM course WHERE title="Intro. to Computer Science"
);

SELECT avg(tot_cred) AS avg_cred FROM student AS B WHERE B.ID in (
SELECT A.ID FROM takes AS A WHERE A.course_id in (
SELECT course_id FROM course WHERE title="Intro. to Computer Science"
));

SELECT dept_name, avg(tot_cred) AS avg_cred FROM student 
GROUP BY dept_name HAVING avg_cred>80 ORDER BY avg_cred DESC;
