# Python学习AI - 工具使用

主要包含对于自然语言处理的相关知识与工具。

## NLTK库与matplotlib的基础使用

### 搜索文本

- 上下文
`text1.concordance('former')`
- 近义词
`text1.similar('ship')`
- 出现位置
`text4.dispersion_plot(["citizens", "duties", "America"])`

### 词统计

- 总字数
`len(text1)`
- 所有词集合
`set(text1)`
- 文本总词数
`len(set(text1))`
- 某词出现次数
`text4.count("is")`
- 统计词频并从大到小存入列表
`D = FreqDist(text4)`
- 输出统计词频的累计图像
`D.plot(50, cumulative = Ture)`

## 工具

**以下内容有关语料来源，语料统计**

### 加载自己的语料库

假设语料库路径为`/tmp`

```python
from nltk.corpus import PlaintextCorpusReader
corpus_root = '/tmp'
wordlists = PlaintextCorpusReader(corpus_root, '.*')
wordlists.fileids()
```

### 语料库通用接口

- 文件
`fileids()`
- 分类
`categories()`
- 原始内容
`raw()`
- 词汇
`words()`
- 句子
`sents()`
- 指定文件在磁盘上的位置
`abspath()`
- 打开语料库文件流
`open()`

### 其他词典资源

词汇列表语料库：`nltk.corpus.words.words()`，所有英文单词，这个可以用来识别语法错误

停用词语料库：`nltk.corpus.stopwords.words`，用来识别那些最频繁出现的没有意义的词

发音词典：`nltk.corpus.cmudict.dict()`，用来输出每个英文单词的发音

比较词表：`nltk.corpus.swadesh`，多种语言核心200多个词的对照，可以作为语言翻译的基础

同义词集：`WordNet`，面向语义的英语词典，由同义词集组成，并组织成一个网络

### 条件频率分布

自然语言的条件频率分布就是指定条件下某个事件的频率分布。

`condition.py`:
```
# For Python 3.7

import nltk
from nltk.corpus import brown

# 链表推导式
genre_word = [(genre, word)
		for genre in brown.categories()
		for word in brown.words(categories = genre)
	]

# 条件频率分布
cfd = nltk.ConditionalFreqDist(genre_word)

# 制定条件与样本作图
cfd.plot(conditions = ['news', 'adventure'], samples = [u'stock', u'sunbonnet', u'Elevated', u'narcotic', u'four', u'woods', u'railing', u'Until', u'aggression', u'marching', u'looking', u'eligible', u'electricity', u'$25-a-plate', u'consulate', u'Casey', u'all-county', u'Belgians', u'Western', u'1959-60', u'Duhagon', u'sinking', u'1,119', u'co-operation', u'Famed', u'regional', u'Charitable', u'appropriation', u'yellow', u'uncertain', u'Heights', u'bringing', u'prize', u'Loen', u'Publique', u'wooden', u'Loeb', u'963', u'specialties', u'Sands', u'succession', u'Paul', u'Phyfe'])

```

条件生成最大概率双连词组

`collab.py`:
```
# For Python 3.7

import nltk

# 循环十次，从cfdist中取当前单词最大概率的连词并打印出来
def generate_model(cfdist, word, num = 10):
	for i in range(num):
		print(word)
		word = cfdist[word].max()

################################

# 加载语料库
text = nltk.corpus.genesis.words('english-kjv.txt')

# 生成双连词
bigrams = nltk.bigrams(text)

# 生成条件频率分布
cfd = nltk.ConditionalFreqDist(bigrams)

# 以the开头生成随机串
generate_model(cfd, 'the')

```

---

**以下内容有关语料处理**

### 英文词干提取
```
import nltk
porter = nltk.PorterStemmer()
porter.stem('lying')
```

### 词性标注

词性包括`CC`连词、`RB`副词、`IN`介词、`NN`名词、`JJ`形容词、`PRP`人称代词、`VB`&`VBP`动词等。

```
import nltk
text = nltk.word_tokenize("And now for something completely different")
nltk.pos_tag(text)
```

结果：
```
[('And', 'CC'), ('now', 'RB'), ('for', 'IN'), ('something', 'NN'), ('completely', 'RB'), ('different', 'JJ')]
```

对于中文的词性标注，利用`nltk`提供的用户自行标注词性的方法`nltk.tag.str2tuple('fly/NN')`，可以自行标注词性
```
tagged_token = nltk.tag.str2tuple('fly/NN')
```
中文：
```
sent = "我/NN 不/RB 知道/VBP"
[nltk.tag.str2tuple(t) for t in sent.split()]
```

或者使用繁体中文字库的词性

```
# For Python 3.7

import nltk

# 输出繁体中文词库中，词汇相应的词性
for word in nltk.corpus.sinica_treebank.tagged_words():
	print(word[0], word[1])

```

以及`jieba`切词，[源代码](https://github.com/fxsjy/jieba)

```
# For Python 3.7

import jieba

# 最近，“我想下班”被翻译成"I want to work"的事情真的很好笑。
seg_list = jieba.cut("我想下班，或者磨洋工", cut_all = False)
print(",".join(seg_list))

```

### 自动词性标注

#### 标注器分类

- 默认标注器

将词性标注为频率最高的一种词性：名词（NN），通过`nltk.DefaultTagger()`实现。

```
# For Python 3.7

import nltk

default_tagger = nltk.DefaultTagger('NN')
raw = "我 想 下 班"
tokens = nltk.word_tokenize(raw)
tags = default_tagger.tag(tokens)

print(tags)

################
Result：
[('我', 'NN'), ('想', 'NN'), ('下', 'NN'), ('班', 'NN')]
```

- 正则表达式标注器

满足特定正则表达式的被认为是某种词性（带“们”的都认为是代词PRO），通过`nltk.RegexpTagger()`实现。

```
# For Python 3.7

import nltk

raw = "我们 感觉 其实 还好吧， 你们 呢"
text = nltk.word_tokenize(raw)
pattern = [(r'.*们$', 'PRO')]
tagger = nltk.RegexpTagger(pattern)

print(tagger.tag(text))

################
[('我们', 'PRO'), ('感觉', None), ('其实', None), ('还好吧，', None), ('你们', 'PRO'), ('呢', None)]
```

- 查询标注器（一元标注）

找出最频繁的词，去语料库查词性并标注，不匹配的内容使用默认标注器。

```
# For Python 3.7

import nltk

tagged_sents = [[(u'我', u'PRO'), (u'喜欢', u'VBP')]]
unigram_tagger = nltk.UnigramTagger(tagged_sents)
sents = [[u'我', u'不', u'喜欢']]
tags = unigram_tagger.tag(sents[0])

print(tags)
```

> 除了自行标注，也可以使用已经标注过的语料库例如`brown_tagged_sents = brown.tagged_sents(categories='news')`

- 二元标注&多元标注

将考虑词范围扩大，用法换为`nltk.BigramTagger`与`TrigramTagger`

- 组合标注器

为了提高精度与覆盖度，组合多种标注器的做法。
```
t0 = nltk.DefaultTagger('NN')
t1 = nltk.UnigramTagger(train_sents, backoff = t0)
t2 = nltk.TrigramTagger(train_sents, backoff = t1)
```

#### 标注器的储存

```
# For Python 3.7

import nltk
from _pickle import dump
from _pickle import load

train_sents = [[(u'我', u'PRO'), (u'喜欢', u'VBP')]]

# 组合标注器的写法

t0 = nltk.DefaultTagger('NN')
t1 = nltk.UnigramTagger(train_sents, backoff = t0)
t2 = nltk.TrigramTagger(train_sents, backoff = t1)

# 储存

output = open('t2.pkl', 'wb')
dump(t2, output, -1)
output.close()

# 加载

input = open('t2.pkl', 'rb')
tagger = load(input)
input.close()

```
---

**以下内容有关语言文法**

### 语法分析

语法分析要基于文本分块。

英语语料中有已经标注好的分块信息：
```
from nltk.corpus import conll2000
print(conll2000.chunked_sents('train.txt')[99]
```

根据分块完毕的语料进行机器训练即可。

> 由于此类分块使用的储存结构比较特殊，暂时没有实现基于这种储存结构的训练及预测代码。日后有机会可以实现一下。

### 文法分析

基于对**文法特征**的掌握，根据个别句子的文法特征进行具体分析。

#### 特征结构

文法特征的举例：

- 单词最后一个字母
- 词性标签
- 文法类别
- 正字拼写
- 指示物
- 关系
- 施事角色
- 受事角色

特殊的文法特征：

- 句法协议（语法）
- 属性和约束
- 术语

#### 处理特征结构

`nltk库`实现的定义特征结构方法（字典形式）：

```
import nltk

fs1 = nltk.FeatStruct(TENSE='past', NUM='sg')
fs2 = nltk.FeatStruct(POS='N', AGR=fs1)
print(fs2)
```

分析查询国家城市的`SQL`语句文法, `nltk_data/grammars/book_grammars/sql0.fcfg`：
```
% start S

/* 合成结果，句子由主要的特征组成 */
S[SEM=(?np + WHERE + ?vp)] -> NP[SEM=?np] VP[SEM=?vp]

/* 主要的五个特征，又由子特征与各种限制组合而成 */
VP[SEM=(?v + ?pp)] -> IV[SEM=?v] PP[SEM=?pp]
VP[SEM=(?v + ?ap)] -> IV[SEM=?v] AP[SEM=?ap]
NP[SEM=(?det + ?n)] -> Det[SEM=?det] N[SEM=?n]
PP[SEM=(?p + ?np)] -> P[SEM?=p] NP[SEM?=np]
AP[SEM=?pp] -> A[SEM=?a] PP[SEM?=pp]

/* 子特征的来源：替换句子成分为SQL语句 */
NP[SEM='Country="greece"'] -> 'Greece'
NP[SEM='Country="china"'] -> 'China'

Det[SEM='SELECT'] -> 'Which' | 'What'

N[SEM='City FROM city_table'] -> 'cities'

IV[SEM=''] -> 'are'
A[SEM=''] -> 'located'
P[SEM=''] -> 'in'
```

调用：

```
# For Python 3.7

import nltk
from nltk import load_parser

cp = load_parser('/Users/charlotte_chen/nltk_data/grammars/book_grammars/sql0.fcfg')

# 字典化
query = 'What cities are located in China'
tokens = query.split()

# 显示结构树的组成情况
for tree in cp.parse(tokens):
	print(tree)
```

从输出结果可以看到，句子的特征是由子特征与限制条件组合而成。

### 文本分类

#### 贝叶斯分类器

机器学习的过程是训练模型和使用模型的过程。进行学习的算法有很多种，这里主要介绍`nltk库`中的贝叶斯分类器。

```
# For Python 3.7

import nltk

my_train_set = [
	({'feature1' : u'a'}, '1'),
	({'feature1' : u'a'}, '2'),
	({'feature1' : u'a'}, '3'),
	({'feature1' : u'a'}, '3'),
	({'feature2' : u'b'}, '2'),
	({'feature2' : u'b'}, '2'),
	({'feature2' : u'b'}, '2'),
	({'feature2' : u'b'}, '2'),
	({'feature2' : u'b'}, '2'),
	({'feature2' : u'b'}, '2'),
	]

classifier = nltk.NaiveBayesClassifier.train(my_train_set)

print(classifier.classify({'feature1' : u'a'}))
print(classifier.classify({'feature2' : u'b'}))

```

> 实际的特征和数量都可能会更多

#### 文档分类

> 训练与预测都需要提取特征。

分类步骤：

1. 根据整体提取出高频率特征
2. 对整体样本进行正规化
3. 取正规化后样本的一部分与特征进行匹配，提取出该部分样本的特征进行训练
4. 使用分类器对正规化后样本的另一部分进行预测
5. 显示预测准确率并提出最具有信息量的五个特征


这个例子的目的是通过各种影评的正负面评分来判断使用频率高的文字的褒贬性。

把评论中与高频率特征中相同的词语和评论的pos/neg看作样本的特征与表现，由此进行样本正规化，生成以文章内容与文章评价的二元组组成的样本列表。

此后，对此样本中二元组的列表内容进行筛选，只保留与高频特征词相同的词与分类，交给贝塞尔分类器进行这些高频词的性质判断。
```
# For Python 3.7

import nltk
import random
from nltk.corpus import movie_reviews

# 提取特征

# 转换为小写
all_words = nltk.FreqDist(w.lower() for w in movie_reviews.words())

# 提取字典中，出现频率为前两千的词
word_features = list(all_words.keys())[:2000]

# 函数：将检测文本document中的词与特征词集word_features进行匹配，有则为True
def document_features(document):
	document_words = set(document)
	features = {}
	for word in word_features:
		features['contains(%s)' % word] = (word in document_words)
	return features

#########################

# 训练

# 样本正规化
documents = [(list(movie_reviews.words(fileid)), category)
		for category in movie_reviews.categories()
		for fileid in movie_reviews.fileids(category)
	]
random.shuffle(documents)

featuresets = [(document_features(d), c) for (d, c) in documents]
train_set = featuresets[100:]
classifier = nltk.NaiveBayesClassifier.train(train_set)

# 预测

test_set = featuresets[:100]
print(nltk.classify.accuracy(classifier, test_set))

# 得到最优信息量特征
classifier.show_most_informative_features(5)

```

> 这里因为大量特征的来源与测试样本的来源一致，所以特征匹配的结果一定是True

#### 其它分类

- 词性分类
- 句子分割
- 识别对话行为类型
- 识别文字蕴含
