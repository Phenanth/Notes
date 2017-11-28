# Mac下配置mongodb

参考贴地址：
> https://segmentfault.com/a/1190000002547229

## 官网下载

> https://www.mongodb.com/download-center?jmp=nav#community

下载完成后进行解压，并把文件夹放到Applications文件夹里。

## 操作

1. 配置操作
进入`Applications/mongodb/bin`，在根目录/下创建 data/db 目录，用于放置mongodb数据，并且给该目录设置权限
`-H`是用户非主管理员时使用，可去除

```
sudo -H mkdir -p /data/db
sudo -H chown -R  (username) /data
```
2. 运行mongod服务（接口监听）
打开终端，输入`cd Applications/mongodb/bin`，回车后，再输入`./mongod`

3. 运行mongo服务（对数据管理）
打开另外一个终端，输入`Applications/mongodb/bin`，回车，输入 `./mongo`
