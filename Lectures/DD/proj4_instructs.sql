创建一个视图，内容包含所有课程成绩合格（成绩不为F或空）的学生姓名、课程名称、成绩

来源为三个表：course、student、takes

mysql> select * from takes;
+-------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 12345 | CS-190    | 2      | Spring   | 2009 | A     |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     |
| 19991 | HIS-351   | 1      | Spring   | 2010 | B     |
| 23121 | FIN-201   | 1      | Spring   | 2010 | C+    |
| 44553 | PHY-101   | 1      | Fall     | 2009 | B-    |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    |
| 55739 | MU-199    | 1      | Spring   | 2010 | A-    |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     |
| 76653 | EE-181    | 1      | Spring   | 2009 | C     |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  |
+-------+-----------+--------+----------+------+-------+
22 rows in set (0.17 sec)

mysql> select * from student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 |
| 12345 | Shankar  | Comp. Sci. |       32 |
| 19991 | Brandt   | History    |       80 |
| 23121 | Chavez   | Finance    |      110 |
| 44553 | Peltier  | Physics    |       56 |
| 45678 | Levy     | Physics    |       46 |
| 54321 | Williams | Comp. Sci. |       54 |
| 55739 | Sanchez  | Music      |       38 |
| 70557 | Snow     | Physics    |        0 |
| 76543 | Brown    | Comp. Sci. |       58 |
| 76653 | Aoi      | Elec. Eng. |       60 |
| 98765 | Bourikas | Elec. Eng. |       98 |
| 98988 | Tanaka   | Biology    |      120 |
+-------+----------+------------+----------+
13 rows in set (0.02 sec)

mysql> select * from course;
+-----------+----------------------------+------------+---------+
| course_id | title                      | dept_name  | credits |
+-----------+----------------------------+------------+---------+
| BIO-101   | Intro. to Biology          | Biology    |       4 |
| BIO-301   | Genetics                   | Biology    |       4 |
| BIO-399   | Computational Biology      | Biology    |       3 |
| CS-101    | Intro. to Computer Science | Comp. Sci. |       4 |
| CS-190    | Game Design                | Comp. Sci. |       4 |
| CS-315    | Robotics                   | Comp. Sci. |       3 |
| CS-319    | Image Processing           | Comp. Sci. |       3 |
| CS-347    | Database System Concepts   | Comp. Sci. |       3 |
| EE-181    | Intro. to Digital Systems  | Elec. Eng. |       3 |
| FIN-201   | Investment Banking         | Finance    |       3 |
| HIS-351   | World History              | History    |       3 |
| MU-199    | Music Video Production     | Music      |       3 |
| PHY-101   | Physical Principles        | Physics    |       4 |
+-----------+----------------------------+------------+---------+
13 rows in set (0.02 sec)

不用JOIN的版本：

!!! 这里的 grade IS NULL 是多余的，若一定要做比较的话会导致因为没有index而体现出的
查询速度下降的性能变低的问题。

SELECT DISTINCT name, title, grade FROM course, student, takes 
WHERE takes.ID=student.ID AND takes.course_id=course.course_id
AND student.ID NOT IN (
SELECT DISTINCT ID FROM takes WHERE grade='F' OR grade IS NULL);

mysql> SELECT DISTINCT name, title, grade FROM course, student, takes 
    -> WHERE takes.ID=student.ID AND takes.course_id=course.course_id
    -> AND student.ID NOT IN (
    -> SELECT DISTINCT ID FROM takes WHERE grade='F' OR grade IS NULL);
+----------+----------------------------+-------+
| name     | title                      | grade |
+----------+----------------------------+-------+
| Zhang    | Intro. to Computer Science | A     |
| Zhang    | Database System Concepts   | A-    |
| Shankar  | Intro. to Computer Science | C     |
| Shankar  | Game Design                | A     |
| Shankar  | Robotics                   | A     |
| Shankar  | Database System Concepts   | A     |
| Brandt   | World History              | B     |
| Chavez   | Investment Banking         | C+    |
| Peltier  | Physical Principles        | B-    |
| Williams | Intro. to Computer Science | A-    |
| Williams | Game Design                | B+    |
| Sanchez  | Music Video Production     | A-    |
| Brown    | Intro. to Computer Science | A     |
| Brown    | Image Processing           | A     |
| Aoi      | Intro. to Digital Systems  | C     |
| Bourikas | Intro. to Computer Science | C-    |
| Bourikas | Robotics                   | B     |
+----------+----------------------------+-------+
17 rows in set (0.04 sec)

CREATE VIEW v as (
SELECT DISTINCT name, title, grade FROM course, student, takes 
WHERE takes.ID=student.ID AND takes.course_id=course.course_id
AND student.ID NOT IN (
SELECT DISTINCT ID FROM takes WHERE grade='F' OR grade IS NULL)
);

mysql> CREATE VIEW v as (
    -> SELECT DISTINCT name, title, grade FROM course, student, takes 
    -> WHERE takes.ID=student.ID AND takes.course_id=course.course_id
    -> AND student.ID NOT IN (
    -> SELECT DISTINCT ID FROM takes WHERE grade='F' OR grade IS NULL)
    -> );
Query OK, 0 rows affected (0.17 sec)


参考：
mysql> SELECT a.* FROM
    -> (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') a LEFT JOIN
    -> (SELECT ID FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
+-------+
| ID    |
+-------+
| 00128 |
| 45678 |
| 76543 |
| 98765 |
+-------+
4 rows in set (0.01 sec)

mysql> SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL;
+-------+
| ID    |
+-------+
| 45678 |
| 98988 |
+-------+
2 rows in set (0.00 sec)

使用JOIN的版本：

SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL;
SELECT DISTINCT a.ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
SELECT name, grade, course_id FROM student JOIN takes ON student.ID=takes.ID;
SELECT DISTINCT takes.ID, takes.course_id, title FROM course JOIN takes ON course.course_id=takes.course_id;

SELECT a1.name, a1.title, a1.grade FROM (
SELECT name, title, b.grade, a.ID FROM student a JOIN (
SELECT DISTINCT takes.ID, takes.course_id, title, grade FROM course JOIN takes ON course.course_id=takes.course_id
) b ON a.ID=b.ID ) a1 LEFT JOIN (
SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL
) b1 ON a1.ID=b1.ID WHERE b1.ID IS NULL;

mysql> SELECT a1.name, a1.title, a1.grade FROM (
    -> SELECT name, title, b.grade, a.ID FROM student a JOIN (
    -> SELECT DISTINCT takes.ID, takes.course_id, title, grade FROM course JOIN takes ON course.course_id=takes.course_id
    -> ) b ON a.ID=b.ID ) a1 LEFT JOIN (
    -> SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL
    -> ) b1 ON a1.ID=b1.ID WHERE b1.ID IS NULL;
+----------+----------------------------+-------+
| name     | title                      | grade |
+----------+----------------------------+-------+
| Zhang    | Intro. to Computer Science | A     |
| Zhang    | Database System Concepts   | A-    |
| Shankar  | Robotics                   | A     |
| Shankar  | Database System Concepts   | A     |
| Shankar  | Intro. to Computer Science | C     |
| Shankar  | Game Design                | A     |
| Brandt   | World History              | B     |
| Chavez   | Investment Banking         | C+    |
| Peltier  | Physical Principles        | B-    |
| Williams | Intro. to Computer Science | A-    |
| Williams | Game Design                | B+    |
| Sanchez  | Music Video Production     | A-    |
| Brown    | Intro. to Computer Science | A     |
| Brown    | Image Processing           | A     |
| Aoi      | Intro. to Digital Systems  | C     |
| Bourikas | Intro. to Computer Science | C-    |
| Bourikas | Robotics                   | B     |
+----------+----------------------------+-------+
17 rows in set (0.00 sec)

CREATE VIEW v AS (
SELECT a1.name, a1.title, a1.grade FROM (
SELECT name, title, b.grade, a.ID FROM student a JOIN (
SELECT DISTINCT takes.ID, takes.course_id, title, grade FROM course JOIN takes ON course.course_id=takes.course_id
) b ON a.ID=b.ID ) a1 LEFT JOIN (
SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL
) b1 ON a1.ID=b1.ID WHERE b1.ID IS NULL
);

mysql> CREATE VIEW v AS (
    -> SELECT a1.name, a1.title, a1.grade FROM (
    -> SELECT name, title, b.grade, a.ID FROM student a JOIN (
    -> SELECT DISTINCT takes.ID, takes.course_id, title, grade FROM course JOIN takes ON course.course_id=takes.course_id
    -> ) b ON a.ID=b.ID ) a1 LEFT JOIN (
    -> SELECT DISTINCT takes.ID FROM takes WHERE takes.grade='F' OR takes.grade IS NULL
    -> ) b1 ON a1.ID=b1.ID WHERE b1.ID IS NULL
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> SELECT * from v;
+----------+----------------------------+-------+
| name     | title                      | grade |
+----------+----------------------------+-------+
| Zhang    | Intro. to Computer Science | A     |
| Zhang    | Database System Concepts   | A-    |
| Shankar  | Robotics                   | A     |
| Shankar  | Database System Concepts   | A     |
| Shankar  | Intro. to Computer Science | C     |
| Shankar  | Game Design                | A     |
| Brandt   | World History              | B     |
| Chavez   | Investment Banking         | C+    |
| Peltier  | Physical Principles        | B-    |
| Williams | Intro. to Computer Science | A-    |
| Williams | Game Design                | B+    |
| Sanchez  | Music Video Production     | A-    |
| Brown    | Intro. to Computer Science | A     |
| Brown    | Image Processing           | A     |
| Aoi      | Intro. to Digital Systems  | C     |
| Bourikas | Intro. to Computer Science | C-    |
| Bourikas | Robotics                   | B     |
+----------+----------------------------+-------+
17 rows in set (0.04 sec)

--------------------------------------------------------------------
在上面的视图中查找所有至少有一门课程成绩为A或A-的学生姓名

SELECT DISTINCT name FROM v WHERE grade='A' OR grade='A-';

mysql> SELECT DISTINCT name FROM v WHERE grade='A' OR grade='A-';
+----------+
| name     |
+----------+
| Zhang    |
| Shankar  |
| Williams |
| Sanchez  |
| Brown    |
+----------+
5 rows in set (0.00 sec)


--------------------------------------------------------------------
删除上面的视图

DROP VIEW v;

mysql> DROP VIEW v;
Query OK, 0 rows affected (0.01 sec)

--------------------------------------------------------------------
按以下规则修改学生的tot_cred：
如果学生的tot_cred>100, 则加5分，否则减5分


UPDATE student SET tot_cred = 
CASE WHEN tot_cred>100 THEN tot_cred+5
ELSE tot_cred-5
END;

Query OK, 13 rows affected (0.28 sec)
Rows matched: 13  Changed: 13  Warnings: 0

mysql> select * from student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      107 |
| 12345 | Shankar  | Comp. Sci. |       27 |
| 19991 | Brandt   | History    |       75 |
| 23121 | Chavez   | Finance    |      115 |
| 44553 | Peltier  | Physics    |       51 |
| 45678 | Levy     | Physics    |       41 |
| 54321 | Williams | Comp. Sci. |       49 |
| 55739 | Sanchez  | Music      |       33 |
| 70557 | Snow     | Physics    |       -5 |
| 76543 | Brown    | Comp. Sci. |       53 |
| 76653 | Aoi      | Elec. Eng. |       55 |
| 98765 | Bourikas | Elec. Eng. |       93 |
| 98988 | Tanaka   | Biology    |      125 |
+-------+----------+------------+----------+
13 rows in set (0.01 sec)

--------------------------------------------------------------------
将student表恢复原状
即如果学生tot_cred>100,减5分，否则加5分


UPDATE student SET tot_cred = CASE
WHEN tot_cred>100 THEN tot_cred-5
ELSE tot_cred+5
END;

Query OK, 13 rows affected (0.01 sec)
Rows matched: 13  Changed: 13  Warnings: 0

mysql> SELECT * FROM student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 |
| 12345 | Shankar  | Comp. Sci. |       32 |
| 19991 | Brandt   | History    |       80 |
| 23121 | Chavez   | Finance    |      110 |
| 44553 | Peltier  | Physics    |       56 |
| 45678 | Levy     | Physics    |       46 |
| 54321 | Williams | Comp. Sci. |       54 |
| 55739 | Sanchez  | Music      |       38 |
| 70557 | Snow     | Physics    |        0 |
| 76543 | Brown    | Comp. Sci. |       58 |
| 76653 | Aoi      | Elec. Eng. |       60 |
| 98765 | Bourikas | Elec. Eng. |       98 |
| 98988 | Tanaka   | Biology    |      120 |
+-------+----------+------------+----------+
13 rows in set (0.00 sec)


--------------------------------------------------------------------

（选做）按以下规则修改学生tot_cred:
如果学生tot_cred<100,则加5分，但是增加后的分数不能超过100分

mysql> SELECT * FROM student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 |
| 12345 | Shankar  | Comp. Sci. |       32 |
| 19991 | Brandt   | History    |       80 |
| 23121 | Chavez   | Finance    |      110 |
| 44553 | Peltier  | Physics    |       56 |
| 45678 | Levy     | Physics    |       46 |
| 54321 | Williams | Comp. Sci. |       54 |
| 55739 | Sanchez  | Music      |       38 |
| 70557 | Snow     | Physics    |        0 |
| 76543 | Brown    | Comp. Sci. |       58 |
| 76653 | Aoi      | Elec. Eng. |       60 |
| 98765 | Bourikas | Elec. Eng. |       98 |
| 98988 | Tanaka   | Biology    |      120 |
+-------+----------+------------+----------+
13 rows in set (0.00 sec)


UPDATE student SET tot_cred = CASE
WHEN tot_cred<95 THEN tot_cred+5
WHEN tot_cred>96 AND tot_cred<100 THEN 100
ELSE tot_cred
END;

mysql> UPDATE student SET tot_cred = CASE
    -> WHEN tot_cred<95 THEN tot_cred+5
    -> WHEN tot_cred>96 AND tot_cred<100 THEN 100
    -> ELSE tot_cred
    -> END;
Query OK, 10 rows affected (0.00 sec)
Rows matched: 13  Changed: 10  Warnings: 0

mysql> SELECT * FROM student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 |
| 12345 | Shankar  | Comp. Sci. |       37 |
| 19991 | Brandt   | History    |       85 |
| 23121 | Chavez   | Finance    |      110 |
| 44553 | Peltier  | Physics    |       61 |
| 45678 | Levy     | Physics    |       51 |
| 54321 | Williams | Comp. Sci. |       59 |
| 55739 | Sanchez  | Music      |       43 |
| 70557 | Snow     | Physics    |        5 |
| 76543 | Brown    | Comp. Sci. |       63 |
| 76653 | Aoi      | Elec. Eng. |       65 |
| 98765 | Bourikas | Elec. Eng. |      100 |
| 98988 | Tanaka   | Biology    |      120 |
+-------+----------+------------+----------+
13 rows in set (0.00 sec)


trigger版：

首先创建trigger。

DELIMITER $$

CREATE TRIGGER before_student_update
BEFORE UPDATE ON student 
FOR EACH ROW 
BEGIN
	IF OLD.tot_cred>=95 AND OLD.tot_cred<=100 THEN SET NEW.tot_cred=100;
	END IF;
END;$$

DELIMITER ;

其次调用trigger。

UPDATE student SET tot_cred = CASE
WHEN tot_cred<100 THEN tot_cred+5
ELSE tot_cred
END;

mysql> select ID,tot_cred from student;
+-------+----------+
| ID    | tot_cred |
+-------+----------+
| 00128 |      102 |
| 12345 |       32 |
| 19991 |       80 |
| 23121 |      110 |
| 44553 |       56 |
| 45678 |       46 |
| 54321 |       54 |
| 55739 |       38 |
| 70557 |        0 |
| 76543 |       58 |
| 76653 |       60 |
| 98765 |       98 |
| 98988 |      120 |
+-------+----------+
13 rows in set (0.00 sec)

mysql> DELIMITER $$
mysql> CREATE TRIGGER before_student_update
    -> BEFORE UPDATE ON student 
    -> FOR EACH ROW 
    -> BEGIN
    -> IF OLD.tot_cred>=95 AND OLD.tot_cred<=100 THEN SET NEW.tot_cred=100;
    -> END IF;
    -> END;$$
Query OK, 0 rows affected (0.10 sec)

mysql> DELIMITER ;
mysql> UPDATE student SET tot_cred = CASE
    -> WHEN tot_cred<100 THEN tot_cred+5
    -> ELSE tot_cred
    -> END;
Query OK, 10 rows affected (0.00 sec)
Rows matched: 13  Changed: 10  Warnings: 0

mysql> select ID,tot_cred from student;
+-------+----------+
| ID    | tot_cred |
+-------+----------+
| 00128 |      102 |
| 12345 |       37 |
| 19991 |       85 |
| 23121 |      110 |
| 44553 |       61 |
| 45678 |       51 |
| 54321 |       59 |
| 55739 |       43 |
| 70557 |        5 |
| 76543 |       63 |
| 76653 |       65 |
| 98765 |      100 |
| 98988 |      120 |
+-------+----------+
13 rows in set (0.00 sec)

--------------------------------------------------------------------

在student表中增加一列birthday，数据类型为date

ALTER TABLE student ADD COLUMN birthday DATE;

Query OK, 0 rows affected (0.75 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from student;
+-------+----------+------------+----------+----------+
| ID    | name     | dept_name  | tot_cred | birthday |
+-------+----------+------------+----------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 | NULL     |
| 12345 | Shankar  | Comp. Sci. |       32 | NULL     |
| 19991 | Brandt   | History    |       80 | NULL     |
| 23121 | Chavez   | Finance    |      110 | NULL     |
| 44553 | Peltier  | Physics    |       56 | NULL     |
| 45678 | Levy     | Physics    |       46 | NULL     |
| 54321 | Williams | Comp. Sci. |       54 | NULL     |
| 55739 | Sanchez  | Music      |       38 | NULL     |
| 70557 | Snow     | Physics    |        0 | NULL     |
| 76543 | Brown    | Comp. Sci. |       58 | NULL     |
| 76653 | Aoi      | Elec. Eng. |       60 | NULL     |
| 98765 | Bourikas | Elec. Eng. |       98 | NULL     |
| 98988 | Tanaka   | Biology    |      120 | NULL     |
+-------+----------+------------+----------+----------+

--------------------------------------------------------------------

将所有学生的生日都设置为1990年1月1日，查看student表里的所有数据。

UPDATE student SET birthday='1990-01-01';

Query OK, 13 rows affected (0.02 sec)
Rows matched: 13  Changed: 13  Warnings: 0

mysql> select * from student;
+-------+----------+------------+----------+------------+
| ID    | name     | dept_name  | tot_cred | birthday   |
+-------+----------+------------+----------+------------+
| 00128 | Zhang    | Comp. Sci. |      102 | 1990-01-01 |
| 12345 | Shankar  | Comp. Sci. |       32 | 1990-01-01 |
| 19991 | Brandt   | History    |       80 | 1990-01-01 |
| 23121 | Chavez   | Finance    |      110 | 1990-01-01 |
| 44553 | Peltier  | Physics    |       56 | 1990-01-01 |
| 45678 | Levy     | Physics    |       46 | 1990-01-01 |
| 54321 | Williams | Comp. Sci. |       54 | 1990-01-01 |
| 55739 | Sanchez  | Music      |       38 | 1990-01-01 |
| 70557 | Snow     | Physics    |        0 | 1990-01-01 |
| 76543 | Brown    | Comp. Sci. |       58 | 1990-01-01 |
| 76653 | Aoi      | Elec. Eng. |       60 | 1990-01-01 |
| 98765 | Bourikas | Elec. Eng. |       98 | 1990-01-01 |
| 98988 | Tanaka   | Biology    |      120 | 1990-01-01 |
+-------+----------+------------+----------+------------+
13 rows in set (0.00 sec)


--------------------------------------------------------------------
删除列birthday


ALTER TABLE student DROP COLUMN birthday;

Query OK, 0 rows affected (0.20 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from student;
+-------+----------+------------+----------+
| ID    | name     | dept_name  | tot_cred |
+-------+----------+------------+----------+
| 00128 | Zhang    | Comp. Sci. |      102 |
| 12345 | Shankar  | Comp. Sci. |       32 |
| 19991 | Brandt   | History    |       80 |
| 23121 | Chavez   | Finance    |      110 |
| 44553 | Peltier  | Physics    |       56 |
| 45678 | Levy     | Physics    |       46 |
| 54321 | Williams | Comp. Sci. |       54 |
| 55739 | Sanchez  | Music      |       38 |
| 70557 | Snow     | Physics    |        0 |
| 76543 | Brown    | Comp. Sci. |       58 |
| 76653 | Aoi      | Elec. Eng. |       60 |
| 98765 | Bourikas | Elec. Eng. |       98 |
| 98988 | Tanaka   | Biology    |      120 |
+-------+----------+------------+----------+
13 rows in set (0.00 sec)



--------------------------------------------------------------------
查找7月份出生的学生学号、姓名和所在系

更新后的表：
mysql> select * from student;
+-------+----------+------------+----------+------------+
| ID    | name     | dept_name  | tot_cred | birthday   |
+-------+----------+------------+----------+------------+
| 00128 | Zhang    | Comp. Sci. |      102 | 1990-07-01 |
| 12345 | Shankar  | Comp. Sci. |       32 | 1990-09-05 |
| 19991 | Brandt   | History    |       80 | 1991-01-04 |
| 23121 | Chavez   | Finance    |      110 | 1990-08-13 |
| 44553 | Peltier  | Physics    |       56 | 1990-11-24 |
| 45678 | Levy     | Physics    |       46 | 1990-12-16 |
| 54321 | Williams | Comp. Sci. |       54 | 1991-03-05 |
| 55739 | Sanchez  | Music      |       38 | 1990-07-27 |
| 70557 | Snow     | Physics    |        0 | 1990-09-10 |
| 76543 | Brown    | Comp. Sci. |       58 | 1990-12-11 |
| 76653 | Aoi      | Elec. Eng. |       60 | 1991-02-12 |
| 98765 | Bourikas | Elec. Eng. |       98 | 1991-05-13 |
| 98988 | Tanaka   | Biology    |      120 | 1990-07-18 |
+-------+----------+------------+----------+------------+
13 rows in set (0.00 sec)

mysql> select * from instructor;
+-------+------------+------------+----------+------------+
| ID    | name       | dept_name  | salary   | birthday   |
+-------+------------+------------+----------+------------+
| 10101 | Srinivasan | Comp. Sci. | 65000.00 | 1960-07-01 |
| 12121 | Wu         | Finance    | 90000.00 | 1976-04-05 |
| 15151 | Mozart     | Music      | 40000.00 | 1981-04-04 |
| 22222 | Einstein   | Physics    | 95000.00 | 1977-08-13 |
| 32343 | El Said    | History    | 60000.00 | 1966-10-24 |
| 33456 | Gold       | Physics    | 87000.00 | 1974-12-18 |
| 45565 | Katz       | Comp. Sci. | 75000.00 | 1983-03-05 |
| 58583 | Califieri  | History    | 62000.00 | 1982-07-27 |
| 76543 | Singh      | Finance    | 80000.00 | 1972-10-11 |
| 76766 | Crick      | Biology    | 72000.00 | 1980-11-11 |
| 83821 | Brandt     | Comp. Sci. | 92000.00 | 1955-02-28 |
| 98345 | Kim        | Elec. Eng. | 80000.00 | NULL       |
+-------+------------+------------+----------+------------+
12 rows in set (0.00 sec)

SELECT ID, name, dept_name FROM student WHERE MONTH(birthday)=7;

mysql> SELECT ID, name, dept_name FROM student WHERE MONTH(birthday)=7;
+-------+---------+------------+
| ID    | name    | dept_name  |
+-------+---------+------------+
| 00128 | Zhang   | Comp. Sci. |
| 55739 | Sanchez | Music      |
| 98988 | Tanaka  | Biology    |
+-------+---------+------------+
3 rows in set (0.00 sec)


--------------------------------------------------------------------

查找生日相同的学生和老师，打印学生和老师的姓名以及他们的出生年月日

SELECT student.name AS stu_name, instructor.name AS ins_name, student.birthday FROM student, instructor
WHERE MONTH(student.birthday)=MONTH(instructor.birthday) AND DAY(student.birthday)=DAY(instructor.birthday);

mysql> SELECT student.name AS stu_name, instructor.name AS ins_name, student.birthday FROM student, instructor
    -> WHERE MONTH(student.birthday)=MONTH(instructor.birthday) AND DAY(student.birthday)=DAY(instructor.birthday);
+----------+------------+------------+
| stu_name | ins_name   | birthday   |
+----------+------------+------------+
| Zhang    | Srinivasan | 1990-07-01 |
| Chavez   | Einstein   | 1990-08-13 |
| Williams | Katz       | 1991-03-05 |
| Sanchez  | Califieri  | 1990-07-27 |
+----------+------------+------------+
4 rows in set (0.00 sec)

