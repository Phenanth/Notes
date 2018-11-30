# Install MySQL on Manjaro Linux

## Failure in installation

```
sudo pacman -S mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```
If it reports failure:
```
systemctl stop mariadb
rm -R /var/lib/mysql/*
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mariadb
```
may help.

then:
```
sudo systemctl enable mysqld
sudo systemctl start mysqld
sudo systemctl status mysqld
```

> You can also use `ps -A | grep mysql` to check if the mysql.server is running.

And set the password for root.
```
sudo mysql_secure_installation
```

Finally solved, gonna cry for it.

## Another unsolved issue:

`Got error 64 'Temp file write failure' from InnoDB`

```
create table positions_comp like positions;
alter table positions_comp KEY_BLOCK_SIZE=8;
insert into positions_comp select * from positions;
alter table positions rename positions_old;
alter table positions_comp rename positions;
```
