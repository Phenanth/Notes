# SQL语言

参考网站：

[W3SCHOOL-SQL教程](http://www.w3school.com.cn/sql/index.asp)

## 基础

### RDBMS

RDBMS 指的是关系型数据库管理系统。RDBMS 中的数据存储在被称为表（`tables`）的数据库对象中，是相关数据项的集合，它是由行和列组成的。

> SQL语句对大小写不敏感，且不同的RDBMS数据库程序对SQL命令的格式要求有少许差异。

### 语法

主要由DML语句和DDL语句构成。

#### DML语句

属于SQL的一部分，主要内容是数据操作指令（语言），由查询和更新组成。

DML语句：
- SELECT 从数据库表中获取数据
- UPDATE 更新数据库表中的数据
- DELETE 从数据库表中删除数据
- INSERT INTO 向数据库表中插入数据

##### SELECT

用于在表中查询数据，结果被存在一个结果表中。

语法：

`SELECT (column name1),(column name2),... FROM (table name)`

或：

`SELECT * FROM (table name)`

> select 等同于 SELECT

这里不涉及在`result-set`中导航的内容。

##### SELECT DISTINCT

用于返回唯一不同的值，相当于将返回结果去重。

语法：

`SELECT DISTINCT (column name) FROM (table name)`

##### WHERE 子句

有条件地从表中选取数据。

语法：

`SELECT (column name) FROM (table name) WHERE (colunm name) (operands) (value)`

可使用的操作符有：`=`、`<>`（不等于，某些版本SQL中也可写成`!=`）、`>`、`<`、`>=`、`<=`、`BETWEEN`（在某个范围内）、`LIKE`（搜索某种模式）。

搜索条件是文本需要用单引号环绕，而数值则不需要。

`SELECT * FROM Persons WHERE Firstname='Bush'`

`SELECT * FROM Persons WHERE Year>1965`

##### AND & OR

将多个WHERE子句条件结合起来。

语法：

`SELECT * FROM Persons WHERE FirstName='Thomas' AND LastName='Carter'`

`SELECT * FROM Persons WHERE FirstName='Thomas' OR LastNmae='Carter'`

也可结合AND与OR运算符：

`SELECT * FROM Persons WHERE (FirstName='Thomas' OR FirstName='William') AND LastName='Carter'`

##### ORDER BY 子句

用于根据指定的列对结果集默认按照升序进行排序（降序需使用DESC关键字）。

语法：

以字母顺序显示Company:

`SELECT Company, OrderNumber FROM Orders ORDER BY Company (DESC)`

与此同时，以数字顺序显示OrderNumber:

`SELECT Company, OrderNumber FROM Orders ORDER BY Company (DESC), OrderNumber (ASC)`

> 在以上的结果中有两个相等的公司名称时，只有这一次，在第一列中有相同的值时，第二列是以升序排列的。如果第一列中有些值为 nulls 时，情况也是这样的。

##### INSERT INTO

向表格中插入新的行

语法：

插入一行：

`INSERT INTO (table name) VALUES (value1, value2, ...)`

指定要插入数据的列：

`INSERT INTO (table name) (colunm1, colunm2, ...) VALUES (value1, value2, ...)`

*示例*

插入一行：

`INSERT INTO Persons VALUES ('Gates', 'Bill', 'Xuanwumen 10', 'Beijing')`

插入指定列：

`INSERT INTO Persons (LastName, Address) VALUES ('Willson', 'Champs-Elysees')`

##### UPDATE

用于修改表中数据。

语法：

`UPDATE (table name) SET (column) = (value1) WHERE (column) = (value2)`

示例：

更新某一行中的一列：

`UPDATE Person SET FirstName = 'Fred' WHERE LastName = 'Willson'`

更新某一行中的若干列：

`UPDATE Person SET Address = 'zhongshan 23', City = 'Nanjing' Where LastName = 'Willson'`

##### DELETE

语法：

`DELETE FROM (table name) WHERE (column name) = value`

示例：

删除某行：

`DELETE FROM Person WHERE LastName='willson'`

删除所有行：

`DELETE FROM (table name)` 或 `DELTE * FROM (table name)`

#### DDL语句

属于SQL的另一部分，主要内容是数据定义指令（语言），由创建与删除表格，定义索引（键），表间链接情况，施加表间约束组成。

DDL语句：
- CREATE DATABASE 创建新数据库
- ALTER DATABASE 修改数据库
- CREATE TABLE 创建新表
- ALTER TABLE 修改数据库表
- DROP TABLE  删除数据库表
- CREATE INDEX 创建索引（搜索用键）
- DROP INDEX 删除索引（搜索用键）

### 高级

#### TOP子句

