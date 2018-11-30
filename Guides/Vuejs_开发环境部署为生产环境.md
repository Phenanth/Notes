# Vuejs开发环境部署为生产环境

已部署好的生产环境：[管理系统的生产环境](http://phenanthrene.top)

**假设已经有一个配置好nginx的服务器了，没有的话，学生推荐阿里云。**

运行生产环境前，需要做如下准备。

## 配置nginx

安装好`nginx`，然后配置`nginx.conf`，在该部分做以下修改：

```
...
    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

		# 这里是网站根目录
        location / {
            root   html;
            index  index.html index.htm;
        }

		# 添加以下内容
        location /api { 
            proxy_pass http://localhost:3000;
        }
        # 添加以上内容

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

...
```

## 修改MySQL数据表

导入提供的`departmentinfo.sql`文件，对数据内容进行修改。与此同时，执行SQL语句`GRANT SELECT,UPDATE ON * TO departmentinfo@localhost IDENTIFIED BY '000000';`对连接数据库的用户进行授权。

## 部署网站

将生产环境的`index.html`与static文件夹移入`nginx.conf`中指定的根目录，启动`nginx`，在浏览器中访问`http://localhost`即可。（需检查该端口是否被占用）
