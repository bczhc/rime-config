我的Rime配置
--
# 方案列表

- 虎码（[https://tiger-code.com](https://tiger-code.com)）
- 九重鬼虎（[https://tiger-code.com](https://tiger-code.com)）
- 拼音++（[https://tiger-code.com](https://tiger-code.com)）
- X-SAMPA（[https://github.com/rime/rime-ipa](https://github.com/rime/rime-ipa)）
- 雲龍國際音標（[https://github.com/rime/rime-ipa](https://github.com/rime/rime-ipa)）
- 自然码+辅助码（[https://github.com/bigshans/rime-zrm](https://github.com/bigshans/rime-zrm)，[https://github.com/ssnhd/rime](https://github.com/ssnhd/rime)）
- 朙月拼音（[https://github.com/rime/rime-luna-pinyin](https://github.com/rime/rime-luna-pinyin)）
- 拉丁字母（[https://github.com/biopolyhedron/rime-latin-international](https://github.com/biopolyhedron/rime-latin-international)）

# 方案配置

## 虎码

### 命令与快捷输入

- **/date**与**/datem** 日期输入
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
- **/help** 显示帮助

可参考：

- https://github.com/bczhc/rime-config/blob/master/symbols.yaml
- https://github.com/ikatyang/emoji-cheat-sheet
- https://html.spec.whatwg.org/multipage/named-characters.html#named-character-references
- https://github.com/biopolyhedron/rime-latin-international/blob/master/latin_international.schema.yaml#L10-L16

### 输入设定

- 四码唯一自动上屏
- 五码顶屏
- 标点符号顶屏
- 回车清码
- 空格清除空码
- F键次选为上一次上屏内容，三选是上上次上屏内容。
- 分号次选，句号或斜杠三选，逗号四选
- 分号或大写字母（使用Shift）引导临时字母模式，支持空格，用回车上屏
- 反引号拼音反查
- 使用左右方括号输入逗句号
- 引号或Tab后跟一个字母为快捷符号，可自动上屏+顶屏。并且可连续上屏多个符号

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
- Ctrl+Space 重选重码（还不稳定）

## 自然码

### 功能

- 编码用分号添加辅助码
- Ctrl+P 显示拼音
- Ctrl+F 显示辅助码编码
- 使用反引号（`` ` ``）引导组字（编码依然是自然码双拼，比如“曌”字使用`` `myks ``）

