s与Node框架学习笔记 - 2

## 第七章总结

主要讲述模版在使代码变得易写、易读、易维护的过程中是如何作用的，讲述如何使用模版语言使HTML动态化。

### 选择好的模版引擎
好的模板引擎的基础：
- 性能
- 客户端与服务端两端表现优秀的模版引擎
- 抽象（尖括号少、HTML中使用大括号）

另有[Veena Basavaraj的博客文章](http://engineering.linkedin.com/ frontend/client-side-templating-throwdown-mustache-handlebars-dustjs-and-more)可供参考。

如果你并不喜欢 Handlebars，可以轻 松地将它换掉。如果你想试试的话，可以使用这个有趣并且实用的工具：[Template-Engine- Chooser](http://garann.github.io/template-chooser)


### Handlebars基础
理解模版引擎的关键在于`contxt`（上下文环境）。当你渲染一个模版时，便会传递给模版引擎一个对象，叫做`上下文对象`，它能让替换标识运行。

例子：
上下文对象为：`{ name: 'Buttercup' }`，模板是`<p>Hello, {{name}}!</p>`。或者要向模板中传递HTML文本时，上下文是`{ name: '<b>Buttercup</b>' `则需要用模板`<p>Hello, {{{name}}}</p>`（三个大括号）

（大部分时候需要避免在JavaScript中编写HTML代码）

#### 注释写法

`{{! 秘密注释写这里 }}`。HTML注释写法：`<!-- 不那么秘密的注释写这里 -->`

服务器端模板中handlebars的注释不会被传递到浏览器，但如果用户查看HTML源文件，能够看到HTML的注释。

#### 块级表达式

块级表达式（block）提供了流程控制、条件执行和可扩展性。**复杂用法**

例如将此上下文对象：
```
{
    currency: {
        name: 'United States dollars',
        abbrev: 'USD',
    },
    tours: [
        { name: 'Hood River', price: '$99.95' },
        { name: 'Oregon Coast', price: '$159.95' },
    ],
    specialsUrl: '/january-specials',
    currencies: [ 'USD', 'GBP', 'BTC'],
}
```

传递到如下模版：
```
<ul>
    {{#each tours (1) }}
        {{! context has changed }}
        <li>
            {{name}} - {{price}}
            {{#if ../currencies}}
                {{../../currency.abbrev}} {{! (4)}}
            {{/if}}
        </li>
    {{/each}}
</ul>
{{#unless currencies}}
    <p>All prices in {{currency.name}}.</p>{{! (2)}}
{{/unless}}
{{#if specialsUrl}}
    {{! new block, context hasn't changed(sort of) (3) }}
    <p>Check out our <a href="{{specialsUrl}}">specials!</p>
{{#else}}
    <p>Please check back often for specials.</p>
{{/if}}
<p>
    {{#each currencies}}
    <a href="#" class="currency">{{.}}</a> {{! (5)}}
    {{else}}
        Unfortunately, we currently only accept {{currency.name}}.
    {{/each}}
</p>
```

1. 开始于each辅助方法用于遍历数组。each的每次遍历都会改变上下文，所以如果要访问上一级上下文需要使用`../.`。
2. unless方法：参数为false时执行。如果上下文属性本身就是一个对象可以直接访问它的属性`{{currency.name}}`。
3. 在if／else块中上下文与上一级上下文某种程度上是相同的（是上一级上下文的副本）。
4. 但是如果在each循环中使用if会进入新的上下文，这时要获得currency对象要使用`../../.`（第一个`../`获得产品的上下文，第二个获得最外层的上下文）。**应该在each块中避免使用if块**
5. 在`{{#each currencies}}`块中使用`{{.}}`将指向当前上下文（此例子中就是想打印出来的数组中的一个字符串）。

> 访问当前上下文还有另外一种独特的用法:它可以从当前上下文的属性中区 分出辅助方法(我们很快就会学到)。例如，如果有一个辅助方法叫作 foo， 在当前上下文中有一个属性也叫作 foo，则 {{foo}} 指向辅助方法，{{./ foo}} 指向属性。

#### 服务器端模板

客户不会看到服务器端模板或者是上下文对象。

除了隐藏细节，服务器端模板还支持模板`缓存`。模板引擎会缓存已编译的模板（模板发生改变的时候会重新编译和重新缓存），能改进模板视图的性能。（通常开发模式下缓存会被禁用，`app.set('view cache', true);`可以显式地启用视图缓存。）

`npm install --save express3-handlebars`后可以在Express中使用布局（默认在view/layouts下查找布局）

此方法可以不使用布局（或者使用特别的某个布局）：
```
app.get('/foo', function(req, res){
  res.render('foo', { layout: null });  
});
``` 

#### 局部文件

在前端通常称为“组件“这一类需要在不同的页面重复使用。`partial`通常不渲染整个视图或者整个网页。

通常使用方法：
- 将局部文件上下文放在`res.locals.patials`对象中（对于所有视图都可用）。
- 通过中间件获取数据并把数据添加给`res.locals.partials`对象。
- 通过局部文件（组件）操作`res.locals.partials`中储存的对应的指定相应上下文并呈现在网页上。

比如一个显示各地天气的组件`view/partials/weather.handlebars`:
```
<div class="weatherWidget">
    {{#each partials.weather.locations}}
    <div class="location">
        <h3>{{name}}</h3>
        <a href="{{forecastUrl}}"
            <img src="{{oconUrl}}" alt="{{weather}}">
            {{weather}}, {{temp}}
        </a>
    </div>
    {{/each}}
    <small>Source: <a href="http://www.wunderground.com">Weather Underground</a></small>
</div>
```

> 请注意，我们使用 partials.weather 为开头来命名上下文。我们想在任何页面上使用局部文 件，但上述做法实际上并不会将上下文传递给每一个视图，因此可以使用 res.locals(对于任何视图可用)。但是我们并不想让个别的视图干扰指定的上下文，于是将所有的局部文 件上下文都放在 partials 对象中。

目前获取数据将使用函数既定的虚拟数据：
```
function getWeatherData(){
    return {
        localtions: [
            {
                name: 'Portland',
                forecastUrl: 'http://www.wunderground.com/US/OR/Portland.html',
                weather: 'Overcast',
                temp: '54.1 F (12.3 C)',
            },
            {
                name: 'Bend',
                forecastUrl: 'http://www.wunderground.com/US/OR/Bend.html',
                weather: 'Partly Cloudy',
                temp: '55.0 F (12.8 C)',
            }
        ],
    };
}
```

创造给res.locals.particals对象添加数据的中间件（**第十章**）：
```
app.use(function(req, res, next){
    if(!res.locals.partials) res.locals.partials = {};
    res.locals.partials.weather = getWeatherData();
    next();
});
```

准备好这些工作后，需要修改`view/home.handlebars`文件：
```
<h2>Welcome to Meadowlark Travel!</h2>
{{> weather}}
```

`{{> weather}}`可以在视图中包含一个局部文件。 `express3-handlebars`会在`views/partials`中寻找叫做`partial_name.handle-bars`/`weather.handlebars`的视图。

如果有大量的局部文件，可以使用此方法引入它们：`{{> social/facebook}}`/`{{> social/twitter}}`

#### 段落

段落（`section`）：当视图本身需要添加到布局的不同部分时使用。（通常做法是向视图的`<head>`元素中添加一些东西／使用jQuery的`<script>`脚本）


实例化handlebars对象时添加`section`辅助方法：
```
var handlebars = require('express3-handlebars').create({
    defaultLayout: 'main',
    helpers: {
        section: function(name, options){
            if(!this._sections) this.sections = {};
            this._sections[name] = options.fn(this);
            return null;
        }
    }
});
```

`views/jquerytest.handlebars`:
```
{{#section 'head'}}
    <!-- -->
    <meta name="robost" content="noindex">
{{/section}}

<h1>Test Page</h1>
<p>We're testing some jQuery stuff.</p>

{{#section 'jquery'}}
    <script>
        $('document').ready(function(){
            $('h1').html('jQuery Works');
        });
    </script>
{{/section}}
```
> 在这个视图中 我们向`<head>`中添加了一些东西，并插入了一段jQuery的脚本。


`main.handlebars`:
```
<!doctype html>
<html>
    <head>
        <title>Meadowlark Travel</title>
        {{{_section.head}}}
    </head>
    <body>
        {{{body}}}
        <script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
        {{{_sections.jquery}}}
    </body>
</html>
```

> 在现在的布局中，段落可以实现将视图以布局的形式出现了。

#### 完善你的模版

HTML5模版：

- [HTML5 Bolierplate](http://html5boilerplate.com)
- [Themeforest](http://themeforest,net/category/site-templates)
- [WrapBootstrap](https://wrapbootstrap.com/)

使用方法：

1. 将主文件（index.html）重命名为main.handlebars
2. 将静态资源（CSS、JS、img）放在公共目录下
3. 编辑模版文件并指出在什么地方放置{{{body}}}表达式

使用原则：

- 出现在每一个页面：放在模版文件中。
- 出现在一个页面中：放在对应的视图中。
- 出现在部分的几个页面中：放在局部文件中。
- etc.

#### 客户端Handlebars

显示动态（实时变化）内容时使用。
比起AJAX调用并返回HTML片段（格式化HTML文本）后原样插入DOM，优势在于允许使用JSON数据接受AJAX调用的结果，并格式化来适应网站。**与第三方API通信时尤其有用**

加载Handlebars可以通过静态资源引入，或者CDN形式。
第二方法`views/nursery-rhyme.handlebars`：
```
{{#section 'head'}}
    <script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js"></script>
{{/section}}
```

选择模版放置位置：HTML中已存在的元素
（最好是隐藏元素，比如`<head>`中的`<script>`元素中）

```
{{#section 'head'}}
    <script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js"></script>
    
        <script id="nurseryRhymeTemplate" type="text/x-handlebars-template">Marry had a little <b>\{{animal}}</b>, its<b>\{{bodyPart}}</b>was <b>\{{adjective}}</b> as <b>\{{noun}}</b>.
        </script>
{{/section}}
```
> 转义大括号以避免服务器端试图对其尝试替换

使用模版前则需要编译：

```
{{#section 'jquery'}}
    $(document).ready(function(){
        var nurseryRhymeTemplate = Handlebars.compile(
            $('#nurseryRhymeTemplate').html());
    });
{{/section}}
```

添加两个按钮（测试用）来放置已渲染的模版：

```
<div id="nurseryRhyme">Click a button...</div>
<hr>
<button id="btnNurseryRhyme">Generate nursery rhyme</button>
<button id="btnNurseryRhymeAjax">Generate nursery thyme from AJAX</button>
```
> 其中一个通过JavaScript直接渲染，另外一个通过AJAX调用来渲染

渲染模版如下：

```
{{#section 'jquery'}}
    <script>
        $(document).ready(function(){
            
            var nurseryRhymeTemplate = Handlebars.compile(
                $('#nurseryRhymeTemplate').html());
            
            var $nurseryRhyme = $('#nurseryRhyme');
            
            $('#btnNurseryRhyme').on('click', function(evt){
                evt.preventDefault();
                $nurseryRhyme.html(nurseryRhymeTemplate(){
                    animal: 'basilisk',
                    bodyPart: 'tail',
                    adjective: 'sharp',
                    noun: 'a needle'
                }));
            });
            
            $('#btnNurseryRhymeAjax').on('click', function(evt){
                evt.preventDefault();
                $.ajax('/data/nursery-rhyme', {
                    success: function(data){
                        $nurseryRhyme.html(
                        nurseryRhymeTemplate(data))
                    }
                });
            });
        });
    </script>
{{/section}}
```

针对nursery rhyme页和AJAX调用的路由：

```
app.get('/nursery-rhyme', function(req, res){
    res.render('nursery-rhyme');
});
app.get('/data/nursery-rhyme', function(req, res){
    res.json({
        animal: 'squirrel',
        bodyPart: 'tail',
        adjective: 'bushy',
        noun: 'heck',
    });
});
```

Handlebars.compile接收一个模版，返回一个方法。此方法接受一个上下文对象，返回一个已渲染字符串。所以一旦编译模版，就可以像调用方法函数一样重新用模版渲染。

## 第八章总结

表单处理：HTML表单的处理方法、表单验证、文件上传。

提交表单的方法：
- 使用浏览器提交表单 
- AJAX提交表单
- 前端控件提交表单

### 向服务器发送客户端数据

向服务器发送客户端数据的两种方式（标准上来说）：
- 查询字符串（`GET`请求）
- 请求正文（`POST`请求）

> 误区：POST和GET一样，在使用HTTP协议时都是不安全的，而HTTPS协议中，两者都是安全的。

鉴于使用GET的时候用户会在查询字符串中看到所有的输入数据（包括隐藏域），而且浏览器会限制查询字符串长度，所以推荐使用POST进行表单提交。

## HTML表单

构建HTML表单的基础知识例子：

**not finished yet.**
