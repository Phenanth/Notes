charlotte@ubuntu:~$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 5.7.21-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| DBLab              |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (1.10 sec)

mysql> use DBLab
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

usDatabase changed
emysql> show tables
    -> ;
+-----------------+
| Tables_in_DBLab |
+-----------------+
| advisor         |
| classroom       |
| course          |
| department      |
| instructor      |
| prereq          |
| section         |
| student         |
| takes           |
| teaches         |
| time_slot       |
+-----------------+
11 rows in set (0.06 sec)

mysql> select * from *;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '*' at line 1
mysql> select * from advisor;
+-------+-------+
| s_ID  | i_ID  |
+-------+-------+
| 12345 | 10101 |
| 44553 | 22222 |
| 45678 | 22222 |
| 00128 | 45565 |
| 76543 | 45565 |
| 23121 | 76543 |
| 98988 | 76766 |
| 76653 | 98345 |
| 98765 | 98345 |
+-------+-------+
9 rows in set (0.98 sec)

mysql> select * from classroom;
+----------+-------------+----------+
| building | room_number | capacity |
+----------+-------------+----------+
| Packard  | 101         |      500 |
| Painter  | 514         |       10 |
| Taylor   | 3128        |       70 |
| Watson   | 100         |       30 |
| Watson   | 120         |       50 |
+----------+-------------+----------+
5 rows in set (1.16 sec)

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
13 rows in set (0.18 sec)

mysql> select * from department;
+------------+----------+-----------+
| dept_name  | building | budget    |
+------------+----------+-----------+
| Biology    | Watson   |  90000.00 |
| Comp. Sci. | Taylor   | 100000.00 |
| Elec. Eng. | Taylor   |  85000.00 |
| Finance    | Painter  | 120000.00 |
| History    | Painter  |  50000.00 |
| Music      | Packard  |  80000.00 |
| Physics    | Watson   |  70000.00 |
+------------+----------+-----------+
7 rows in set (0.13 sec)

mysql> select * from instructor;
+-------+------------+------------+----------+
| ID    | name       | dept_name  | salary   |
+-------+------------+------------+----------+
| 10101 | Srinivasan | Comp. Sci. | 65000.00 |
| 12121 | Wu         | Finance    | 90000.00 |
| 15151 | Mozart     | Music      | 40000.00 |
| 22222 | Einstein   | Physics    | 95000.00 |
| 32343 | El Said    | History    | 60000.00 |
| 33456 | Gold       | Physics    | 87000.00 |
| 45565 | Katz       | Comp. Sci. | 75000.00 |
| 58583 | Califieri  | History    | 62000.00 |
| 76543 | Singh      | Finance    | 80000.00 |
| 76766 | Crick      | Biology    | 72000.00 |
| 83821 | Brandt     | Comp. Sci. | 92000.00 |
| 98345 | Kim        | Elec. Eng. | 80000.00 |
+-------+------------+------------+----------+
12 rows in set (0.04 sec)

mysql> select * from prereq;
+-----------+-----------+
| course_id | prereq_id |
+-----------+-----------+
| BIO-301   | BIO-101   |
| BIO-399   | BIO-101   |
| CS-190    | CS-101    |
| CS-315    | CS-101    |
| CS-319    | CS-101    |
| CS-347    | CS-101    |
| EE-181    | PHY-101   |
+-----------+-----------+
7 rows in set (0.10 sec)

mysql> select * from section;
+-----------+--------+----------+------+----------+-------------+--------------+
| course_id | sec_id | semester | year | building | room_number | time_slot_id |
+-----------+--------+----------+------+----------+-------------+--------------+
| BIO-101   | 1      | Summer   | 2009 | Painter  | 514         | B            |
| BIO-301   | 1      | Summer   | 2010 | Painter  | 514         | A            |
| CS-101    | 1      | Fall     | 2009 | Packard  | 101         | H            |
| CS-101    | 1      | Spring   | 2010 | Packard  | 101         | F            |
| CS-190    | 1      | Spring   | 2009 | Taylor   | 3128        | E            |
| CS-190    | 2      | Spring   | 2009 | Taylor   | 3128        | A            |
| CS-315    | 1      | Spring   | 2010 | Watson   | 120         | D            |
| CS-319    | 1      | Spring   | 2010 | Watson   | 100         | B            |
| CS-319    | 2      | Spring   | 2010 | Taylor   | 3128        | C            |
| CS-347    | 1      | Fall     | 2009 | Taylor   | 3128        | A            |
| EE-181    | 1      | Spring   | 2009 | Taylor   | 3128        | C            |
| FIN-201   | 1      | Spring   | 2010 | Packard  | 101         | B            |
| HIS-351   | 1      | Spring   | 2010 | Painter  | 514         | C            |
| MU-199    | 1      | Spring   | 2010 | Packard  | 101         | D            |
| PHY-101   | 1      | Fall     | 2009 | Watson   | 100         | A            |
+-----------+--------+----------+------+----------+-------------+--------------+
15 rows in set (0.05 sec)

mysql> select * from student;
select * f+-------+----------+------------+----------+
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
13 rows in set (1.88 sec)

mysql> select * from task;
ERROR 1146 (42S02): Table 'DBLab.task' doesn't exist
mysql> select * from tasks;
ERROR 1146 (42S02): Table 'DBLab.tasks' doesn't exist
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
22 rows in set (0.02 sec)

mysql> select * from teaches;
+-------+-----------+--------+----------+------+
| ID    | course_id | sec_id | semester | year |
+-------+-----------+--------+----------+------+
| 76766 | BIO-101   | 1      | Summer   | 2009 |
| 76766 | BIO-301   | 1      | Summer   | 2010 |
| 10101 | CS-101    | 1      | Fall     | 2009 |
| 45565 | CS-101    | 1      | Spring   | 2010 |
| 83821 | CS-190    | 1      | Spring   | 2009 |
| 83821 | CS-190    | 2      | Spring   | 2009 |
| 10101 | CS-315    | 1      | Spring   | 2010 |
| 45565 | CS-319    | 1      | Spring   | 2010 |
| 83821 | CS-319    | 2      | Spring   | 2010 |
| 10101 | CS-347    | 1      | Fall     | 2009 |
| 98345 | EE-181    | 1      | Spring   | 2009 |
| 12121 | FIN-201   | 1      | Spring   | 2010 |
| 32343 | HIS-351   | 1      | Spring   | 2010 |
| 15151 | MU-199    | 1      | Spring   | 2010 |
| 22222 | PHY-101   | 1      | Fall     | 2009 |
+-------+-----------+--------+----------+------+
15 rows in set (0.06 sec)

mysql> select * from time_slot;
+--------------+-----+----------+-----------+--------+---------+
| time_slot_id | day | start_hr | start_min | end_hr | end_min |
+--------------+-----+----------+-----------+--------+---------+
| A            | F   |        8 |         0 |      8 |      50 |
| A            | M   |        8 |         0 |      8 |      50 |
| A            | W   |        8 |         0 |      8 |      50 |
| B            | F   |        9 |         0 |      9 |      50 |
| B            | M   |        9 |         0 |      9 |      50 |
| B            | W   |        9 |         0 |      9 |      50 |
| C            | F   |       11 |         0 |     11 |      50 |
| C            | M   |       11 |         0 |     11 |      50 |
| C            | W   |       11 |         0 |     11 |      50 |
| D            | F   |       13 |         0 |     13 |      50 |
| D            | M   |       13 |         0 |     13 |      50 |
| D            | W   |       13 |         0 |     13 |      50 |
| E            | R   |       10 |        30 |     11 |      45 |
| E            | T   |       10 |        30 |     11 |      45 |
| F            | R   |       14 |        30 |     15 |      45 |
| F            | T   |       14 |        30 |     15 |      45 |
| G            | F   |       16 |         0 |     16 |      50 |
| G            | M   |       16 |         0 |     16 |      50 |
| G            | W   |       16 |         0 |     16 |      50 |
| H            | W   |       10 |         0 |     12 |      30 |
+--------------+-----+----------+-----------+--------+---------+
20 rows in set (0.08 sec)

mysql> SELECT ID,name,dept_name FROM student;
+-------+----------+------------+
| ID    | name     | dept_name  |
+-------+----------+------------+
| 00128 | Zhang    | Comp. Sci. |
| 12345 | Shankar  | Comp. Sci. |
| 19991 | Brandt   | History    |
| 23121 | Chavez   | Finance    |
| 44553 | Peltier  | Physics    |
| 45678 | Levy     | Physics    |
| 54321 | Williams | Comp. Sci. |
| 55739 | Sanchez  | Music      |
| 70557 | Snow     | Physics    |
| 76543 | Brown    | Comp. Sci. |
| 76653 | Aoi      | Elec. Eng. |
| 98765 | Bourikas | Elec. Eng. |
| 98988 | Tanaka   | Biology    |
+-------+----------+------------+
13 rows in set (0.38 sec)

mysql> SELECT name,tot_cred FROM student;
+----------+----------+
| name     | tot_cred |
+----------+----------+
| Zhang    |      102 |
| Shankar  |       32 |
| Brandt   |       80 |
| Chavez   |      110 |
| Peltier  |       56 |
| Levy     |       46 |
| Williams |       54 |
| Sanchez  |       38 |
| Snow     |        0 |
| Brown    |       58 |
| Aoi      |       60 |
| Bourikas |       98 |
| Tanaka   |      120 |
+----------+----------+
13 rows in set (0.00 sec)

mysql> SELECT name,tot_cred FROM student WHERE tot_cred>50;
+----------+----------+
| name     | tot_cred |
+----------+----------+
| Zhang    |      102 |
| Brandt   |       80 |
| Chavez   |      110 |
| Peltier  |       56 |
| Williams |       54 |
| Brown    |       58 |
| Aoi      |       60 |
| Bourikas |       98 |
| Tanaka   |      120 |
+----------+----------+
9 rows in set (0.17 sec)

mysql> SELECT * FROM course WHERE dept_name='Comp. Sci.';
+-----------+----------------------------+------------+---------+
| course_id | title                      | dept_name  | credits |
+-----------+----------------------------+------------+---------+
| CS-101    | Intro. to Computer Science | Comp. Sci. |       4 |
| CS-190    | Game Design                | Comp. Sci. |       4 |
| CS-315    | Robotics                   | Comp. Sci. |       3 |
| CS-319    | Image Processing           | Comp. Sci. |       3 |
| CS-347    | Database System Concepts   | Comp. Sci. |       3 |
+-----------+----------------------------+------------+---------+
5 rows in set (0.10 sec)

mysql> SELECT * FROM course WHERE title='Intro.%';
Empty set (0.00 sec)

mysql> SELECT * FROM course WHERE title='Intro%';
Empty set (0.00 sec)

mysql> SELECT * FROM course WHERE title LIKE 'Intro%';
+-----------+----------------------------+------------+---------+
| course_id | title                      | dept_name  | credits |
+-----------+----------------------------+------------+---------+
| BIO-101   | Intro. to Biology          | Biology    |       4 |
| CS-101    | Intro. to Computer Science | Comp. Sci. |       4 |
| EE-181    | Intro. to Digital Systems  | Elec. Eng. |       3 |
+-----------+----------------------------+------------+---------+
3 rows in set (0.03 sec)

mysql> SELECT ID FROM takes WHERE course_id NOT 'CS-190';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''CS-190'' at line 1
mysql>  SELECT ID FROM takes WHERE course_id<>'CS-190';
+-------+
| ID    |
+-------+
| 98988 |
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
20 rows in set (0.08 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' AND course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.08 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190';
+-------+
| ID    |
+-------+
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
12 rows in set (0.04 sec)

mysql> SELECT ID,course_id,grade FROM takes ORDER BY ID;
+-------+-----------+-------+
| ID    | course_id | grade |
+-------+-----------+-------+
| 00128 | CS-101    | A     |
| 00128 | CS-347    | A-    |
| 12345 | CS-101    | C     |
| 12345 | CS-190    | A     |
| 12345 | CS-315    | A     |
| 12345 | CS-347    | A     |
| 19991 | HIS-351   | B     |
| 23121 | FIN-201   | C+    |
| 44553 | PHY-101   | B-    |
| 45678 | CS-101    | F     |
| 45678 | CS-101    | B+    |
| 45678 | CS-319    | B     |
| 54321 | CS-101    | A-    |
| 54321 | CS-190    | B+    |
| 55739 | MU-199    | A-    |
| 76543 | CS-101    | A     |
| 76543 | CS-319    | A     |
| 76653 | EE-181    | C     |
| 98765 | CS-101    | C-    |
| 98765 | CS-315    | B     |
| 98988 | BIO-101   | A     |
| 98988 | BIO-301   | NULL  |
+-------+-----------+-------+
22 rows in set (0.05 sec)

mysql> SELECT ID,name,course_id,grade FROM takes,student;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT takes.ID,name,course_id,grade FROM takes,student;
+-------+----------+-----------+-------+
| ID    | name     | course_id | grade |
+-------+----------+-----------+-------+
| 00128 | Zhang    | CS-101    | A     |
| 00128 | Shankar  | CS-101    | A     |
| 00128 | Brandt   | CS-101    | A     |
| 00128 | Chavez   | CS-101    | A     |
| 00128 | Peltier  | CS-101    | A     |
| 00128 | Levy     | CS-101    | A     |
| 00128 | Williams | CS-101    | A     |
| 00128 | Sanchez  | CS-101    | A     |
| 00128 | Snow     | CS-101    | A     |
| 00128 | Brown    | CS-101    | A     |
| 00128 | Aoi      | CS-101    | A     |
| 00128 | Bourikas | CS-101    | A     |
| 00128 | Tanaka   | CS-101    | A     |
| 00128 | Zhang    | CS-347    | A-    |
| 00128 | Shankar  | CS-347    | A-    |
| 00128 | Brandt   | CS-347    | A-    |
| 00128 | Chavez   | CS-347    | A-    |
| 00128 | Peltier  | CS-347    | A-    |
| 00128 | Levy     | CS-347    | A-    |
| 00128 | Williams | CS-347    | A-    |
| 00128 | Sanchez  | CS-347    | A-    |
| 00128 | Snow     | CS-347    | A-    |
| 00128 | Brown    | CS-347    | A-    |
| 00128 | Aoi      | CS-347    | A-    |
| 00128 | Bourikas | CS-347    | A-    |
| 00128 | Tanaka   | CS-347    | A-    |
| 12345 | Zhang    | CS-101    | C     |
| 12345 | Shankar  | CS-101    | C     |
| 12345 | Brandt   | CS-101    | C     |
| 12345 | Chavez   | CS-101    | C     |
| 12345 | Peltier  | CS-101    | C     |
| 12345 | Levy     | CS-101    | C     |
| 12345 | Williams | CS-101    | C     |
| 12345 | Sanchez  | CS-101    | C     |
| 12345 | Snow     | CS-101    | C     |
| 12345 | Brown    | CS-101    | C     |
| 12345 | Aoi      | CS-101    | C     |
| 12345 | Bourikas | CS-101    | C     |
| 12345 | Tanaka   | CS-101    | C     |
| 12345 | Zhang    | CS-190    | A     |
| 12345 | Shankar  | CS-190    | A     |
| 12345 | Brandt   | CS-190    | A     |
| 12345 | Chavez   | CS-190    | A     |
| 12345 | Peltier  | CS-190    | A     |
| 12345 | Levy     | CS-190    | A     |
| 12345 | Williams | CS-190    | A     |
| 12345 | Sanchez  | CS-190    | A     |
| 12345 | Snow     | CS-190    | A     |
| 12345 | Brown    | CS-190    | A     |
| 12345 | Aoi      | CS-190    | A     |
| 12345 | Bourikas | CS-190    | A     |
| 12345 | Tanaka   | CS-190    | A     |
| 12345 | Zhang    | CS-315    | A     |
| 12345 | Shankar  | CS-315    | A     |
| 12345 | Brandt   | CS-315    | A     |
| 12345 | Chavez   | CS-315    | A     |
| 12345 | Peltier  | CS-315    | A     |
| 12345 | Levy     | CS-315    | A     |
| 12345 | Williams | CS-315    | A     |
| 12345 | Sanchez  | CS-315    | A     |
| 12345 | Snow     | CS-315    | A     |
| 12345 | Brown    | CS-315    | A     |
| 12345 | Aoi      | CS-315    | A     |
| 12345 | Bourikas | CS-315    | A     |
| 12345 | Tanaka   | CS-315    | A     |
| 12345 | Zhang    | CS-347    | A     |
| 12345 | Shankar  | CS-347    | A     |
| 12345 | Brandt   | CS-347    | A     |
| 12345 | Chavez   | CS-347    | A     |
| 12345 | Peltier  | CS-347    | A     |
| 12345 | Levy     | CS-347    | A     |
| 12345 | Williams | CS-347    | A     |
| 12345 | Sanchez  | CS-347    | A     |
| 12345 | Snow     | CS-347    | A     |
| 12345 | Brown    | CS-347    | A     |
| 12345 | Aoi      | CS-347    | A     |
| 12345 | Bourikas | CS-347    | A     |
| 12345 | Tanaka   | CS-347    | A     |
| 19991 | Zhang    | HIS-351   | B     |
| 19991 | Shankar  | HIS-351   | B     |
| 19991 | Brandt   | HIS-351   | B     |
| 19991 | Chavez   | HIS-351   | B     |
| 19991 | Peltier  | HIS-351   | B     |
| 19991 | Levy     | HIS-351   | B     |
| 19991 | Williams | HIS-351   | B     |
| 19991 | Sanchez  | HIS-351   | B     |
| 19991 | Snow     | HIS-351   | B     |
| 19991 | Brown    | HIS-351   | B     |
| 19991 | Aoi      | HIS-351   | B     |
| 19991 | Bourikas | HIS-351   | B     |
| 19991 | Tanaka   | HIS-351   | B     |
| 23121 | Zhang    | FIN-201   | C+    |
| 23121 | Shankar  | FIN-201   | C+    |
| 23121 | Brandt   | FIN-201   | C+    |
| 23121 | Chavez   | FIN-201   | C+    |
| 23121 | Peltier  | FIN-201   | C+    |
| 23121 | Levy     | FIN-201   | C+    |
| 23121 | Williams | FIN-201   | C+    |
| 23121 | Sanchez  | FIN-201   | C+    |
| 23121 | Snow     | FIN-201   | C+    |
| 23121 | Brown    | FIN-201   | C+    |
| 23121 | Aoi      | FIN-201   | C+    |
| 23121 | Bourikas | FIN-201   | C+    |
| 23121 | Tanaka   | FIN-201   | C+    |
| 44553 | Zhang    | PHY-101   | B-    |
| 44553 | Shankar  | PHY-101   | B-    |
| 44553 | Brandt   | PHY-101   | B-    |
| 44553 | Chavez   | PHY-101   | B-    |
| 44553 | Peltier  | PHY-101   | B-    |
| 44553 | Levy     | PHY-101   | B-    |
| 44553 | Williams | PHY-101   | B-    |
| 44553 | Sanchez  | PHY-101   | B-    |
| 44553 | Snow     | PHY-101   | B-    |
| 44553 | Brown    | PHY-101   | B-    |
| 44553 | Aoi      | PHY-101   | B-    |
| 44553 | Bourikas | PHY-101   | B-    |
| 44553 | Tanaka   | PHY-101   | B-    |
| 45678 | Zhang    | CS-101    | F     |
| 45678 | Shankar  | CS-101    | F     |
| 45678 | Brandt   | CS-101    | F     |
| 45678 | Chavez   | CS-101    | F     |
| 45678 | Peltier  | CS-101    | F     |
| 45678 | Levy     | CS-101    | F     |
| 45678 | Williams | CS-101    | F     |
| 45678 | Sanchez  | CS-101    | F     |
| 45678 | Snow     | CS-101    | F     |
| 45678 | Brown    | CS-101    | F     |
| 45678 | Aoi      | CS-101    | F     |
| 45678 | Bourikas | CS-101    | F     |
| 45678 | Tanaka   | CS-101    | F     |
| 45678 | Zhang    | CS-101    | B+    |
| 45678 | Shankar  | CS-101    | B+    |
| 45678 | Brandt   | CS-101    | B+    |
| 45678 | Chavez   | CS-101    | B+    |
| 45678 | Peltier  | CS-101    | B+    |
| 45678 | Levy     | CS-101    | B+    |
| 45678 | Williams | CS-101    | B+    |
| 45678 | Sanchez  | CS-101    | B+    |
| 45678 | Snow     | CS-101    | B+    |
| 45678 | Brown    | CS-101    | B+    |
| 45678 | Aoi      | CS-101    | B+    |
| 45678 | Bourikas | CS-101    | B+    |
| 45678 | Tanaka   | CS-101    | B+    |
| 45678 | Zhang    | CS-319    | B     |
| 45678 | Shankar  | CS-319    | B     |
| 45678 | Brandt   | CS-319    | B     |
| 45678 | Chavez   | CS-319    | B     |
| 45678 | Peltier  | CS-319    | B     |
| 45678 | Levy     | CS-319    | B     |
| 45678 | Williams | CS-319    | B     |
| 45678 | Sanchez  | CS-319    | B     |
| 45678 | Snow     | CS-319    | B     |
| 45678 | Brown    | CS-319    | B     |
| 45678 | Aoi      | CS-319    | B     |
| 45678 | Bourikas | CS-319    | B     |
| 45678 | Tanaka   | CS-319    | B     |
| 54321 | Zhang    | CS-101    | A-    |
| 54321 | Shankar  | CS-101    | A-    |
| 54321 | Brandt   | CS-101    | A-    |
| 54321 | Chavez   | CS-101    | A-    |
| 54321 | Peltier  | CS-101    | A-    |
| 54321 | Levy     | CS-101    | A-    |
| 54321 | Williams | CS-101    | A-    |
| 54321 | Sanchez  | CS-101    | A-    |
| 54321 | Snow     | CS-101    | A-    |
| 54321 | Brown    | CS-101    | A-    |
| 54321 | Aoi      | CS-101    | A-    |
| 54321 | Bourikas | CS-101    | A-    |
| 54321 | Tanaka   | CS-101    | A-    |
| 54321 | Zhang    | CS-190    | B+    |
| 54321 | Shankar  | CS-190    | B+    |
| 54321 | Brandt   | CS-190    | B+    |
| 54321 | Chavez   | CS-190    | B+    |
| 54321 | Peltier  | CS-190    | B+    |
| 54321 | Levy     | CS-190    | B+    |
| 54321 | Williams | CS-190    | B+    |
| 54321 | Sanchez  | CS-190    | B+    |
| 54321 | Snow     | CS-190    | B+    |
| 54321 | Brown    | CS-190    | B+    |
| 54321 | Aoi      | CS-190    | B+    |
| 54321 | Bourikas | CS-190    | B+    |
| 54321 | Tanaka   | CS-190    | B+    |
| 55739 | Zhang    | MU-199    | A-    |
| 55739 | Shankar  | MU-199    | A-    |
| 55739 | Brandt   | MU-199    | A-    |
| 55739 | Chavez   | MU-199    | A-    |
| 55739 | Peltier  | MU-199    | A-    |
| 55739 | Levy     | MU-199    | A-    |
| 55739 | Williams | MU-199    | A-    |
| 55739 | Sanchez  | MU-199    | A-    |
| 55739 | Snow     | MU-199    | A-    |
| 55739 | Brown    | MU-199    | A-    |
| 55739 | Aoi      | MU-199    | A-    |
| 55739 | Bourikas | MU-199    | A-    |
| 55739 | Tanaka   | MU-199    | A-    |
| 76543 | Zhang    | CS-101    | A     |
| 76543 | Shankar  | CS-101    | A     |
| 76543 | Brandt   | CS-101    | A     |
| 76543 | Chavez   | CS-101    | A     |
| 76543 | Peltier  | CS-101    | A     |
| 76543 | Levy     | CS-101    | A     |
| 76543 | Williams | CS-101    | A     |
| 76543 | Sanchez  | CS-101    | A     |
| 76543 | Snow     | CS-101    | A     |
| 76543 | Brown    | CS-101    | A     |
| 76543 | Aoi      | CS-101    | A     |
| 76543 | Bourikas | CS-101    | A     |
| 76543 | Tanaka   | CS-101    | A     |
| 76543 | Zhang    | CS-319    | A     |
| 76543 | Shankar  | CS-319    | A     |
| 76543 | Brandt   | CS-319    | A     |
| 76543 | Chavez   | CS-319    | A     |
| 76543 | Peltier  | CS-319    | A     |
| 76543 | Levy     | CS-319    | A     |
| 76543 | Williams | CS-319    | A     |
| 76543 | Sanchez  | CS-319    | A     |
| 76543 | Snow     | CS-319    | A     |
| 76543 | Brown    | CS-319    | A     |
| 76543 | Aoi      | CS-319    | A     |
| 76543 | Bourikas | CS-319    | A     |
| 76543 | Tanaka   | CS-319    | A     |
| 76653 | Zhang    | EE-181    | C     |
| 76653 | Shankar  | EE-181    | C     |
| 76653 | Brandt   | EE-181    | C     |
| 76653 | Chavez   | EE-181    | C     |
| 76653 | Peltier  | EE-181    | C     |
| 76653 | Levy     | EE-181    | C     |
| 76653 | Williams | EE-181    | C     |
| 76653 | Sanchez  | EE-181    | C     |
| 76653 | Snow     | EE-181    | C     |
| 76653 | Brown    | EE-181    | C     |
| 76653 | Aoi      | EE-181    | C     |
| 76653 | Bourikas | EE-181    | C     |
| 76653 | Tanaka   | EE-181    | C     |
| 98765 | Zhang    | CS-101    | C-    |
| 98765 | Shankar  | CS-101    | C-    |
| 98765 | Brandt   | CS-101    | C-    |
| 98765 | Chavez   | CS-101    | C-    |
| 98765 | Peltier  | CS-101    | C-    |
| 98765 | Levy     | CS-101    | C-    |
| 98765 | Williams | CS-101    | C-    |
| 98765 | Sanchez  | CS-101    | C-    |
| 98765 | Snow     | CS-101    | C-    |
| 98765 | Brown    | CS-101    | C-    |
| 98765 | Aoi      | CS-101    | C-    |
| 98765 | Bourikas | CS-101    | C-    |
| 98765 | Tanaka   | CS-101    | C-    |
| 98765 | Zhang    | CS-315    | B     |
| 98765 | Shankar  | CS-315    | B     |
| 98765 | Brandt   | CS-315    | B     |
| 98765 | Chavez   | CS-315    | B     |
| 98765 | Peltier  | CS-315    | B     |
| 98765 | Levy     | CS-315    | B     |
| 98765 | Williams | CS-315    | B     |
| 98765 | Sanchez  | CS-315    | B     |
| 98765 | Snow     | CS-315    | B     |
| 98765 | Brown    | CS-315    | B     |
| 98765 | Aoi      | CS-315    | B     |
| 98765 | Bourikas | CS-315    | B     |
| 98765 | Tanaka   | CS-315    | B     |
| 98988 | Zhang    | BIO-101   | A     |
| 98988 | Shankar  | BIO-101   | A     |
| 98988 | Brandt   | BIO-101   | A     |
| 98988 | Chavez   | BIO-101   | A     |
| 98988 | Peltier  | BIO-101   | A     |
| 98988 | Levy     | BIO-101   | A     |
| 98988 | Williams | BIO-101   | A     |
| 98988 | Sanchez  | BIO-101   | A     |
| 98988 | Snow     | BIO-101   | A     |
| 98988 | Brown    | BIO-101   | A     |
| 98988 | Aoi      | BIO-101   | A     |
| 98988 | Bourikas | BIO-101   | A     |
| 98988 | Tanaka   | BIO-101   | A     |
| 98988 | Zhang    | BIO-301   | NULL  |
| 98988 | Shankar  | BIO-301   | NULL  |
| 98988 | Brandt   | BIO-301   | NULL  |
| 98988 | Chavez   | BIO-301   | NULL  |
| 98988 | Peltier  | BIO-301   | NULL  |
| 98988 | Levy     | BIO-301   | NULL  |
| 98988 | Williams | BIO-301   | NULL  |
| 98988 | Sanchez  | BIO-301   | NULL  |
| 98988 | Snow     | BIO-301   | NULL  |
| 98988 | Brown    | BIO-301   | NULL  |
| 98988 | Aoi      | BIO-301   | NULL  |
| 98988 | Bourikas | BIO-301   | NULL  |
| 98988 | Tanaka   | BIO-301   | NULL  |
+-------+----------+-----------+-------+
286 rows in set (0.03 sec)

mysql> SELECT DISTINCT takes.ID,name,course_id,grade FROM student,takes;
+-------+----------+-----------+-------+
| ID    | name     | course_id | grade |
+-------+----------+-----------+-------+
| 00128 | Zhang    | CS-101    | A     |
| 00128 | Shankar  | CS-101    | A     |
| 00128 | Brandt   | CS-101    | A     |
| 00128 | Chavez   | CS-101    | A     |
| 00128 | Peltier  | CS-101    | A     |
| 00128 | Levy     | CS-101    | A     |
| 00128 | Williams | CS-101    | A     |
| 00128 | Sanchez  | CS-101    | A     |
| 00128 | Snow     | CS-101    | A     |
| 00128 | Brown    | CS-101    | A     |
| 00128 | Aoi      | CS-101    | A     |
| 00128 | Bourikas | CS-101    | A     |
| 00128 | Tanaka   | CS-101    | A     |
| 00128 | Zhang    | CS-347    | A-    |
| 00128 | Shankar  | CS-347    | A-    |
| 00128 | Brandt   | CS-347    | A-    |
| 00128 | Chavez   | CS-347    | A-    |
| 00128 | Peltier  | CS-347    | A-    |
| 00128 | Levy     | CS-347    | A-    |
| 00128 | Williams | CS-347    | A-    |
| 00128 | Sanchez  | CS-347    | A-    |
| 00128 | Snow     | CS-347    | A-    |
| 00128 | Brown    | CS-347    | A-    |
| 00128 | Aoi      | CS-347    | A-    |
| 00128 | Bourikas | CS-347    | A-    |
| 00128 | Tanaka   | CS-347    | A-    |
| 12345 | Zhang    | CS-101    | C     |
| 12345 | Shankar  | CS-101    | C     |
| 12345 | Brandt   | CS-101    | C     |
| 12345 | Chavez   | CS-101    | C     |
| 12345 | Peltier  | CS-101    | C     |
| 12345 | Levy     | CS-101    | C     |
| 12345 | Williams | CS-101    | C     |
| 12345 | Sanchez  | CS-101    | C     |
| 12345 | Snow     | CS-101    | C     |
| 12345 | Brown    | CS-101    | C     |
| 12345 | Aoi      | CS-101    | C     |
| 12345 | Bourikas | CS-101    | C     |
| 12345 | Tanaka   | CS-101    | C     |
| 12345 | Zhang    | CS-190    | A     |
| 12345 | Shankar  | CS-190    | A     |
| 12345 | Brandt   | CS-190    | A     |
| 12345 | Chavez   | CS-190    | A     |
| 12345 | Peltier  | CS-190    | A     |
| 12345 | Levy     | CS-190    | A     |
| 12345 | Williams | CS-190    | A     |
| 12345 | Sanchez  | CS-190    | A     |
| 12345 | Snow     | CS-190    | A     |
| 12345 | Brown    | CS-190    | A     |
| 12345 | Aoi      | CS-190    | A     |
| 12345 | Bourikas | CS-190    | A     |
| 12345 | Tanaka   | CS-190    | A     |
| 12345 | Zhang    | CS-315    | A     |
| 12345 | Shankar  | CS-315    | A     |
| 12345 | Brandt   | CS-315    | A     |
| 12345 | Chavez   | CS-315    | A     |
| 12345 | Peltier  | CS-315    | A     |
| 12345 | Levy     | CS-315    | A     |
| 12345 | Williams | CS-315    | A     |
| 12345 | Sanchez  | CS-315    | A     |
| 12345 | Snow     | CS-315    | A     |
| 12345 | Brown    | CS-315    | A     |
| 12345 | Aoi      | CS-315    | A     |
| 12345 | Bourikas | CS-315    | A     |
| 12345 | Tanaka   | CS-315    | A     |
| 12345 | Zhang    | CS-347    | A     |
| 12345 | Shankar  | CS-347    | A     |
| 12345 | Brandt   | CS-347    | A     |
| 12345 | Chavez   | CS-347    | A     |
| 12345 | Peltier  | CS-347    | A     |
| 12345 | Levy     | CS-347    | A     |
| 12345 | Williams | CS-347    | A     |
| 12345 | Sanchez  | CS-347    | A     |
| 12345 | Snow     | CS-347    | A     |
| 12345 | Brown    | CS-347    | A     |
| 12345 | Aoi      | CS-347    | A     |
| 12345 | Bourikas | CS-347    | A     |
| 12345 | Tanaka   | CS-347    | A     |
| 19991 | Zhang    | HIS-351   | B     |
| 19991 | Shankar  | HIS-351   | B     |
| 19991 | Brandt   | HIS-351   | B     |
| 19991 | Chavez   | HIS-351   | B     |
| 19991 | Peltier  | HIS-351   | B     |
| 19991 | Levy     | HIS-351   | B     |
| 19991 | Williams | HIS-351   | B     |
| 19991 | Sanchez  | HIS-351   | B     |
| 19991 | Snow     | HIS-351   | B     |
| 19991 | Brown    | HIS-351   | B     |
| 19991 | Aoi      | HIS-351   | B     |
| 19991 | Bourikas | HIS-351   | B     |
| 19991 | Tanaka   | HIS-351   | B     |
| 23121 | Zhang    | FIN-201   | C+    |
| 23121 | Shankar  | FIN-201   | C+    |
| 23121 | Brandt   | FIN-201   | C+    |
| 23121 | Chavez   | FIN-201   | C+    |
| 23121 | Peltier  | FIN-201   | C+    |
| 23121 | Levy     | FIN-201   | C+    |
| 23121 | Williams | FIN-201   | C+    |
| 23121 | Sanchez  | FIN-201   | C+    |
| 23121 | Snow     | FIN-201   | C+    |
| 23121 | Brown    | FIN-201   | C+    |
| 23121 | Aoi      | FIN-201   | C+    |
| 23121 | Bourikas | FIN-201   | C+    |
| 23121 | Tanaka   | FIN-201   | C+    |
| 44553 | Zhang    | PHY-101   | B-    |
| 44553 | Shankar  | PHY-101   | B-    |
| 44553 | Brandt   | PHY-101   | B-    |
| 44553 | Chavez   | PHY-101   | B-    |
| 44553 | Peltier  | PHY-101   | B-    |
| 44553 | Levy     | PHY-101   | B-    |
| 44553 | Williams | PHY-101   | B-    |
| 44553 | Sanchez  | PHY-101   | B-    |
| 44553 | Snow     | PHY-101   | B-    |
| 44553 | Brown    | PHY-101   | B-    |
| 44553 | Aoi      | PHY-101   | B-    |
| 44553 | Bourikas | PHY-101   | B-    |
| 44553 | Tanaka   | PHY-101   | B-    |
| 45678 | Zhang    | CS-101    | F     |
| 45678 | Shankar  | CS-101    | F     |
| 45678 | Brandt   | CS-101    | F     |
| 45678 | Chavez   | CS-101    | F     |
| 45678 | Peltier  | CS-101    | F     |
| 45678 | Levy     | CS-101    | F     |
| 45678 | Williams | CS-101    | F     |
| 45678 | Sanchez  | CS-101    | F     |
| 45678 | Snow     | CS-101    | F     |
| 45678 | Brown    | CS-101    | F     |
| 45678 | Aoi      | CS-101    | F     |
| 45678 | Bourikas | CS-101    | F     |
| 45678 | Tanaka   | CS-101    | F     |
| 45678 | Zhang    | CS-101    | B+    |
| 45678 | Shankar  | CS-101    | B+    |
| 45678 | Brandt   | CS-101    | B+    |
| 45678 | Chavez   | CS-101    | B+    |
| 45678 | Peltier  | CS-101    | B+    |
| 45678 | Levy     | CS-101    | B+    |
| 45678 | Williams | CS-101    | B+    |
| 45678 | Sanchez  | CS-101    | B+    |
| 45678 | Snow     | CS-101    | B+    |
| 45678 | Brown    | CS-101    | B+    |
| 45678 | Aoi      | CS-101    | B+    |
| 45678 | Bourikas | CS-101    | B+    |
| 45678 | Tanaka   | CS-101    | B+    |
| 45678 | Zhang    | CS-319    | B     |
| 45678 | Shankar  | CS-319    | B     |
| 45678 | Brandt   | CS-319    | B     |
| 45678 | Chavez   | CS-319    | B     |
| 45678 | Peltier  | CS-319    | B     |
| 45678 | Levy     | CS-319    | B     |
| 45678 | Williams | CS-319    | B     |
| 45678 | Sanchez  | CS-319    | B     |
| 45678 | Snow     | CS-319    | B     |
| 45678 | Brown    | CS-319    | B     |
| 45678 | Aoi      | CS-319    | B     |
| 45678 | Bourikas | CS-319    | B     |
| 45678 | Tanaka   | CS-319    | B     |
| 54321 | Zhang    | CS-101    | A-    |
| 54321 | Shankar  | CS-101    | A-    |
| 54321 | Brandt   | CS-101    | A-    |
| 54321 | Chavez   | CS-101    | A-    |
| 54321 | Peltier  | CS-101    | A-    |
| 54321 | Levy     | CS-101    | A-    |
| 54321 | Williams | CS-101    | A-    |
| 54321 | Sanchez  | CS-101    | A-    |
| 54321 | Snow     | CS-101    | A-    |
| 54321 | Brown    | CS-101    | A-    |
| 54321 | Aoi      | CS-101    | A-    |
| 54321 | Bourikas | CS-101    | A-    |
| 54321 | Tanaka   | CS-101    | A-    |
| 54321 | Zhang    | CS-190    | B+    |
| 54321 | Shankar  | CS-190    | B+    |
| 54321 | Brandt   | CS-190    | B+    |
| 54321 | Chavez   | CS-190    | B+    |
| 54321 | Peltier  | CS-190    | B+    |
| 54321 | Levy     | CS-190    | B+    |
| 54321 | Williams | CS-190    | B+    |
| 54321 | Sanchez  | CS-190    | B+    |
| 54321 | Snow     | CS-190    | B+    |
| 54321 | Brown    | CS-190    | B+    |
| 54321 | Aoi      | CS-190    | B+    |
| 54321 | Bourikas | CS-190    | B+    |
| 54321 | Tanaka   | CS-190    | B+    |
| 55739 | Zhang    | MU-199    | A-    |
| 55739 | Shankar  | MU-199    | A-    |
| 55739 | Brandt   | MU-199    | A-    |
| 55739 | Chavez   | MU-199    | A-    |
| 55739 | Peltier  | MU-199    | A-    |
| 55739 | Levy     | MU-199    | A-    |
| 55739 | Williams | MU-199    | A-    |
| 55739 | Sanchez  | MU-199    | A-    |
| 55739 | Snow     | MU-199    | A-    |
| 55739 | Brown    | MU-199    | A-    |
| 55739 | Aoi      | MU-199    | A-    |
| 55739 | Bourikas | MU-199    | A-    |
| 55739 | Tanaka   | MU-199    | A-    |
| 76543 | Zhang    | CS-101    | A     |
| 76543 | Shankar  | CS-101    | A     |
| 76543 | Brandt   | CS-101    | A     |
| 76543 | Chavez   | CS-101    | A     |
| 76543 | Peltier  | CS-101    | A     |
| 76543 | Levy     | CS-101    | A     |
| 76543 | Williams | CS-101    | A     |
| 76543 | Sanchez  | CS-101    | A     |
| 76543 | Snow     | CS-101    | A     |
| 76543 | Brown    | CS-101    | A     |
| 76543 | Aoi      | CS-101    | A     |
| 76543 | Bourikas | CS-101    | A     |
| 76543 | Tanaka   | CS-101    | A     |
| 76543 | Zhang    | CS-319    | A     |
| 76543 | Shankar  | CS-319    | A     |
| 76543 | Brandt   | CS-319    | A     |
| 76543 | Chavez   | CS-319    | A     |
| 76543 | Peltier  | CS-319    | A     |
| 76543 | Levy     | CS-319    | A     |
| 76543 | Williams | CS-319    | A     |
| 76543 | Sanchez  | CS-319    | A     |
| 76543 | Snow     | CS-319    | A     |
| 76543 | Brown    | CS-319    | A     |
| 76543 | Aoi      | CS-319    | A     |
| 76543 | Bourikas | CS-319    | A     |
| 76543 | Tanaka   | CS-319    | A     |
| 76653 | Zhang    | EE-181    | C     |
| 76653 | Shankar  | EE-181    | C     |
| 76653 | Brandt   | EE-181    | C     |
| 76653 | Chavez   | EE-181    | C     |
| 76653 | Peltier  | EE-181    | C     |
| 76653 | Levy     | EE-181    | C     |
| 76653 | Williams | EE-181    | C     |
| 76653 | Sanchez  | EE-181    | C     |
| 76653 | Snow     | EE-181    | C     |
| 76653 | Brown    | EE-181    | C     |
| 76653 | Aoi      | EE-181    | C     |
| 76653 | Bourikas | EE-181    | C     |
| 76653 | Tanaka   | EE-181    | C     |
| 98765 | Zhang    | CS-101    | C-    |
| 98765 | Shankar  | CS-101    | C-    |
| 98765 | Brandt   | CS-101    | C-    |
| 98765 | Chavez   | CS-101    | C-    |
| 98765 | Peltier  | CS-101    | C-    |
| 98765 | Levy     | CS-101    | C-    |
| 98765 | Williams | CS-101    | C-    |
| 98765 | Sanchez  | CS-101    | C-    |
| 98765 | Snow     | CS-101    | C-    |
| 98765 | Brown    | CS-101    | C-    |
| 98765 | Aoi      | CS-101    | C-    |
| 98765 | Bourikas | CS-101    | C-    |
| 98765 | Tanaka   | CS-101    | C-    |
| 98765 | Zhang    | CS-315    | B     |
| 98765 | Shankar  | CS-315    | B     |
| 98765 | Brandt   | CS-315    | B     |
| 98765 | Chavez   | CS-315    | B     |
| 98765 | Peltier  | CS-315    | B     |
| 98765 | Levy     | CS-315    | B     |
| 98765 | Williams | CS-315    | B     |
| 98765 | Sanchez  | CS-315    | B     |
| 98765 | Snow     | CS-315    | B     |
| 98765 | Brown    | CS-315    | B     |
| 98765 | Aoi      | CS-315    | B     |
| 98765 | Bourikas | CS-315    | B     |
| 98765 | Tanaka   | CS-315    | B     |
| 98988 | Zhang    | BIO-101   | A     |
| 98988 | Shankar  | BIO-101   | A     |
| 98988 | Brandt   | BIO-101   | A     |
| 98988 | Chavez   | BIO-101   | A     |
| 98988 | Peltier  | BIO-101   | A     |
| 98988 | Levy     | BIO-101   | A     |
| 98988 | Williams | BIO-101   | A     |
| 98988 | Sanchez  | BIO-101   | A     |
| 98988 | Snow     | BIO-101   | A     |
| 98988 | Brown    | BIO-101   | A     |
| 98988 | Aoi      | BIO-101   | A     |
| 98988 | Bourikas | BIO-101   | A     |
| 98988 | Tanaka   | BIO-101   | A     |
| 98988 | Zhang    | BIO-301   | NULL  |
| 98988 | Shankar  | BIO-301   | NULL  |
| 98988 | Brandt   | BIO-301   | NULL  |
| 98988 | Chavez   | BIO-301   | NULL  |
| 98988 | Peltier  | BIO-301   | NULL  |
| 98988 | Levy     | BIO-301   | NULL  |
| 98988 | Williams | BIO-301   | NULL  |
| 98988 | Sanchez  | BIO-301   | NULL  |
| 98988 | Snow     | BIO-301   | NULL  |
| 98988 | Brown    | BIO-301   | NULL  |
| 98988 | Aoi      | BIO-301   | NULL  |
| 98988 | Bourikas | BIO-301   | NULL  |
| 98988 | Tanaka   | BIO-301   | NULL  |
+-------+----------+-----------+-------+
286 rows in set (0.06 sec)

mysql> SELECT DISTINCT takes.ID,name,course_id,grade FROM student JOIN takes;
+-------+----------+-----------+-------+
| ID    | name     | course_id | grade |
+-------+----------+-----------+-------+
| 00128 | Zhang    | CS-101    | A     |
| 00128 | Shankar  | CS-101    | A     |
| 00128 | Brandt   | CS-101    | A     |
| 00128 | Chavez   | CS-101    | A     |
| 00128 | Peltier  | CS-101    | A     |
| 00128 | Levy     | CS-101    | A     |
| 00128 | Williams | CS-101    | A     |
| 00128 | Sanchez  | CS-101    | A     |
| 00128 | Snow     | CS-101    | A     |
| 00128 | Brown    | CS-101    | A     |
| 00128 | Aoi      | CS-101    | A     |
| 00128 | Bourikas | CS-101    | A     |
| 00128 | Tanaka   | CS-101    | A     |
| 00128 | Zhang    | CS-347    | A-    |
| 00128 | Shankar  | CS-347    | A-    |
| 00128 | Brandt   | CS-347    | A-    |
| 00128 | Chavez   | CS-347    | A-    |
| 00128 | Peltier  | CS-347    | A-    |
| 00128 | Levy     | CS-347    | A-    |
| 00128 | Williams | CS-347    | A-    |
| 00128 | Sanchez  | CS-347    | A-    |
| 00128 | Snow     | CS-347    | A-    |
| 00128 | Brown    | CS-347    | A-    |
| 00128 | Aoi      | CS-347    | A-    |
| 00128 | Bourikas | CS-347    | A-    |
| 00128 | Tanaka   | CS-347    | A-    |
| 12345 | Zhang    | CS-101    | C     |
| 12345 | Shankar  | CS-101    | C     |
| 12345 | Brandt   | CS-101    | C     |
| 12345 | Chavez   | CS-101    | C     |
| 12345 | Peltier  | CS-101    | C     |
| 12345 | Levy     | CS-101    | C     |
| 12345 | Williams | CS-101    | C     |
| 12345 | Sanchez  | CS-101    | C     |
| 12345 | Snow     | CS-101    | C     |
| 12345 | Brown    | CS-101    | C     |
| 12345 | Aoi      | CS-101    | C     |
| 12345 | Bourikas | CS-101    | C     |
| 12345 | Tanaka   | CS-101    | C     |
| 12345 | Zhang    | CS-190    | A     |
| 12345 | Shankar  | CS-190    | A     |
| 12345 | Brandt   | CS-190    | A     |
| 12345 | Chavez   | CS-190    | A     |
| 12345 | Peltier  | CS-190    | A     |
| 12345 | Levy     | CS-190    | A     |
| 12345 | Williams | CS-190    | A     |
| 12345 | Sanchez  | CS-190    | A     |
| 12345 | Snow     | CS-190    | A     |
| 12345 | Brown    | CS-190    | A     |
| 12345 | Aoi      | CS-190    | A     |
| 12345 | Bourikas | CS-190    | A     |
| 12345 | Tanaka   | CS-190    | A     |
| 12345 | Zhang    | CS-315    | A     |
| 12345 | Shankar  | CS-315    | A     |
| 12345 | Brandt   | CS-315    | A     |
| 12345 | Chavez   | CS-315    | A     |
| 12345 | Peltier  | CS-315    | A     |
| 12345 | Levy     | CS-315    | A     |
| 12345 | Williams | CS-315    | A     |
| 12345 | Sanchez  | CS-315    | A     |
| 12345 | Snow     | CS-315    | A     |
| 12345 | Brown    | CS-315    | A     |
| 12345 | Aoi      | CS-315    | A     |
| 12345 | Bourikas | CS-315    | A     |
| 12345 | Tanaka   | CS-315    | A     |
| 12345 | Zhang    | CS-347    | A     |
| 12345 | Shankar  | CS-347    | A     |
| 12345 | Brandt   | CS-347    | A     |
| 12345 | Chavez   | CS-347    | A     |
| 12345 | Peltier  | CS-347    | A     |
| 12345 | Levy     | CS-347    | A     |
| 12345 | Williams | CS-347    | A     |
| 12345 | Sanchez  | CS-347    | A     |
| 12345 | Snow     | CS-347    | A     |
| 12345 | Brown    | CS-347    | A     |
| 12345 | Aoi      | CS-347    | A     |
| 12345 | Bourikas | CS-347    | A     |
| 12345 | Tanaka   | CS-347    | A     |
| 19991 | Zhang    | HIS-351   | B     |
| 19991 | Shankar  | HIS-351   | B     |
| 19991 | Brandt   | HIS-351   | B     |
| 19991 | Chavez   | HIS-351   | B     |
| 19991 | Peltier  | HIS-351   | B     |
| 19991 | Levy     | HIS-351   | B     |
| 19991 | Williams | HIS-351   | B     |
| 19991 | Sanchez  | HIS-351   | B     |
| 19991 | Snow     | HIS-351   | B     |
| 19991 | Brown    | HIS-351   | B     |
| 19991 | Aoi      | HIS-351   | B     |
| 19991 | Bourikas | HIS-351   | B     |
| 19991 | Tanaka   | HIS-351   | B     |
| 23121 | Zhang    | FIN-201   | C+    |
| 23121 | Shankar  | FIN-201   | C+    |
| 23121 | Brandt   | FIN-201   | C+    |
| 23121 | Chavez   | FIN-201   | C+    |
| 23121 | Peltier  | FIN-201   | C+    |
| 23121 | Levy     | FIN-201   | C+    |
| 23121 | Williams | FIN-201   | C+    |
| 23121 | Sanchez  | FIN-201   | C+    |
| 23121 | Snow     | FIN-201   | C+    |
| 23121 | Brown    | FIN-201   | C+    |
| 23121 | Aoi      | FIN-201   | C+    |
| 23121 | Bourikas | FIN-201   | C+    |
| 23121 | Tanaka   | FIN-201   | C+    |
| 44553 | Zhang    | PHY-101   | B-    |
| 44553 | Shankar  | PHY-101   | B-    |
| 44553 | Brandt   | PHY-101   | B-    |
| 44553 | Chavez   | PHY-101   | B-    |
| 44553 | Peltier  | PHY-101   | B-    |
| 44553 | Levy     | PHY-101   | B-    |
| 44553 | Williams | PHY-101   | B-    |
| 44553 | Sanchez  | PHY-101   | B-    |
| 44553 | Snow     | PHY-101   | B-    |
| 44553 | Brown    | PHY-101   | B-    |
| 44553 | Aoi      | PHY-101   | B-    |
| 44553 | Bourikas | PHY-101   | B-    |
| 44553 | Tanaka   | PHY-101   | B-    |
| 45678 | Zhang    | CS-101    | F     |
| 45678 | Shankar  | CS-101    | F     |
| 45678 | Brandt   | CS-101    | F     |
| 45678 | Chavez   | CS-101    | F     |
| 45678 | Peltier  | CS-101    | F     |
| 45678 | Levy     | CS-101    | F     |
| 45678 | Williams | CS-101    | F     |
| 45678 | Sanchez  | CS-101    | F     |
| 45678 | Snow     | CS-101    | F     |
| 45678 | Brown    | CS-101    | F     |
| 45678 | Aoi      | CS-101    | F     |
| 45678 | Bourikas | CS-101    | F     |
| 45678 | Tanaka   | CS-101    | F     |
| 45678 | Zhang    | CS-101    | B+    |
| 45678 | Shankar  | CS-101    | B+    |
| 45678 | Brandt   | CS-101    | B+    |
| 45678 | Chavez   | CS-101    | B+    |
| 45678 | Peltier  | CS-101    | B+    |
| 45678 | Levy     | CS-101    | B+    |
| 45678 | Williams | CS-101    | B+    |
| 45678 | Sanchez  | CS-101    | B+    |
| 45678 | Snow     | CS-101    | B+    |
| 45678 | Brown    | CS-101    | B+    |
| 45678 | Aoi      | CS-101    | B+    |
| 45678 | Bourikas | CS-101    | B+    |
| 45678 | Tanaka   | CS-101    | B+    |
| 45678 | Zhang    | CS-319    | B     |
| 45678 | Shankar  | CS-319    | B     |
| 45678 | Brandt   | CS-319    | B     |
| 45678 | Chavez   | CS-319    | B     |
| 45678 | Peltier  | CS-319    | B     |
| 45678 | Levy     | CS-319    | B     |
| 45678 | Williams | CS-319    | B     |
| 45678 | Sanchez  | CS-319    | B     |
| 45678 | Snow     | CS-319    | B     |
| 45678 | Brown    | CS-319    | B     |
| 45678 | Aoi      | CS-319    | B     |
| 45678 | Bourikas | CS-319    | B     |
| 45678 | Tanaka   | CS-319    | B     |
| 54321 | Zhang    | CS-101    | A-    |
| 54321 | Shankar  | CS-101    | A-    |
| 54321 | Brandt   | CS-101    | A-    |
| 54321 | Chavez   | CS-101    | A-    |
| 54321 | Peltier  | CS-101    | A-    |
| 54321 | Levy     | CS-101    | A-    |
| 54321 | Williams | CS-101    | A-    |
| 54321 | Sanchez  | CS-101    | A-    |
| 54321 | Snow     | CS-101    | A-    |
| 54321 | Brown    | CS-101    | A-    |
| 54321 | Aoi      | CS-101    | A-    |
| 54321 | Bourikas | CS-101    | A-    |
| 54321 | Tanaka   | CS-101    | A-    |
| 54321 | Zhang    | CS-190    | B+    |
| 54321 | Shankar  | CS-190    | B+    |
| 54321 | Brandt   | CS-190    | B+    |
| 54321 | Chavez   | CS-190    | B+    |
| 54321 | Peltier  | CS-190    | B+    |
| 54321 | Levy     | CS-190    | B+    |
| 54321 | Williams | CS-190    | B+    |
| 54321 | Sanchez  | CS-190    | B+    |
| 54321 | Snow     | CS-190    | B+    |
| 54321 | Brown    | CS-190    | B+    |
| 54321 | Aoi      | CS-190    | B+    |
| 54321 | Bourikas | CS-190    | B+    |
| 54321 | Tanaka   | CS-190    | B+    |
| 55739 | Zhang    | MU-199    | A-    |
| 55739 | Shankar  | MU-199    | A-    |
| 55739 | Brandt   | MU-199    | A-    |
| 55739 | Chavez   | MU-199    | A-    |
| 55739 | Peltier  | MU-199    | A-    |
| 55739 | Levy     | MU-199    | A-    |
| 55739 | Williams | MU-199    | A-    |
| 55739 | Sanchez  | MU-199    | A-    |
| 55739 | Snow     | MU-199    | A-    |
| 55739 | Brown    | MU-199    | A-    |
| 55739 | Aoi      | MU-199    | A-    |
| 55739 | Bourikas | MU-199    | A-    |
| 55739 | Tanaka   | MU-199    | A-    |
| 76543 | Zhang    | CS-101    | A     |
| 76543 | Shankar  | CS-101    | A     |
| 76543 | Brandt   | CS-101    | A     |
| 76543 | Chavez   | CS-101    | A     |
| 76543 | Peltier  | CS-101    | A     |
| 76543 | Levy     | CS-101    | A     |
| 76543 | Williams | CS-101    | A     |
| 76543 | Sanchez  | CS-101    | A     |
| 76543 | Snow     | CS-101    | A     |
| 76543 | Brown    | CS-101    | A     |
| 76543 | Aoi      | CS-101    | A     |
| 76543 | Bourikas | CS-101    | A     |
| 76543 | Tanaka   | CS-101    | A     |
| 76543 | Zhang    | CS-319    | A     |
| 76543 | Shankar  | CS-319    | A     |
| 76543 | Brandt   | CS-319    | A     |
| 76543 | Chavez   | CS-319    | A     |
| 76543 | Peltier  | CS-319    | A     |
| 76543 | Levy     | CS-319    | A     |
| 76543 | Williams | CS-319    | A     |
| 76543 | Sanchez  | CS-319    | A     |
| 76543 | Snow     | CS-319    | A     |
| 76543 | Brown    | CS-319    | A     |
| 76543 | Aoi      | CS-319    | A     |
| 76543 | Bourikas | CS-319    | A     |
| 76543 | Tanaka   | CS-319    | A     |
| 76653 | Zhang    | EE-181    | C     |
| 76653 | Shankar  | EE-181    | C     |
| 76653 | Brandt   | EE-181    | C     |
| 76653 | Chavez   | EE-181    | C     |
| 76653 | Peltier  | EE-181    | C     |
| 76653 | Levy     | EE-181    | C     |
| 76653 | Williams | EE-181    | C     |
| 76653 | Sanchez  | EE-181    | C     |
| 76653 | Snow     | EE-181    | C     |
| 76653 | Brown    | EE-181    | C     |
| 76653 | Aoi      | EE-181    | C     |
| 76653 | Bourikas | EE-181    | C     |
| 76653 | Tanaka   | EE-181    | C     |
| 98765 | Zhang    | CS-101    | C-    |
| 98765 | Shankar  | CS-101    | C-    |
| 98765 | Brandt   | CS-101    | C-    |
| 98765 | Chavez   | CS-101    | C-    |
| 98765 | Peltier  | CS-101    | C-    |
| 98765 | Levy     | CS-101    | C-    |
| 98765 | Williams | CS-101    | C-    |
| 98765 | Sanchez  | CS-101    | C-    |
| 98765 | Snow     | CS-101    | C-    |
| 98765 | Brown    | CS-101    | C-    |
| 98765 | Aoi      | CS-101    | C-    |
| 98765 | Bourikas | CS-101    | C-    |
| 98765 | Tanaka   | CS-101    | C-    |
| 98765 | Zhang    | CS-315    | B     |
| 98765 | Shankar  | CS-315    | B     |
| 98765 | Brandt   | CS-315    | B     |
| 98765 | Chavez   | CS-315    | B     |
| 98765 | Peltier  | CS-315    | B     |
| 98765 | Levy     | CS-315    | B     |
| 98765 | Williams | CS-315    | B     |
| 98765 | Sanchez  | CS-315    | B     |
| 98765 | Snow     | CS-315    | B     |
| 98765 | Brown    | CS-315    | B     |
| 98765 | Aoi      | CS-315    | B     |
| 98765 | Bourikas | CS-315    | B     |
| 98765 | Tanaka   | CS-315    | B     |
| 98988 | Zhang    | BIO-101   | A     |
| 98988 | Shankar  | BIO-101   | A     |
| 98988 | Brandt   | BIO-101   | A     |
| 98988 | Chavez   | BIO-101   | A     |
| 98988 | Peltier  | BIO-101   | A     |
| 98988 | Levy     | BIO-101   | A     |
| 98988 | Williams | BIO-101   | A     |
| 98988 | Sanchez  | BIO-101   | A     |
| 98988 | Snow     | BIO-101   | A     |
| 98988 | Brown    | BIO-101   | A     |
| 98988 | Aoi      | BIO-101   | A     |
| 98988 | Bourikas | BIO-101   | A     |
| 98988 | Tanaka   | BIO-101   | A     |
| 98988 | Zhang    | BIO-301   | NULL  |
| 98988 | Shankar  | BIO-301   | NULL  |
| 98988 | Brandt   | BIO-301   | NULL  |
| 98988 | Chavez   | BIO-301   | NULL  |
| 98988 | Peltier  | BIO-301   | NULL  |
| 98988 | Levy     | BIO-301   | NULL  |
| 98988 | Williams | BIO-301   | NULL  |
| 98988 | Sanchez  | BIO-301   | NULL  |
| 98988 | Snow     | BIO-301   | NULL  |
| 98988 | Brown    | BIO-301   | NULL  |
| 98988 | Aoi      | BIO-301   | NULL  |
| 98988 | Bourikas | BIO-301   | NULL  |
| 98988 | Tanaka   | BIO-301   | NULL  |
+-------+----------+-----------+-------+
286 rows in set (0.04 sec)

mysql> SELECT DISTINCT takes.ID,name,course_id,grade FROM student JOIN takes ON student.ID=takes.ID;
+-------+----------+-----------+-------+
| ID    | name     | course_id | grade |
+-------+----------+-----------+-------+
| 00128 | Zhang    | CS-101    | A     |
| 00128 | Zhang    | CS-347    | A-    |
| 12345 | Shankar  | CS-101    | C     |
| 12345 | Shankar  | CS-190    | A     |
| 12345 | Shankar  | CS-315    | A     |
| 12345 | Shankar  | CS-347    | A     |
| 19991 | Brandt   | HIS-351   | B     |
| 23121 | Chavez   | FIN-201   | C+    |
| 44553 | Peltier  | PHY-101   | B-    |
| 45678 | Levy     | CS-101    | F     |
| 45678 | Levy     | CS-101    | B+    |
| 45678 | Levy     | CS-319    | B     |
| 54321 | Williams | CS-101    | A-    |
| 54321 | Williams | CS-190    | B+    |
| 55739 | Sanchez  | MU-199    | A-    |
| 76543 | Brown    | CS-101    | A     |
| 76543 | Brown    | CS-319    | A     |
| 76653 | Aoi      | EE-181    | C     |
| 98765 | Bourikas | CS-101    | C-    |
| 98765 | Bourikas | CS-315    | B     |
| 98988 | Tanaka   | BIO-101   | A     |
| 98988 | Tanaka   | BIO-301   | NULL  |
+-------+----------+-----------+-------+
22 rows in set (0.04 sec)

mysql> SELECT DISTINCT takes.ID,name,title,grade FROM student JOIN takes ON student.ID=takes.ID JOIN course ON course.course_id=takes.course_id;
+-------+----------+----------------------------+-------+
| ID    | name     | title                      | grade |
+-------+----------+----------------------------+-------+
| 00128 | Zhang    | Intro. to Computer Science | A     |
| 00128 | Zhang    | Database System Concepts   | A-    |
| 12345 | Shankar  | Intro. to Computer Science | C     |
| 12345 | Shankar  | Game Design                | A     |
| 12345 | Shankar  | Robotics                   | A     |
| 12345 | Shankar  | Database System Concepts   | A     |
| 19991 | Brandt   | World History              | B     |
| 23121 | Chavez   | Investment Banking         | C+    |
| 44553 | Peltier  | Physical Principles        | B-    |
| 45678 | Levy     | Intro. to Computer Science | F     |
| 45678 | Levy     | Intro. to Computer Science | B+    |
| 45678 | Levy     | Image Processing           | B     |
| 54321 | Williams | Intro. to Computer Science | A-    |
| 54321 | Williams | Game Design                | B+    |
| 55739 | Sanchez  | Music Video Production     | A-    |
| 76543 | Brown    | Intro. to Computer Science | A     |
| 76543 | Brown    | Image Processing           | A     |
| 76653 | Aoi      | Intro. to Digital Systems  | C     |
| 98765 | Bourikas | Intro. to Computer Science | C-    |
| 98765 | Bourikas | Robotics                   | B     |
| 98988 | Tanaka   | Intro. to Biology          | A     |
| 98988 | Tanaka   | Genetics                   | NULL  |
+-------+----------+----------------------------+-------+
22 rows in set (0.05 sec)

mysql> SELECT DISTINCT takes.ID,name,title,grade FROM student JOIN takes ON student.ID=takes.ID JOIN course ON course.course_id=takes.course_id ORDER BY title,ID;
+-------+----------+----------------------------+-------+
| ID    | name     | title                      | grade |
+-------+----------+----------------------------+-------+
| 00128 | Zhang    | Database System Concepts   | A-    |
| 12345 | Shankar  | Database System Concepts   | A     |
| 12345 | Shankar  | Game Design                | A     |
| 54321 | Williams | Game Design                | B+    |
| 98988 | Tanaka   | Genetics                   | NULL  |
| 45678 | Levy     | Image Processing           | B     |
| 76543 | Brown    | Image Processing           | A     |
| 98988 | Tanaka   | Intro. to Biology          | A     |
| 00128 | Zhang    | Intro. to Computer Science | A     |
| 12345 | Shankar  | Intro. to Computer Science | C     |
| 45678 | Levy     | Intro. to Computer Science | B+    |
| 45678 | Levy     | Intro. to Computer Science | F     |
| 54321 | Williams | Intro. to Computer Science | A-    |
| 76543 | Brown    | Intro. to Computer Science | A     |
| 98765 | Bourikas | Intro. to Computer Science | C-    |
| 76653 | Aoi      | Intro. to Digital Systems  | C     |
| 23121 | Chavez   | Investment Banking         | C+    |
| 55739 | Sanchez  | Music Video Production     | A-    |
| 44553 | Peltier  | Physical Principles        | B-    |
| 12345 | Shankar  | Robotics                   | A     |
| 98765 | Bourikas | Robotics                   | B     |
| 19991 | Brandt   | World History              | B     |
+-------+----------+----------------------------+-------+
22 rows in set (0.04 sec)

mysql> SELECT name,tot_cred FROM student WHERE dept_name='Comp. Sci.' AND tot_cred>50;
+----------+----------+
| name     | tot_cred |
+----------+----------+
| Zhang    |      102 |
| Williams |       54 |
| Brown    |       58 |
+----------+----------+
3 rows in set (0.08 sec)

mysql> SELECT DISTINCT ID FROM (SELECT DISTINCT ID FROM takes WHERE course.id='CS-101') AS a CROSS JOIN (SELECT DISTINCT ID FROM takes WHERE course.id<>'CS-190') AS b ON a.ID=b.ID;
ERROR 1054 (42S22): Unknown column 'course.id' in 'where clause'
mysql> SELECT DISTINCT ID FROM (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') AS a CROSS JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') AS b ON a.ID=b.ID;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT DISTINCT takes.ID FROM (SELECT DISTINCT takes.ID FROM takes WHERE course_id='CS-101') AS a CROSS JOIN (SELECT DISTINCT takes.ID FROM takes WHERE course_id<>'CS-190') AS b ON a.ID=b.ID;
ERROR 1054 (42S22): Unknown column 'takes.ID' in 'field list'
mysql> SELECT DISTINCT ID FROM (
    -> SELECT DISTINCT a.ID FROM takes WHERE course_id='CS-101') AS a CROSS JOIN (
    -> SELECT DISTINCT b.ID FROM takes WHERE course_id<>'CS-190') AS b ON a.ID=b.ID;
ERROR 1054 (42S22): Unknown column 'a.ID' in 'field list'
mysql> SELECT DISTINCT ID FROM (
    ->     -> SELECT DISTINCT a.ID FROM takes WHERE course_id='CS-101') AS a CROSS JOIN (
    -> SELECT DISTINCT b.ID FROM takes WHERE course_id<>'CS-190') AS b ON a.ID=b.ID;   [1]+  Stopped                 mysql -u root -p
charlotte@ubuntu:~$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 5.7.21-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE DBLab;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT DISTINCT takes.ID FROM takes WHERE course_id<>'CS-190' AS a JOIN (SELECT DISTINCT takes.ID FROM takes WHERE course_id='CS-101' AS b) ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a JOIN (SELECT DISTINCT takes.ID FROM takes WHERE course_id='CS-101' AS b) ON' at line 1
mysql>  SELECT DISTINCT takes.ID FROM takes WHERE course_id<>'CS-190' AS a JOIN SELECT DISTINCT takes.ID FROM takes WHERE course_id='CS-101' AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a JOIN SELECT DISTINCT takes.ID FROM takes WHERE course_id='CS-101' AS b ON a' at line 1
mysql> SELECT * FROM (SELECT takes.ID FROM takes WHERE course_id<>'CS-190') AS a CROSS JOIN (SELECT takes.ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+-------+
| ID    | ID    |
+-------+-------+
| 00128 | 00128 |
| 00128 | 00128 |
| 12345 | 12345 |
| 12345 | 12345 |
| 12345 | 12345 |
| 45678 | 45678 |
| 45678 | 45678 |
| 45678 | 45678 |
| 54321 | 54321 |
| 76543 | 76543 |
| 76543 | 76543 |
| 98765 | 98765 |
| 98765 | 98765 |
| 45678 | 45678 |
| 45678 | 45678 |
| 45678 | 45678 |
+-------+-------+
16 rows in set (0.05 sec)

mysql> SELECT * FROM (SELECT takes.ID FROM takes WHERE course_id<>'CS-190') AS a JOIN (SELECT takes.ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+-------+
| ID    | ID    |
+-------+-------+
| 00128 | 00128 |
| 00128 | 00128 |
| 12345 | 12345 |
| 12345 | 12345 |
| 12345 | 12345 |
| 45678 | 45678 |
| 45678 | 45678 |
| 45678 | 45678 |
| 54321 | 54321 |
| 76543 | 76543 |
| 76543 | 76543 |
| 98765 | 98765 |
| 98765 | 98765 |
| 45678 | 45678 |
| 45678 | 45678 |
| 45678 | 45678 |
+-------+-------+
16 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM (SELECT takes.ID FROM takes WHERE course_id<>'CS-190') AS a JOIN (SELECT takes.ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT DISTINCT * FROM (SELECT takes.ID FROM takes WHERE course_id<>'CS-190') AS a JOIN (SELECT takes.ID FROM takes WHERE course_id='CS-101') AS b ON 
+-------+-------+
| ID    | ID    |
+-------+-------+
| 00128 | 00128 |
| 12345 | 12345 |
| 45678 | 45678 |
| 54321 | 54321 |
| 76543 | 76543 |
| 98765 | 98765 |
+-------+-------+
6 rows in set (0.00 sec)

mysql> SELECT ID FROM takes WHERE course_id<>'CS-190' AS a INNER JOIN SELECT ID FROM takes WHERE course_id='CS-101' AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a INNER JOIN SELECT ID FROM takes WHERE course_id='CS-101' AS b ON a.ID=b.ID' at line 1
mysql> SELECT DISTINCT * FROM (SELECT takes.ID FROM takes WHERE course_id<>'CS-190') AS a INNER JOIN (SELECT takes.ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+-------+
| ID    | ID    |
+-------+-------+
| 00128 | 00128 |
| 12345 | 12345 |
| 45678 | 45678 |
| 54321 | 54321 |
| 76543 | 76543 |
| 98765 | 98765 |
+-------+-------+
6 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' AND course_id='CD-101';
Empty set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' AS a JOIN course_id='CD-101' AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a JOIN course_id='CD-101' AS b ON a.ID=b.ID' at line 1
mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' AND course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
+-------+
7 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190';
+-------+
| ID    |
+-------+
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
12 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' UNION ALL SELECT ID FROM takes WHERE course_id='CS-101') a;
+-------+
| ID    |
+-------+
| 98988 |
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
+-------+
27 rows in set (0.04 sec)

mysql> SELECT * FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' UNION ALL SELECT ID FROM takes WHERE course_id='CS-101') a;^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[^C                                            

^C
mysql> SELECT DISTINCT * FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' UNION ALL SELECT ID FROM takes WHERE course_id='CS-101') a;
+-------+
| ID    |
+-------+
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
12 rows in set (0.00 sec)

mysql> SELECT DISTINCT * FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101') AS a JOIN (SELECT ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+-------+
| ID    | ID    |
+-------+-------+
| 00128 | 00128 |
| 12345 | 12345 |
| 45678 | 45678 |
| 76543 | 76543 |
| 98765 | 98765 |
+-------+-------+
5 rows in set (0.00 sec)

mysql> SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101';
+-------+
| ID    |
+-------+
| 98988 |
| 98988 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
13 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101'; 
+-------+
| ID    |
+-------+
| 98988 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
11 rows in set (0.00 sec)

mysql>  SELECT DISTINCT a.* FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101') AS a JOIN (SELECT ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 76543 |
| 98765 |
+-------+
5 rows in set (0.02 sec)

mysql> SELECT ID FROM takes WHERE course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
+-------+
7 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT DISTINCT a.* FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101') AS a JOIN (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 76543 |
| 98765 |
+-------+
5 rows in set (0.01 sec)

mysql> SELECT DISTINCT a.* FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101') AS a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 76543 |
| 98765 |
| 98988 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
11 rows in set (0.04 sec)

mysql> SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101';
+-------+
| ID    |
+-------+
| 98988 |
| 98988 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
13 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE cource_id='CS-101' MINUS SELECT ID FROM takes WHERE cource_id='CS-101' MINUS SELECT ID FROM takes WHERE course_id<>'CS-190';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'MINUS SELECT ID FROM takes WHERE cource_id='CS-101' MINUS SELECT ID FROM takes W' at line 1
mysql> (SELECT * FROM takes) MINUS (SELECT * FROM takes WHERE ID='12345');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'MINUS (SELECT * FROM takes WHERE ID='12345')' at line 1
mysql> SELECT ID FROM takes
    -> MINUS
    -> SELECT ID FROM takes WHERE ID='12345';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT ID FROM takes WHERE ID='12345'' at line 3
mysql> SELECT ID FROM takes
    -> MINUS 
    -> SELECT ID FROM takes WHERE ID=12345;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT ID FROM takes WHERE ID=12345' at line 3
mysql> SELECT ID FROM takes
    -> LEFT JOIN
    -> SELECT ID FROM takes WHERE ID='12345'
    -> ON ^C^C

^C
mysql> SELECT ID FROM takes AS a
    -> LEFT JOIN
    -> SELECT ID FROM takes WHERE ID='12345' AS b
    -> ON a.ID=b.ID
    -> WHERE ID='12345';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS b
ON a.ID=b.ID
WHERE ID='12345'' at line 3
mysql> SELECT ID FROM takes AS a
    -> ^C^C

^C
mysql> SELECT
    -> 
Display all 848 possibilities? (y or n) 
    -> 
    -> ^C

^C
mysql> SELECT
    -> ID
    -> FROM takes
    -> LEFT JOIN 
    -> SELECT ID FROM takes WHERE ID='12345'
    -> USING(ID)
    -> WHERE takes.ID IS NULL;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT ID FROM takes WHERE ID='12345'
USING(ID)
WHERE takes.ID IS NULL' at line 5
mysql> SELECT ID FROM takes AS a LEFT JOIN takes AS b ON a.ID=b.ID;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT * FROM takes AS a LEFT JOIN takes AS b ON a.ID=b.ID;
+-------+-----------+--------+----------+------+-------+-------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade | ID    | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+-------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | 00128 | CS-347    | 1      | Fall     | 2009 | A-    |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    | 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    | 00128 | CS-347    | 1      | Fall     | 2009 | A-    |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | 12345 | CS-190    | 2      | Spring   | 2009 | A     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | 12345 | CS-315    | 1      | Spring   | 2010 | A     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | 12345 | CS-347    | 1      | Fall     | 2009 | A     |
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | 12345 | CS-190    | 2      | Spring   | 2009 | A     |
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | 12345 | CS-315    | 1      | Spring   | 2010 | A     |
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | 12345 | CS-347    | 1      | Fall     | 2009 | A     |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | 12345 | CS-190    | 2      | Spring   | 2009 | A     |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | 12345 | CS-315    | 1      | Spring   | 2010 | A     |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | 12345 | CS-347    | 1      | Fall     | 2009 | A     |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | 12345 | CS-190    | 2      | Spring   | 2009 | A     |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | 12345 | CS-315    | 1      | Spring   | 2010 | A     |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | 12345 | CS-347    | 1      | Fall     | 2009 | A     |
| 19991 | HIS-351   | 1      | Spring   | 2010 | B     | 19991 | HIS-351   | 1      | Spring   | 2010 | B     |
| 23121 | FIN-201   | 1      | Spring   | 2010 | C+    | 23121 | FIN-201   | 1      | Spring   | 2010 | C+    |
| 44553 | PHY-101   | 1      | Fall     | 2009 | B-    | 44553 | PHY-101   | 1      | Fall     | 2009 | B-    |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | 45678 | CS-319    | 1      | Spring   | 2010 | B     |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | 45678 | CS-319    | 1      | Spring   | 2010 | B     |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | 45678 | CS-319    | 1      | Spring   | 2010 | B     |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | 54321 | CS-190    | 2      | Spring   | 2009 | B+    |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | 54321 | CS-190    | 2      | Spring   | 2009 | B+    |
| 55739 | MU-199    | 1      | Spring   | 2010 | A-    | 55739 | MU-199    | 1      | Spring   | 2010 | A-    |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | 76543 | CS-319    | 2      | Spring   | 2010 | A     |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     | 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     | 76543 | CS-319    | 2      | Spring   | 2010 | A     |
| 76653 | EE-181    | 1      | Spring   | 2009 | C     | 76653 | EE-181    | 1      | Spring   | 2009 | C     |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | 98765 | CS-315    | 1      | Spring   | 2010 | B     |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     | 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     | 98765 | CS-315    | 1      | Spring   | 2010 | B     |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     | 98988 | BIO-101   | 1      | Summer   | 2009 | A     |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     | 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  | 98988 | BIO-101   | 1      | Summer   | 2009 | A     |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  | 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  |
+-------+-----------+--------+----------+------+-------+-------+-----------+--------+----------+------+-------+
50 rows in set (0.00 sec)

mysql> SELECT * FROM takes WHERE ID='12345' AS a LEFT JOIN takes AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a LEFT JOIN takes AS b ON a.ID=b.ID' at line 1
mysql> (SELECT * FROM takes WHERE ID='12345') AS a LEFT JOIN takes AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS a LEFT JOIN takes AS b ON a.ID=b.ID' at line 1
mysql> SELECT * FROM takes AS a LEFT JOIN SELECT * FROM takes WHERE ID='12345' AS b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'AS b ON a.ID=b.ID' at line 1
mysql> SELECT * FROM takes a LEFT JOIN SELECT * FROM takes WHERE ID='12345' b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'b ON a.ID=b.ID' at line 1
mysql> SELECT *
    -> FROM
    -> SELECT * FROM takes a LEFT JOIN SELECT * FROM takes WHERE ID='12345' b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'b ON a.ID=b.ID' at line 3
mysql> SELECT * FROM
    -> student LEFT JOIN takes ON student.ID=takes.ID
    -> WHERE takes.ID IS NULL;
+-------+------+-----------+----------+------+-----------+--------+----------+------+-------+
| ID    | name | dept_name | tot_cred | ID   | course_id | sec_id | semester | year | grade |
+-------+------+-----------+----------+------+-----------+--------+----------+------+-------+
| 70557 | Snow | Physics   |        0 | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
+-------+------+-----------+----------+------+-----------+--------+----------+------+-------+
1 row in set (0.05 sec)

mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT * FROM takes WHERE ID='12345') b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
+-------+-----------+--------+----------+------+-------+------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade | ID   | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 19991 | HIS-351   | 1      | Spring   | 2010 | B     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 23121 | FIN-201   | 1      | Spring   | 2010 | C+    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 44553 | PHY-101   | 1      | Fall     | 2009 | B-    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 55739 | MU-199    | 1      | Spring   | 2010 | A-    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 76653 | EE-181    | 1      | Spring   | 2009 | C     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  | NULL | NULL      | NULL   | NULL     | NULL | NULL  |
+-------+-----------+--------+----------+------+-------+------+-----------+--------+----------+------+-------+
18 rows in set (0.00 sec)

mysql> SELECT ID FROM takes WHERE course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
+-------+
7 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT DISINTCT ID FROM takes WHERE course_id<>'CS-190';
ERROR 1054 (42S22): Unknown column 'DISINTCT' in 'field list'
mysql> SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190';
+-------+
| ID    |
+-------+
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
12 rows in set (0.00 sec)

mysql> SELECT ID FROM
    -> SELECT DISTINCT ID FROM takes WHERE course_id='CS-101' a LEFT JOIN SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190' ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT DISTINCT ID FROM takes WHERE course_id='CS-101' a LEFT JOIN SELECT DISTIN' at line 2
mysql> SELECT DISTINCT ID FROM
    -> (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT * FROM
    -> (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
Empty set (0.08 sec)

mysql> SELECT ID FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1052 (23000): Column 'ID' in field list is ambiguous
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.ID=b.I
    -> D
    -> WHERE b.ID IS NULL;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'D
WHERE b.ID IS NULL' at line 3
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
Empty set (0.00 sec)

mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.courseID
    -> ^C  

^C
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.course.id
    -> WHERE b.course_id IS NULL;
ERROR 1054 (42S22): Unknown column 'b.course_id' in 'where clause'
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.course_id
    -> WHERE b.course_id IS NULL;
ERROR 1054 (42S22): Unknown column 'b.course_id' in 'where clause'
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT ID FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.course_id
    -> WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'b.course_id' in 'on clause'
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT course_id FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.course_id
^C
mysql> SELECT * FROM
    -> takes a LEFT JOIN (SELECT DISTINCT course_id FROM takes WHERE course_id<>'CS-190') b ON a.course_id=b.course_id
    -> WHERE b.course_id IS NULL;
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | NULL      |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
2 rows in set (0.07 sec)

mysql> SELECT DISTINCT ID FROM
    -> (SELECT * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT course_id FROM takes WHERE course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT DISTINCT ID FROM
    -> (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT course_id FROM takes WHERE course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT DISTINCT ID FROM
    -> (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT * FROM takse WHERE course_id='CS-101';
ERROR 1146 (42S02): Table 'DBLab.takse' doesn't exist
mysql> SELECt * FROM takes WHERE course_id='CS-101';
* FROM takes WHERE course_id='CS-101';
^C
mysql> SELECt * FROM takes WHERE course_id='CS-101';
+-------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
+-------+-----------+--------+----------+------+-------+
7 rows in set (0.04 sec)

mysql> SELECt DISTINCT * FROM takes WHERE course_id='CS-101';
+-------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
+-------+-----------+--------+----------+------+-------+
7 rows in set (0.01 sec)

mysql> SELECT DISTINCT ID FROM
    -> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT b1.course_id FROM takes WHERE b1.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'b1.course_id' in 'field list'
mysql> SELECT DISTINCT ID FROM
    -> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT DISTINCT ID FROM (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT a1.course_id FROM takes WHERE a1.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'a1.course_id' in 'field list'
mysql> SELECT DISTINCT ID FROM (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT course_id FROM takes WHERE course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT DISTINCT ID FROM (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT course_id R FROM takes WHERE R<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'R' in 'where clause'
mysql> SELECT DISTINCT ID FROM (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID;
(SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID;
^C
mysql> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id F' at line 1
mysql> SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL;
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | NULL      |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
2 rows in set (0.00 sec)

mysql> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id F' at line 1
mysql> SELECt * FROM takes WHERE course_id='CS-101';
+-------+-----------+--------+----------+------+-------+
| ID    | course_id | sec_id | semester | year | grade |
+-------+-----------+--------+----------+------+-------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    |
+-------+-----------+--------+----------+------+-------+
7 rows in set (0.00 sec)

mysql> (SELECt * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id F' at line 1
mysql> SELECT takes.ID FROM (SELECT * FROM takes WHERE course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (SELECT * FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL) b ON a.ID=b.ID WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE a.course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE b1.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'a.course_id' in 'where clause'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE b1.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1054 (42S22): Unknown column 'b1.course_id' in 'where clause'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT takes.ID FROM 
    -> (SELECT * FROM takes WHERE takes.course_id='CS-101') a LEFT JOIN (
    -> SELECT * FROM 
    -> takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE course_id<>'CS-190') b1 ON a1.course_id=b1.course_id 
    -> WHERE b1.course_id IS NULL) b ON a.ID=b.ID 
    -> WHERE b.ID IS NULL;
ERROR 1060 (42S21): Duplicate column name 'course_id'
mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL;
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | NULL      |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
2 rows in set (0.01 sec)

mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL;
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    | NULL      |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | NULL      |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | NULL      |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | NULL      |
| 19991 | HIS-351   | 1      | Spring   | 2010 | B     | NULL      |
| 23121 | FIN-201   | 1      | Spring   | 2010 | C+    | NULL      |
| 44553 | PHY-101   | 1      | Fall     | 2009 | B-    | NULL      |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | NULL      |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | NULL      |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | NULL      |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | NULL      |
| 55739 | MU-199    | 1      | Spring   | 2010 | A-    | NULL      |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     | NULL      |
| 76653 | EE-181    | 1      | Spring   | 2009 | C     | NULL      |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | NULL      |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     | NULL      |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     | NULL      |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
20 rows in set (0.00 sec)

mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL AND takes.course_id='CS-101';
ERROR 1054 (42S22): Unknown column 'takes.course_id' in 'where clause'
mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL AND b.course_id='CS-101';
Empty set (0.00 sec)

mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id;
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 12345 | CS-190    | 2      | Spring   | 2009 | A     | CS-190    |
| 54321 | CS-190    | 2      | Spring   | 2009 | B+    | CS-190    |
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 00128 | CS-347    | 1      | Fall     | 2009 | A-    | NULL      |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | NULL      |
| 12345 | CS-315    | 1      | Spring   | 2010 | A     | NULL      |
| 12345 | CS-347    | 1      | Fall     | 2009 | A     | NULL      |
| 19991 | HIS-351   | 1      | Spring   | 2010 | B     | NULL      |
| 23121 | FIN-201   | 1      | Spring   | 2010 | C+    | NULL      |
| 44553 | PHY-101   | 1      | Fall     | 2009 | B-    | NULL      |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | NULL      |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | NULL      |
| 45678 | CS-319    | 1      | Spring   | 2010 | B     | NULL      |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | NULL      |
| 55739 | MU-199    | 1      | Spring   | 2010 | A-    | NULL      |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 76543 | CS-319    | 2      | Spring   | 2010 | A     | NULL      |
| 76653 | EE-181    | 1      | Spring   | 2009 | C     | NULL      |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | NULL      |
| 98765 | CS-315    | 1      | Spring   | 2010 | B     | NULL      |
| 98988 | BIO-101   | 1      | Summer   | 2009 | A     | NULL      |
| 98988 | BIO-301   | 1      | Summer   | 2010 | NULL  | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
22 rows in set (0.00 sec)

mysql> SELECT * FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL AND a.course_id='CS-101';
+-------+-----------+--------+----------+------+-------+-----------+
| ID    | course_id | sec_id | semester | year | grade | course_id |
+-------+-----------+--------+----------+------+-------+-----------+
| 00128 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 12345 | CS-101    | 1      | Fall     | 2009 | C     | NULL      |
| 45678 | CS-101    | 1      | Fall     | 2009 | F     | NULL      |
| 54321 | CS-101    | 1      | Fall     | 2009 | A-    | NULL      |
| 76543 | CS-101    | 1      | Fall     | 2009 | A     | NULL      |
| 98765 | CS-101    | 1      | Fall     | 2009 | C-    | NULL      |
| 45678 | CS-101    | 1      | Spring   | 2010 | B+    | NULL      |
+-------+-----------+--------+----------+------+-------+-----------+
7 rows in set (0.00 sec)

mysql> SELECT DISTINCT ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL AND a.course_id='CS-101';
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id;;
+-------+
| ID    |
+-------+
| 12345 |
| 54321 |
| 98988 |
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
22 rows in set (0.00 sec)

ERROR: 
No query specified

mysql> SELECT ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id;
+-------+
| ID    |
+-------+
| 12345 |
| 54321 |
| 98988 |
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
22 rows in set (0.00 sec)

mysql> SELECT ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id='CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL;
+-------+
| ID    |
+-------+
| 98988 |
| 98988 |
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
| 45678 |
| 12345 |
| 98765 |
| 45678 |
| 76543 |
| 00128 |
| 12345 |
| 76653 |
| 23121 |
| 19991 |
| 55739 |
| 44553 |
+-------+
20 rows in set (0.00 sec)

mysql> SELECT ID FROM takes a LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b ON a.course_id=b.course_id WHERE b.course_id IS NULL;
+-------+
| ID    |
+-------+
| 12345 |
| 54321 |
+-------+
2 rows in set (0.00 sec)

mysql> SELECT DISTINCT a.* FROM (SELECT ID FROM takes WHERE course_id<>'CS-190' AND course_id<>'CS-101') AS a JOIN (SELECT ID FROM takes WHERE course_id='CS-101') AS b ON a.ID=b.ID;
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 76543 |
| 98765 |
+-------+
5 rows in set (0.01 sec)

mysql> SELECT DISTINCT ID FROM takes WHERE couse_id='CS-101';
ERROR 1054 (42S22): Unknown column 'couse_id' in 'where clause'
mysql> SELECT DISTINCT ID FROM takes WHERE course_id='CS-101'
    -> ;
+-------+
| ID    |
+-------+
| 00128 |
| 12345 |
| 45678 |
| 54321 |
| 76543 |
| 98765 |
+-------+
6 rows in set (0.00 sec)

mysql> SELECT a.* FROM
    -> (SELECT DISTINCT ID FROM takes WHERE course_id='CS-101') a LEFT JOIN
    -> (SELECT ID FROM takes a1 LEFT JOIN (SELECT DISTINCT takes.course_id FROM takes WHERE takes.course_id<>'CS-190') b1 ON a1.course_id=b1.course_id WHERE b1.course_id IS NULL;) b ON a.ID=b.ID
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 3
    -> WHERE b.ID IS NULL;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') b ON a.ID=b.ID
WHERE b.ID IS NULL' at line 1
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
