# MySQL Basics

## Settings
*Not finished yet.*

## Using sql files
1. Writing sql commands in a .sql file.
2. `mysql -D (database) -u (user) -p < (file).sql`

**Caution**:
- Enter the full path of the sql file if it's not at the same path like that.
- Add '-h' if it's a distant host.

## Basic sql commands

**Caution**: Don't forget the ';' at the end of every commmand.

### Login in

Enter:`mysql -h localhost -u root -p` in the cmd, after seeing "Enter password" you can input the password.
*(Don't need to input anything the first time)*.

### Database commands

>  **Selectable prms:**
**=, >, <, >=, <=, !=, 'is [not] null', 'in', 'like'**

#### Show details

To show all the databases:
`show databases;`

To show all the tables:
`show tables;`

To find out the details of a table:
`describe (table);`

#### Create databases
`create database (database) [other options];`


> Setting the charset as 'gbk' for Chinese characters.

#### Choose database

`use (database);`

#### Create tables

`create table (table);`

Example:
```
create table students（
	id int unsigned not null auto_increment primary key,
	name char(8) not null,
	sex char(4) not null,
	age tinyint unsigned not null,
	tel char(13) null default "-"
);
```
or:

```
CREATE TABLE `zhibo` (
  `jlink` varchar(100) NOT NULL,
  `jtitle` varchar(50) NOT NULL,
  `jcomna` varchar(30) NOT NULL,
  `jsalary` varchar(16) NOT NULL,
  `jworkp` varchar(10) NOT NULL,
  `jpubtime` varchar(10) NOT NULL,
  `jexp` varchar(10) NOT NULL,
  `jparty` varchar(20) NOT NULL,
  `jnumber` varchar(5) NOT NULL,
  `jlevel` varchar(8) NOT NULL,
  PRIMARY KEY (`jlink`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
```

#### Insert data

`insert into (table) [(col1, col2, col3,...)] values (key1, key2, key3,...);`

or

`insert into (table) values (key1, key2, key3,...);`

If you see "Query Ok, 1 row affected(0.05 sec)", process succeed.

#### Query data

`select (col), (col2) from (table) [qry prms];`

or

`select * from (table);`

PRMs:

`select (col) from (table) where (prms);`
>  **Selectable prms:**
**=, >, <, >=, <=, !=, 'is [not] null', 'in', 'like'**

#### Update data

`update (table) set (col1)=(new value1), (col2)=(new value2), ... where (prms);`

Updating a value to default value: `update (table) set (col) = default where (prms);`

#### Delete data

`delete from (table) where (prms);`

Delete all data in the table:

`delete from (table);`

#### Alter table form

Add columns:

`alter table (table) add (col) (data type) [after (position)];`

> Add command default position is the end of the table.

Change columns:

`alter table (table) change (col) (new col) (new data type);`

While changing a col, you can set the default value/is or not null like this:
`alter table (table) add (col) (data type) default (a data that has the same data type);`

Delete columns:

`alter table (table) drop (col);`

Rename columns:

`alter table (table) rename (new name);`

#### Other dabatase opts

Delete a table:

After `use (table);`,`drop table (table);`

Delete a database:

`drop database (database);`

### Other commands:

#### Change root password:

`mysqladmin -u root -p password (new password);`

UPDATE类更新指令也可用于root密码的更改，具体操作可查询网站。

*If it's the first time, press enter key, you need to input the old root password if it already has a password before the change.*

### MySQL Workbench

Official site:`http://www.mysql.com/products/workbench/`
