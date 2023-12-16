我的Rime配置
--
# 方案列表

- 092五笔（群7390600）
- 雲龍國際音標（[https://github.com/rime/rime-ipa](https://github.com/rime/rime-ipa)）
- 朙月拼音（[https://github.com/rime/rime-luna-pinyin](https://github.com/rime/rime-luna-pinyin)）
- 拉丁字母（[https://github.com/biopolyhedron/rime-latin-international](https://github.com/biopolyhedron/rime-latin-international)）
- 全字集笔画（用<b>/sk</b>引导，码表来自092五笔正规闲聊群 摩羯星壹号2842834）

# 方案配置

## 092五笔

### 命令与快捷输入

- **/date**与<b>/datem</b> 日期输入
- **/time** 时间输入
- **/week** 星期输入
- **/cal**或<b>/cal</b>+***日期*** 日历与公历农历互转
- **=**+***算式***  简易计算器
- **/ts** UNIX时间戳
- **/idt** 类ISO 8601时间
- **/cdt** 袖珍（纯数字）时间与日期yyyyMMdd或HHmmss的格式
- **/num**+***数字*** 数字转大写
- **/uni**+***Unicode码点*** 输入Unicode
- **/em**+***name*** 输入Emoji
- **/hc**+***name*** 输入HTML命名字符
- **/lt**+***code*** 输入拉丁
- **/info** 显示软件有关信息
- **/env/**+***name*** 显示环境变量
- **/ipa** 输入IPA（使用的是云龙国际音标）
- **/nipa** 输入命名的IPA符加符号（名称为官方IPA chart里的）
- **/sk** 笔划输入（五个笔画分别为`ghtyn`）
- **/jp** 假名输入
- **/cb** 组合附加字符（combining diacritics）输入
- **/help** 显示帮助

可参考：

- 符号：https://github.com/bczhc/rime-config/blob/master/symbols.yaml
- 快符：https://github.com/bczhc/rime-config/blob/master/short_punct.dict.yaml
- Emoji：https://github.com/ikatyang/emoji-cheat-sheet
- HTML字符：https://html.spec.whatwg.org/multipage/named-characters.html#named-character-references
- 拉丁字母：https://github.com/biopolyhedron/rime-latin-international/blob/master/latin_international.schema.yaml#L10-L16

### 输入设定

- 四码唯一自动上屏
- 五码顶屏
- 标点符号顶屏
- 回车清码
- 空格清除空码
- 分号次选，撇号三选，`` ` ``（使用CapsLock映射）四选，左方括号五选，Tab六选，斜杠十选
- 分号或大写字母（使用Shift）引导临时字母模式，支持空格，用回车上屏

  ![Peek 2023-09-18 10-57](https://github.com/bczhc/rime-config/assets/49330580/532f2388-3af1-4b9d-a55d-69ea02f589b7)

- 反引号拼音反查
- 按一次或一直按住z为快符模式，可顶屏和连续上屏：使用字母输入快捷符号，使用空格重复上一次上屏内容，z+m重复倒数第二次上屏内容，z+;上屏中文分号

  ![Peek 2023-07-18 13-24](https://github.com/bczhc/rime-config/assets/49330580/ac95c3aa-5950-4eee-891d-216e0903bac1)

### 快捷键

- Ctrl+\` 方案选择
- Ctrl+O 繁简转换
- Ctrl+Y 显示Unicode编码
- Ctrl+U 显示Unicode分区
- Ctrl+P 显示拼音
- Ctrl+J 显示拆分
- Ctrl+H 常用字与全字集切换
- Ctrl+period 全半角标点切换
- Ctrl+E Emoji开关
- Ctrl+D 单字模式
- Ctrl+I preedit为候选
- Ctrl+S 全角半角切换
- Shift+Space 中西文切换
- z+r 撤销上屏内容（由于librime没有一种和前端之间回删的协议，只能在lua中使用xdotool实现）

### 较原版字根改动

- 幽 mo 由“纟山纟”改拆为“山𢆶”

### 四码字

除超集外，还使用四码的单字有：

- 智 ckjf（因`ckj`留给了`智能`，与`知晓 ckjx`离散，而`ckj;`又相对不好按。
- 汩 ijgg（末尾g为音补）
- 汨 ijgm（末尾m为音补）

### 自定义重码离散

一些重码会出简，比如`分享 my` `分离 mvyb`；
还有的会使用三码二字词，如：`昏暗 snj` `机能 snjx` `肚子 efb` `脖子 efbo`

#### 首码相同的四字词（或超过四字词）

如“忧心忡忡”，由“nnnn”改为“nisn”。离散规则为：取第一个字的第一码、第二个字的第二码、倒数第二个字的第二码、第四个字的第一码。

效果（部分）：![image](https://github.com/bczhc/rime-config/assets/49330580/6242d7b0-36fb-4839-a40c-e7a4974d76f6)


注意到像“魃魈魁魅”“魑魅魍魉”这样依然无法分离的词组，就继续跳根，做类似的操作。

对于全部同偏旁的词，很容易能反应并应用新的取码规则。但对于“福禄双全”“合作伙伴”这类四码相同但又
不同偏旁的词，相对难以反应。这类词会保留原码。

#### 第一和第二根相同而致无法分离的二字词组

如“鼪鼬”，由“vuvu”改成“vpnu”。规则为：取第一个字的首码和第三码，取第二个字的第三码和第二码。

这类词有：

> 琵琶 gajg\
> 瑟瑟 gnng\
> 琴瑟 gdng\
> 鼹鼠 vjju\
> 鼪鼬 vpnu\
> 鼪鼯 vpsu\
> 龌龊 cnlb\
> 龃龉 cesb\
> 龋齿 cttb\
> 齿龈 cvvb\
> 鬼魅 qffq\
> 魍魉 qmeq

![image](https://github.com/bczhc/rime-config/assets/49330580/c1eaf04a-a52b-46e2-9d90-59eddcc34d5f)

这些词只是实验着玩的，实践中几乎难以反应过来，所以没有删原码。

#### 以及非常少数的无理码，通常都是难以反应过来的字词

> 串 skk（原skd，新规定末笔为竖）\
> 卐 卍 nnv（原ngh和nhg，新统一都拆成“折折”）
