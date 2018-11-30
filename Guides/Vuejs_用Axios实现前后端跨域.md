# 【Vue.js】用Axios实现前后端跨域

**跨域原理**

`Axios`实例将前端申请发到`./config/index.js`中指定的`proxyTable`地址下的子地址。

这类地址是后台`nodejs`的`Router`实例暴露出的模块接口，调用这些接口来使用后台服务。

## 依赖项安装

使用`npm`安装`Axios`
```
npm install --save axios
npm install --save vue-axios
```

## Vuejs框架配置

./config/index.js:
```
proxyTable: {
        '/api': {
            target: 'http://127.0.0.1:3000/',
            changeOrigin: true,
            pathRewrite: {
                '^/api': '/'
            }
        }
    },
```

## Axios实例创建

`api.js`示例:
```
import Vue from 'vue'
import axios from 'axios'
import VueAxios from 'vue-axios'

axios.default.timeout = 5000
axios.defaults.headers.post['Content-Type'] = 'application/json'

const instance = axios.create()
instance.defaults.headers.post['Content-Type'] = 'application/json'

axios.interceptors.request.use = instance.interceptors.request.use
instance.interceptors.request.use(config => {
	if (localStorage.getItem('token')) {
		config.headers.Authorization = `token ${localStorage.getItem('token')}`
			.replace(/(^\")|(\"$)/g, '')
	}
	return config
}, err => {
	return Promise.reject(err)
})

instance.interceptors.response.use(response => {
	return response
}, err => {
	return Promise.reject(err)
})

export default {
	
	doLogin ( data ) {
		return instance.post('/api/login', data)
	}

}

```

## 服务器配置

### 服务器入口

`server.js`部分:
```
app.use('/', routes);
app.use('/api', routes);

```

### 服务器路由

`routes.js`:
```
'use strict'

const Express = require('express');
const router = Express.Router();
const dbHelper = require('./db/dbHelper.js');

dbHelper(router);

module.exports = router;

```

### 后台路由模块接口写法

`dbHelper.js`部分:
```
module.exports = (router) => {

	router.post('/login', Login);

}

```
