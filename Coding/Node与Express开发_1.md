s与Node框架学习笔记 - 1


## 前三章总结

本书的前三章主要讲述了利用Express框架搭建网站的最简单步骤。

以下是接口`web.js`的源代码：
```
var express = require('express');
var app = express();

// handlebars视图引擎
var handlebars = require('express3-handlebars')
	.create({ defaultLayout: 'main'});
app.engine( 'handlebars', handlebars.engine);
app.set('view engine', 'handlebars');


//幸运语录数组
var fortunes = [
	"Conquer your fears or they will conquer you.",
	"Rivers need springs.",
	"Do not fear what you don't know.",
	"You will have a pleasant surprise.",
	"Whenever possible, keep it simple.",
];

//端口处理
app.set('port', process.env.PORT || 3000);

//设置static中间件路径
app.use(express.static(__dirname + '/public'));


//设置网站路由
app.get('/', function(req, res){
// 这里express自带的get省去了简化url的步骤	var path = req.url.replace(/\/?(?:\?.*)?$/, '').toLowerCase(); 的过程
	res.render('home');
})



app.get('/about', function(req, res){
    // 动态生成每日语录
	var randomFortune = 
		fortunes[Math.floor(Math.random() * fortunes.length)];
	res.render('about', { fortune: randomFortune });
})

//定制404界面-处理器
app.use(function(req, res, next){
	res.status(404);
	res.render('404');
});

//定制500界面-处理器
app.use(function(req, res){
	console.error(err.stack);
	res.status(500);
	res.render('500');
});


app.listen(app.get('port'), function(){
	console.log('Express started on http://localhost:' + app.get('port') + ' ; press Ctrl-C to terminate.');
});
```

###  路由及static中间件
使用`app.get`进行网页渲染

使用`app.use`进行404、500界面的处理及static（静态文件）中间件路径的设置

关于static中间件设置：`app.use(express.static(__dirname + '/public'));`

### 视图中动态内容

见`web.js`中的about路由部分，动态生成每日语录并在渲染时添加进视图形成简易的动态效果。

### 小细节

> 注意：
如果静态文件或者路由关系之类在保存后没有及时更新，重启服务器即可。

## 第四章总结

第四章是关于版本控制的使用方法以及模块化思想

### 适当的版本控制

关于自己创建git储存库：

```
git init
vi .gitignore
(.DS_Store
node_modules
*~)
git add -A
git commit -m "Commit the first time."
```

关于使用官方储存库：
```
git clone https://github.com/EthanRBrown/web-development-with-node-and-express
git checkout ch04
```

checkout是查找每章标签的操作。

> 每次对安装项进行修改的时候都要对修改进行--save操作以确保依赖项得到更新

### 模块化

模块化后的幸运语录：
```
var fortunesCookies = [
        "Conquer your fears or they will conquer you.",
        "Rivers need springs.",
        "Do not fear what you don't know.",
        "You will have a pleasant surprise.",
        "Whenever possible, keep it simple.",
];

exports.getFortune = function() {
        var idx = Math.floor(Math.random(( * fortuneCookies.length);
        return fortuneCookies[idx];
};
```

`exports`使外部只能接触到模块化的部分，其他部分无法接触。

进行修改后也请进行版本更新的记录。

## 第五章总结

本章主要阐述QA（质量保证，测试）在开发中的重要性。

### 所需工具

QA应当包含的四个维度：到达率（SEO，搜索引擎优化）、功能、可用性（用户测试）、审美。

QA技术：页面测试（Mocha）、跨页测试（Zombie.js）、逻辑测试、去毛（JShint）、链接检查（LinkChecker）

发现Javascript被修改了之后自动重启服务器的监控工具：nodemon（Grunt插件）

> 在安装这些测试工具时记得使用--save-dev而非--save以避免部署实例时安装不必要的依赖项。

### 工具配置

所有在根目录下进行的修改：
```
npm install --save-dev nodemon
npm install --save-dev grunt-nodemon
npm install --save-dev mocha
mkdir public/vendor
cp node_modules/mocha/mocha.js public/vendor
cp node_modules/mocha/mocha.css public/vendor
npm install --save-dev chai
cp node_modules/chai/chai.js public/vendor
```

### 全局测试

#### 对文件的配置

webjs（在所有路由前）:
```
//配置中间件，检测字符串中是否有test=1å
app.use(function(req, res, next){
	res.locals.showTests = app.get('env') !== 'production' && req.query.test === '1';
	next();
});
```

#### 修改
main.handlebars:
```
<!doctype html>
<html>
	<head>
		<title>Meadowlark Travel</title>
		{{#if showTests}}
			<link rel="stylesheet" href="/vendor/mocha.css">
		{{/if}}
		<script src="//code.jquery.com/jquery-2.0.2.min.js"></script>
	</head>
	<body>
		<header><img src="/img/icon2.png" width="100px" height="70px" alt="Meadowlark Travel Logo"></header>
		{{{ body }}}
		{{#if showTests}}
			<div id="mocha"></div>
			<script src="/vendor/mocha.js"></script>
			<script src="/vendor/chai.js"></script>
			<script>
				mocha.ui('tdd');
				var assert = chai.assert;
			</script>
			<script src="/qa/tests-global.js"></script>
			{{#if pageTestScript}}
				<script src="{{ pageTestScript }}"></script>
			{{/if}}
			<script>mocha.run()</script>
		{{/if}}
	</body>
</html>
```

/public/qa/tests-global.js:
```
suit('Global Tests', function(){
	test('page has a valid title', funcion(){
		assert(document.title && document.title.match(/\S/) && document.title.toUpperCase() !== 'TODO');
	});
});
```

测试脚本使用了jquery和自己添加的全局测试js脚本、以及mocha和chai，配置可在`main.handlebars`内看到。
完成后在所有页面链接后加上`?test=1`便可显示测试工具。

### 针对页面的测试

在/public/qa中添加tests-about.js文件：
```
suite('"About" Page Tests', function() {
	test('page should contain link to contact page', function() {
		assert($('a[href="/contact"]').length);
	});
});
// 确保about页面上总有一个指向contact页面的链接
```
修改web.js中about视图到路由并指定测试文件：
```
app.get('/about', function(req, res){
	res.render('about', { 
		fortune: fortune.getFortune(),
		pageTestScript: '/qa/tests-about.js' // 指明about视图应该使用哪个页面测试文件，与main layout中{{#if pageTestScript}}部分对应
	});
})
```
测试文件内容为确保about视图中有指向contact页面的链接，于是修改about视图，添加链接（虽然contact视图与路由还不存在）：
```
<h1>About Meadowlark Travel</h1>

<p>Your fortune for the day:</p> 
<blockquote>{{fortune}}</blockquote>
<p><a href="/contact">联系我们</a></p>
```

最后对路由进行添加：
```
app.get('/tours/hood-river', function(req, res){
	res.render('tours/hood-river');
})

app.get('/tours/request-group-rate', function(req, res){
	res.render('tours/request-group-rate');
})
```
这时就可以在网页上看到测试成功的提示了。
![页面测试成功.jpg](http://upload-images.jianshu.io/upload_images/4945773-85f09313bbe5220c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 跨页测试

#### 工具

在跨页测试中，我们需要[无头浏览器](https://my.oschina.net/u/2336761/blog/758360)，工具总的有三种选择：Selenium PhantomJS Zombie。最后一项不支持Windows平台。

`npm install --save-dev zombie`

#### 修改／添加

/views/tours/hood-river.handlebars：
```
<h1>Hood River Tour</hi>

<a class="requestGroupRate" href="/tours/request-group-rate">Request Group Rate.</a>
```

/views/tours/request-group-rate.handlebars:
```
<h1>Request Group Rate</h1>
<form>
	<input type="hidden" name="referrer">
	Name: <input type="text" name="name" id="fieldName"><br>
	Group size: <input type="text" name="groupSize"><br>
	Email: <input type="email" name="email"><br>
	<input type="suubmit" value="Submit">
</form>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name="referrer"]').val(document.referrer);
	});
</script>
```
在根目录创建/qa/tests-crosspage.js：
```
var Browser = require('zombie'),
	assert = require('assert');

var browser;

suite('Cross-Page Tests', function() {

	// 每次测试框架运行每个测试前都会运行setup()
	setup(function() {
		browser = new Browser();
	});

	test('requsting a group rate quote from the hood river tour page' + 'should populate the referrer field', function(done) {
		var referrer = 'http://localhost:3000/tours/hood-river';
		// 先检测1.是否来自产品页面 2.引用页是否正确
		// browser.visit()会加载页面，加载页面后就会调用回调函数
		// browser.clicklink()找到class为requestGroupRate的链接并访问
		browser.visit(referrer, function() {
			browser.clickLink('.requestGroupRate', function() {
				// 断言隐藏域referrer跟原来访问的页面是匹配的
			    // browser.field()返回一个DOM元素对象，具有value属性 
				// assert(browser.field('referrer').value === referrer);因为版本原因运行失败 下面这个丑一些的式子可以解决
				assert(browser.resources[0].request.headers._headers[0][1] === referrer);
                done();
			});
		});
	});

	test('requesting a group rate from the oregon coast tour page should' + 'populate the referrer field', function(done) {
		var referrer = 'http://localhost:3000/tours/oregon-coast';
		browser.visit(referrer, function() {
			browser.clickLink('.requestGroupRate', function() {
				assert(browser.field('referrer').value === referrer);// 断言测试因为版本问题 如今无法正常运行
				done();
			});
		});
	});

	// 最后一个测试确保直接访问Request Group Rate页面时referrer为空
	test('visitting the "request group rate" page directly should result' + ' in an empty referrer field', function(done) {
		browser.visit('http://localhost:3000/tours/request-group-rate', function() {
			assert(browser.field('referrer').value === '');
			done();
		});
	});
});
```

运行结果：
![跨页测试运行结果.jpg](http://upload-images.jianshu.io/upload_images/4945773-e62f9b6fe0016316.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
除成功的两条测试之外，因为尚未添加`oregen-coast.handlebars`，第二条测试自然不会通过。

#### 调试
- 途中遇到因为出书后zombie等版本更新问题导致的`tests-crosspage.js 22:5`在`mocha -u tdd -R spec qa/tests-crosspage.js`后会在hood-river测试中提示:

>    Uncaught AssertionError: Unspecified AssertionError
      at qa/tests-crosspage.js:22:5
      at EventLoop.done (node_modules/zombie/lib/eventloop.js:589:11)
      at Immediate.<anonymous> (node_modules/zombie/lib/eventloop.js:688:71)


更改为`assert(browser.resources[0].request.headers._headers[0][1] === referrer);`即解决问题

出自：[ch05 tests-crosspage.js fails to find 'referrer' field #48](https://github.com/EthanRBrown/web-development-with-node-and-express/issues/48)

- 以及因mocha默认timeout参数为2000，会提示

> Error: Timeout of 2000ms exceeded. For async tests and hooks, ensure "done()" is called; if returning a Promise, ensure it resolves.

在运行测试脚本`tests-crosspage.js`时测试语句改为`mocha -u tdd -R spec qa/tests-crosspage.js --timeout 30000`即可。

### 逻辑测试

#### 修改／添加

/qa/tests-unit.js:
```
var fortune = require('../lib/fortune.js');
var expect = require('chai').expect;

suite('Fortune cookies tests', function() {

	test('getFortune() should return a fortune', function() {
		expect(typeof fortune.getFortune() === 'string');
	});
});
```

#### 运行结果

启动测试：
`mocha -u tdd -R spec qa/tests-unit.js`

运行结果：
![逻辑测试运行结果.jpg](http://upload-images.jianshu.io/upload_images/4945773-0567168b7c205eec.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

顺带一提：熵功能的测试比较困难（随机性测试），即`getFortune()`的随机性是否有保证一事。

### 去毛、链接检查

#### 工具安装

```
npm install -g jshint
npm install -g linkchecker
```
> http://wummel.github.io/linkchecker/

#### 使用

`jshint web.js`

`linkchecker http://localhost:3000`

### Grunt实现自动化


- PATH文件保存后出现问题
`export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin`

然后在.bash_profile的路径下`source .bash_profile`

#### 工具准备

```
sudo npm install -g grunt-cli
npm install --save-dev grunt
npm install --save-dev grunt-cafe-mocha
npm install --save-dev grunt-contrib-jshint
npm install --save-dev grunt-exec
```

#### 添加／修改

在Gruntfile.js（根目录）中：
```
module.exports = function(grunt) {

	// 加载插件
	[
		'grunt-cafe-mocha',
		'grunt-contrib-jshint',
		'grunt-exec',
	].forEach(function(task){
		grunt.loadNpmTasks(task);
	});

	// 配置插件
	grunt.initConfig({
		cafemocha: {
			all: { src: 'qa/tests-*.js', options: { ui: 'tdd' }, } // 指定是tdd界面
		},
		jshint: {
			app: ['web.js', 'public/js/**/*.js', 'lib/**/*.js'], // /**/指的是子目录中所有文件
			qa: ['Gruntfile.js', 'public/qa/**/*.js', 'qa/**/*.js'],
		},
		exec: {
			linkchecker: { cmd: 'linkchecker http://localhost:3000' } // 日后可以把端口参数化
		},
	});

	// 注册任务
	grunt.registerTask('default', ['cafemocha', 'jshint', 'exec']); // 任务命名为default
};
```

#### 运行及运行结果

`grunt`后：


![grunt集成测试.jpg](http://upload-images.jianshu.io/upload_images/4945773-9eeaf287e9de3ee0.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 第六章总结

此章主要内容是关于客户端（浏览器）与服务器之间的请求以及请求页面如何返回的。

### URL组成部分

- 协议
 `http`  `https`  `file`  `ftp`
- 主机名
 `localhost`  `www.xxx.com`
- 端口
 `80`HTTP传输  `443`HTTPS传输  其他需要使用1023的端口  
- 路径
 `/about`
- 查询字符串
 `?test=1`  javascript提供了`encodeURIComponent()`来处理查询字符串的URL编码问题（代替空格为'+'，特殊字符被数字替换等）
- 信息片段
 `#q=express`

### HTTP请求方法

- GET
- POST

不使用AJAX的时候，浏览器与服务器通信的时候只会使用这两种方法

也存在DELETE等多样化的HTTP方法，但在Node和Express中通常要针对特殊方法编写处理程序。

### 请求报头

提供使用浏览器语言，用户代理信息等。

Express路由展示浏览器发送的请求报头方法：
```
app.get('/headers', function(req, res) {
    res.set('Content-Type', 'text/plain');
    var s = '';
    for(var name in req.headers) s += name + ': ' + req.headers[name] + '\n';
    res.send(s);
});
```

### 响应报头

提前告知内容类型方便浏览器进行渲染。指出响应信息是否被压缩，使用的是哪种编码。还可以包含关于浏览器对资源缓存时长等提示（第十六章）。

有时会指出服务器类型给黑客可乘之机，可以禁用Express的`X-Powered-By`头信息：`app.disable('x-powered-by')`

> 在 Chrome 浏览器中查看响应报 头信息的操作如下:
(1) 打开控制台。
(2) 点击网络标签页。
(3) 重新载入页面。
(4) 在请求列表中选取网页(通常是第一个)。
(5) 点击报头标签页，你就可以看到所有响应报头信息了。

### 互联网媒体类型

`test/html;charset=UTF-8` 类型：text，子类型：html，字符编码：UTF-8。

### 请求体

请求的主体。

- GET
 没有请求主体内容。
- POST
 最常见媒体类型：`application/x-www-form-urlendcoded`(键值对集合等简单编码,用&分隔)
 支持文件上传的POST请求：`multipart/form-data`
 AJAX请求：`application/json`

### 参数

参数来自于：
- 查询字符串
- 会话（请求cookie，第九章）
- 请求体或者指定的路由参数（第十四章）

$_REQUEST变量（将所有参数重新写入此变量）

### 请求对象

通常传递到回调函数里，通常命名为req或者request

最有用的属性与方法如下：

Node：
- `req.headers`
从客户端接收到的请求报头
- `req.url`
返回路径和查询字符串的属性（不包含协议，主机或端口）。若是出自内部路由目的，则可以重写。

Express：
- `req.params`
一个数组包含命名过的路由参数。（十四章）
- `req.param(name)`
返回命名的路由参数的方法，或者GET请求/POST请求参数。**建议忽略**
- `req.query`
包含GET请求参数的对象（以键值对存放的查询字符串参数）
- `req.body`
包含POST请求参数的对象。因为POST请求参数在REQUEST正文中传递而不像查询字符串在URL中传递。要使此属性可用需要中间件为能够解析请求正文内容类型。（第十章）
- `req.route`
关于当前匹配路由的信息。用于路由测试。
- `req.cookies`/`req.singnedCookies`
包含从客户端传递过来的cookies值的对象。（第九章）
- `req.accepts([types])`
用于确定客户端是否接受一个或一组制定类型的方法（可选类型可以是单个的MIME类型(application/json、一个逗号分隔集合、一个数组)）。**对于写公共API的人有用**。假定浏览器默认始终接受HTML类型。
- `req.ip`
客户端的IP地址。
- `req.path`
请求路径（不包含协议、主机、端口或查询字符串）
- `req.host`
返回客户端所报告的主机名的方法。（这些信息可以伪造，不应该用于安全目的）
- `req.xhr`
如果请求由AJAX发起则返回true的属性。
- `req.protocol`
用于标识请求的协议（http或者https）
- `req.secure`
如果链接为安全返回true的属性。等同于`req.protocol === 'https'`。
- `req.originalUrl`
接近req.url，但属性旨在保留原始请求和查询字符串
- `req.acceptedLanguages`
用来返回客户端首选的一组人类语言的方法。从请求报头中解析而来。

### 响应对象

通常传递到回调函数，通常命名为res. response

生命周期始于node对象http.ServerResponse

- `res.status(code)`
设置HTTP状态代码。Express默认200为成功，404为页面不存在，500为服务器内部错误。对于重定向（状态码301、302、303、307）有方法：redirect
- `res.set(name, value)`
设置响应头 **通常不需要手动设置**
- `res.cookie(name, value, [options])`, `res.clearCookie(name, [options])`
设置或清除客户端cookie值。需要中间件支持 **详见第九章**
- res.endrect([status], url)
重定向浏览器。默认重定向代码是302（建立）。**应当尽量减少重定向**，除非永久移动一个页面，这种情况的代码是301（永久移动）
- `res.send(body)`, `res.send(status, body)`
向客户端发送响应及可选的状态码。Express 的默认内容类型是 text/html。如果你想改 为 text/plain，需要在 res.send 之前调用 `res.set('Content-Type','text/plain\')`。如 果 body 是一个对象或一个数组，响应将会以 JSON 发送(内容类型需要被正确设置)， 不过既然你想发送 JSON，我推荐你调用 `res.json`。
- `res.json(json)`, `res.json(status, json)`
向客户端发送 JSON 以及可选的状态码。
- `res.jsonp(json)`, `req.jsonp(status, json)`
向客户端发送 JSONP 及可选的状态码。
- `res.type(type)`
一个简便的方法，用于设置 Content-Type 头信息。基本上相当于 `res.set('Content- Type','type')`，只是如果你提供了一个没有斜杠的字符串，它会试图把其当作文件的 扩展名映射为一个互联网媒体类型。比如，`res.type('txt')` 会将 Content-Type 设为 text/plain。此功能在有些领域可能会有用(例如自动提供不同的多媒体文件)，但是 通常应该避免使用它，以便明确设置正确的互联网媒体类型。
- `res.format(object)`
这个方法允许你根据接收请求报头发送不同的内容。这是它在 API 中的主要用途，我们 将会在**第 15 章**详细讨论。这里有一个非常简单的例子:`res.format({'text/plain':'hi there','text/html':'<b>hi there</b>'})`。
- `res.attachment([filename])`, `res.download(path, [filename], [callback])`
这两种方法会将响应报头 Content-Disposition 设为 attachment，这样浏览器就会选 择下载而不是展现内容。你可以指定 filename 给浏览器作为对用户的提示。用 `res. download` 可以指定要下载的文件，而 `res.attachment` 只是设置报头。另外，你还要将 内容发送到客户端。
- `res.sendFile(path, [options], [callback])`
这个方法可根据路径读取指定文件并将内容发送到客户端。使用该方法很方便。使用静 态中间件，并将发送到客户端的文件放在公共目录下，这很容易。然而，如果你想根据 条件在相同的 URL 下提供不同的资源，这个方法可以派上用场。
- `res.links(links)`
设置链接响应报头。这是一个专用的报头，在大多数应用程序中几乎没有用处。
- `res.locals`, `res.render(view, [locals], callback)`
`res.locals` 是一个对象，包含用于渲染视图的默认上下文。`res.render` 使用配置的模板引擎渲染视图(不能把 `res.render` 的locals 参数与`res.locals` 混为一谈，上下文 在 `res.locals` 中会被重写，但在没有被重写的情况下仍然可用)。res.render 的默认响 应代码为 200，使用 `res.status` 可以指定一个不同的代码。视图渲染将在第 7 章深入 讨论。

### 更多信息

Node提供了Express对象以确切知道自己在做什么。

`http://expressjs.com/api.html` Express的API
`https://github.com/ visionmedia/express/tree/master` Express的源码

路径说明：

- lib/applications.js
- lib/express.js
- lib/request.js
- lib/response.js
- lib/router/route.js

深入研究 Express 源码时，或许需要参考 Node 文档(http://nodejs.org/api/http.html)， 尤其是 HTTP 模块部分。

### 小结

#### 内容渲染

`res.render`根据布局渲染视图。`res.send`快速测试页。`req.query`得到查询字符串的值。`req.session`会话值。`req.cookie`/`req.singedCookies`Cookies值。

以下几个例子展现常见的内容渲染任务：

**6-1 基本用法**
```
app.get('/about', function(req, res){
    res.render('about');
});
```

**6-2 200以外的响应码**
```
app.get('error', function(req, res){
    res.status(500);
    res.render('error');
});
```
或者一行：
```
app.get('/error', function(req, res){
    res.status(500).render('error');
});
```

**6-3 将上下文传递给视图（包括查询字符串、cookie和session的值）**
```
app.get('greeting', function(req, res){
    res.render('about', {
        message: 'welcome',
        style: req.query.style;
        userid: req.cookie.userid,
        username: req.session.username,
    });
});
```

**6-4 没有布局的视图渲染**
```
// 以下layout没有.handlebars文件， 必须包含必要的HTML
app.get('/no-layout', funciont(req, res){
    res.render('no-layout', { layout: null});
});
```

**6-5 使用定制布局渲染视图**
```
// views/layouts/custom.handlebars
app.get('/custom-layout', function(req, res){
    res.render('custom-layout', { layout: 'custom' });
});
```

**6-6 渲染纯文本输出**
```
app.get('test', function(req, res){
    res.type('text/plain');
    res.send('this is a test');
});
```

**6-7 添加错误处理程序**
```
// 出现在所有路由方法的结尾
// 即使不需要next方法，也必须包含其中以便Express将它视为一个错误处理程序
app.use(function(req, res, next){
    console.error(err.stack);
    res.status(500).render('error');
});
```

**6-8 404处理程序**
```
// 出现在所有路由方法的结尾
app.use(function(req, res){
    res.status(404).render('not-found');
});
```

#### 处理表单

表单信息一般在req.body（偶尔req.query）中。
用req.xhr来判断是AJAX请求还是浏览请求（**第八章**）。

**6-9 基本表单处理**
```
// 必须引入中间件body-parser
app.post('/process-contact', function(req, res){
    console.log('Received contact from' + req.body.name + ' <' + req.body.email + '>');
    // 保存至数据库
    res.redirect*(303, '/thank-you');
})
```


**6-10 更强大的表单处理**
```
// 必须引入body-parser
app.post('process-contact', function(req, res){
    console.log('Received contact from ' + req.body.name + ' <' + req.body.email + '>');
    try{
        // 保存到数据库
        return res.xhr ? res.render({ success: true });
        res.redirect(303, '/thank-you');
    } catch(ex) {
        return res.xhr ? res.json({ error: 'Database error.' });
            res.redirect(303, '/database-error');
    }
});
```

#### 提供一个API

如果提供一个类似表单处理的API，参数通常会在req.query（偶尔是req.body）中。通常会返回JSON、XML或者纯文本而不是HTML。这种时候需要`PUT`、`POST`、`DELETE`等不太常见的HTTP方法**十五章**。

接下来的示例将使用以下通常是从数据库中检索而来的数组：
```
var tours = {
    { id: 0, name: 'Hood River', price: 99.99 },
    { id: 1, name: 'Oregon Coast', price: 149.95 },
};
```

**6-11 GET节点只返回JSON数据**
```
app.get('/api/tours', function(req, res){
    res.json(tours);
});
```

以下示例根据客户端的首选择，使用Express中的res.format方法对其响应。

**6-12 GET节点，返回JSON、XML或text**
```
app.get('/api/tours', function(req, res){
    var toursXml = '<?xml version="1.9"?><tours>' + products.map(function(p){
        return '<tour price="' + p.price + '" id="' + p.id +'">' + p.name + '</tour>';
    }).join('') + '</tours>'';
    var toursText = tours.map(function(p){
        return p.id +': ' + p.name +' (' + p.price + '(';
    }).join('\n');
    res.format({
        'application/json': function(){
            res.json(tours);
        },
        'application/xml': function(){
            res.type('application/xml');
            res.send(toursXml);
        },
        'text/plain': function(){
            res.type('text/plain');
            res.send(toursXml);
        }
    });
});
```

以下示例`PUT`节点更新一个产品信息然后返回JSON。参数在查询字符串中传递，路由字符串中的'':id''命令Express在req.params中添加一个id属性。

**6-13 用于更新的PUT节点**

```
//API用于更新一条数据并且返回JSON。参数在params中传递
app.put('/api/tour/:id', function(req, res){
    var p = tours.some(function(p){ return p.id == req.params,id });
    if( p ){
        if( req.query.name ) p.name = req.query.name;
        if( req.query.price ) p.price = req.query.price;
        res.json({ success: true });
    } else {
        res.json({error: 'No such tour exists.'});
    }
});
```

**6-14 用于删除的DEL节点**
```
// API用于删除一个产品
api.del('/api/tour/:id' function(req, res){
    var i;
    for( var i=tours.length-1; i>=0; i--){
        if( tours[i].id == req.params.id ) break;
    }
    if( i>=0 ){
        tours.splice(i, 1);
        res.json({success: true});
    } else {
        res.json({error: 'No such tour exists.'});
    }
});
```
