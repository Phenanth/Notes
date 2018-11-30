新建一个用户abc，并授权他查询student表，密码可任意设置

GRANT SELECT ON student TO abc@localhost IDENTIFIED BY '000000';

mysql> grant select on student to abc@localhost identified by '000000';
Query OK, 0 rows affected, 1 warning (0.11 sec)

-------------------------------------------------------

使用用户abc登录mysql

mysql -u abc -p

charlotte@ubuntu:~/Documents/project/algo_des/proj8$ mysql -u abc -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 5.7.21-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 

-------------------------------------------------------

查看表student的内容

SELECT * FROM student;

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

-------------------------------------------------------

查看表takes的内容

SELECT * FROM takes;

mysql> select * from takes;
ERROR 1142 (42000): SELECT command denied to user 'abc'@'localhost' for table 'takes'

-------------------------------------------------------

删除表student里的一条记录

DELETE FROM student WHERE ID='00128';

mysql> delete from student where ID='00128';
ERROR 1142 (42000): DELETE command denied to user 'abc'@'localhost' for table 'student'

-------------------------------------------------------

使用root登录mysql并授权abc查询takes表
GRANT SELECT ON takes TO abc@localhost;

-------------------------------------------------------

重复实验
结果：可以查询两表 不可删除

-------------------------------------------------------

使用root登录mysql并取消abc查询student表的权限

REVOKE SELECT ON student FROM abc@localhost;

mysql> revoke select on student from abc@localhost;
Query OK, 0 rows affected (0.03 sec)

-------------------------------------------------------

重复实验
结果：不能查询student，可以查询takes，不能删除
