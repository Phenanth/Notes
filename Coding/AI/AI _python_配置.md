# Python学习AI - 配置问题

- 下载nltk时SSL问题

pip版本问题，报错：`There was a problem confirming the ssl certificate: [SSL: TLSV1_ALERT_PROTOCOL_VERSION] 
tlsv1 alert protocol version (_ssl.c:590) - skipping`

解决方法：

```bash
$curl https://bootstrap.pypa.io/get-pip.py >> get-pip.py

$sudo python get-pip.py

$python3 get-pip.py
```

- 使用matplotlib时出现问题

```
>>> import matplotlib
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: No module named matplotlib
```

尝试解决：
```bash
pip3 install matplotlib
python3
```
使用python3就没有再提示无法找到`matplotlib`这个模块的问题了，所以估计是版本冲突导致安装下来的`matplotlib`只存在于`python 3.7`中

- 爬虫框架Scrapy运行出错

报错：
```
    from twisted.conch import manhole, telnet
  File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/twisted/conch/manhole.py", line 154
    def write(self, data, async=False):
                              ^
SyntaxError: invalid syntax
```

解决方法：

`pip install git+https://github.com/twisted/twisted.git@trunk`

> because the 'trunk' branch had already merged the fix '9384-remove-async-param'