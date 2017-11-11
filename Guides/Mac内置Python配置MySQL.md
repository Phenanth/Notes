c版内置Python配置MySQL

## 下载Mac版本MySQL与Python-MySQLdb

MySQL社区版本安装：
> https://dev.mysql.com/downloads/mysql/

MySQLdb-python的Github源码下载:
> https://github.com/farcepest/MySQLdb1

## 修改site.cfg文件

下载Github源码后解压文件夹获得源码安装文件夹。
直接进行安装将引发报错，需要对源码文件夹内文件`site.cfg`进行如下修改：

> 将代码段
> ```
> # The path to mysql_config.
>  # Only use this if mysql_config is not on yourPATH, or you have some weird
>  # setup that requires it.
>  # mysql_config = /usr/local/bin/mysql_config
> ```
> 改为：
> ```
> # The path to mysql_config.
> # Only use this if mysql_config is not on your PATH, or you have some weird
> # setup that requires it.
> mysql_config = /usr/local/mysql/bin/mysql_config
> ```

## 安装Python-MySQLdb

在终端命令行（terminal）内进入源码存放地址，输入`python setup.py install`

## 检验安装成功

```
> python
>>> import MySQLdb
>>> mysql.VERSION

```

显示版本后则安装成功

## 附录

安装MySQL后需要对mac进行环境变量的配置以方便以后终端中对MySQL的使用。

在安装MySQL后系统将提示暂时root密码记录如下：
> temporary password for root@localhost: t;+?Lnua2!pk

**注意**：如果没有及时记录暂时密码，可以查看Mac的通知栏，多半会有来自安装器的提醒，里面会提及暂时密码。

直接在终端中使用mysql命令将提示没有此命令，对此进行如下操作：

> 在终端中输入以下一系列命令：
```
~(enter)
touch .bash_profile(enter)
open -e .bash_profile
```
然后就会在文本编辑器中打开管理环境变量的文件，输入`export PATH=${PATH}:/usr/local/mysql/bin`后保存并退出（左上角）文本编辑器，退出并重启终端

对Mysql的初次登陆使用`mysql -u root -p`命令操作即可，密码输入方才保存的暂时性密码，并对密码进行更改即可。

完整操作（在终端中）：
```
mac: user$ mysql -u root -p (temporary password)
mysql> SET PASSWORD = PASSWORD('your new password');
mysql> flush privileges;
```
完成后control+D退出mysql再用新密码登陆即可。（此时暂时密码已经失效）
