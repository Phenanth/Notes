*个人在爬虫途中遇到的错误* 和 *解决方法的简单列举*

# 编译报错

## TypeError

- **module object is not callable** 
  解决：
```
from (module) import (module)
```



## ValueError


## NameError

- name 'jtitle' is not defined
  解决：（*见下方lxml问题，数据初始化问题*）
```
pass
```

## IndexError
- List index out of range
  解决：（*lxml的问题（见下），初始化后可使用list[0]访问*）
```
pass
```

## AttributeError

- ‘lxml.etree._Element’ object has no attribute ‘Xpath’
  解决：（*这个解决非常蠢。是xpath而不是Xpath*）
```
content = dom.xpath('')
```


## IOError

- file not open for writing
  解决：（*r改为r+*）
```
with open(file, 'r+') as fd:
```

## UnicodeEncodeError
遇到gbk编码无法编码字符都可以使用
```
gbkTypeStr = unicodeTypeStr.encode(“GBK“, ‘ignore’);
```
- ‘gbk’ codec can’t encode character u’\xa0’ in position 12: illegal multibyte sequenoce
  解决：（*原因是浏览器加了gbk无法解释的一个空格字符，替换就好*）
```
string.replace(u'\xa0', u' ')
```
  类似的其他浏览器自加字符(*去掉空格*)：
>& nbsp;  空格
& amp;   &
& lt;       <
& gt;      >
& quot;   "
& qpos;   '

- ‘gbk’ codec can’t encode character u’\u200b’ in position 29: illegal multibyte sequenoce
  解决：（*对有问题的jtitle再次替换*）
```
string.replace(u'\u200b',u'')
```


## MySQLError

- Can’t initialize character set utf-8
  解决：（*utf-8到utf8*）
```
conn = MySQLdb.connect(host='localhost', user='root', passwd='', port=3306, charset='utf8')
```


# 逻辑错误

# MySQL

- 控制台显示无误，MySQL数据库表中无数据
  解决：（*每次插入数据结束后对表对象进行commit和close*）
```
conn.commit()
conn.close()
cur.close()
```
- 创建表失败
  解决：（*windows server 2012 R2下 MySQL表格创建正确格式参考*）
```
CREATE TABLE zhibo (
  jlink varchar(100) NOT NULL PRIMARY KEY,
  jtitle varchar(50) NOT NULL, 
  jcomna varchar(30) NOT NULL,
  jsalary varchar(16) NOT NULL,
  jworkp varchar(10) NOT NULL,
  jpubtime varchar(10) NOT NULL,
  jexp varchar(10) NOT NULL,
  jparty varchar(20) NOT NULL,
  jnumber varchar(5) NOT NULL,
  jlevel varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

## lxml
- <Element html at...>
  详细：dom = etree.HTML(html) 后，返回dom为这样的一个回复
  解决：（*实际不影响xpath使用，初始化了推入数据库的数据为’test*）
```
jtitle = 'test' 
jcomna = 'test'
jsalary = 'test'
jworkp = 'test'
jpubtime = 'test'
jexp = 'test'
jparty = 'test'
jnumber = 'test' 
jlevel = 'test'
```
  备注：*这个玩意花了我接近两个小时去排查，一定不能忘记初始化数据*
