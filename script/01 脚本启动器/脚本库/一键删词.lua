--[[
--无障碍版专用脚本
--用途：一键加词
--如何使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf
--感谢风老师的细心指导🐂🍺
--配置说明
第①步 修改个人词库文件名，默认词库为：xklb_phone_sdjc.txt，请修改为自己的词库名

第②步 将 一键删词.lua 文件放置 rime/script 文件夹内

第➂步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
preset_keys:
  yjsc_lua: {label: 🎙, send: function, command: '一键加词.lua', option: "%4$s"}
向任意按键加入上述按键既可

第④步 在任意输入框输入“词条+tab符号+编码”，例如 星空两笔	xklb
然后点击第③步添加的按键即可

]]require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "java.io.File"
import "com.osfans.trime.*" --载入包
import "script.包.字符串.其它"

local 文件路径1 = tostring(service.getLuaDir("")).."/SapphirePro.dict.yaml"
local 文件路径2 = tostring(service.getLuaDir("")).."/xklb_phone_sdjc2.txt"

Key.presetKeys.lua_script_1={label= '全选', send= "Control+a"}
Key.presetKeys.lua_script_2={label= '删除', send="BackSpace"}
service.sendEvent("lua_script_1")
local 词组和编码 = service.getCurrentInputConnection().getSelectedText(0)--取编辑框选中内容,部分app内无效
local 制表符="	"

if 词组和编码== nil or 词组和编码=="" then
do return end --强制退出
end
if string.find(词组和编码,制表符) != nil && #词组和编码>0 && 字符串首尾空(词组和编码)!="" then



local 内容1=""
--逐行读取文件
for c in io.lines(文件路径1) do
    if c == 词组和编码 then
    Toast.makeText(service," 词组【"..词组和编码.."】 删除成功☑",2000).show()
    else
    内容1=内容1..c.."\n"
    end
end
--写入文件
io.open(文件路径1,"w"):write(内容1):close()

local 内容2=""
if File(文件路径2).exists()==true then
--逐行读取文件
 for c in io.lines(文件路径2) do
    if c == 词组和编码 then
    Toast.makeText(service," 词组【"..词组和编码.."】 删除成功☑",2000).show()
    else
    内容2=内容2..c.."\n"
    end
 end
--写入文件
io.open(文件路径2,"w"):write(内容2):close()
end

--删除输入框词条
service.sendEvent("lua_script_2")
--刷新方案
local 方案组=Rime.getSchemaNames() --返回输入法方案组
if #方案组==1 then
  print("当前只有1个方案,无法切换,请保证有两个方案")
  return --退出
end
local 方案编号=Rime.getSchemaIndex()
local 切换编号=0
if 方案编号==0 then 切换编号=1 end
local 结果=Rime.selectSchema(切换编号)
Rime.selectSchema(方案编号)
if 结果==false then print("方案切换失败,请保证有两个方案") end

else
  service.sendEvent("lua_script_2")
  print("当前词条不符合规则")
end--if string.find(词组和编码,制表符)