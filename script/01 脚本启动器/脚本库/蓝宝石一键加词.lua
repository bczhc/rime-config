--[[
--无障碍版专用脚本
--用途：一键加词
--如何使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf
--感谢风老师的细心指导🐂🍺
--配置说明

第①步 将 一键加词.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
preset_keys:
  yjjc_lua: {label: 一键加词, send: function, command: '一键加词.lua', option: "《《命令行》》【【词库名.txt】】"}#词库名称为自定义项
向任意按键加入上述按键既可

第③步 在任意输入框输入“词条+tab符号+编码”，例如 星空两笔	xklb
然后点击第②步添加的按键即可
]]

require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "java.io.File"
import "com.osfans.trime.*" --载入包
import "script.包.字符串.其它"

local 参数=(...)

Key.presetKeys.lua_script_1={label= '全选', send= "Control+a"}
Key.presetKeys.lua_script_2={label= '删除', send="BackSpace"}
service.sendEvent("lua_script_1")
local 词组和编码 = service.getCurrentInputConnection().getSelectedText(0)--取编辑框选中内容,部分app内无效
local 制表符="	"
local 词库文件=tostring(service.getLuaDir("")).."/SapphirePro_yhc.txt"--用户码表
   if 参数!=nil && string.find(参数,"《《命令行》》")!=nil then
     词库文件 = utf8.sub(参数, 10, -3)
     词库文件 = tostring(service.getLuaDir("")).."/"..词库文件
   end
if 词组和编码== nil or 词组和编码=="" then
do return end --强制退出
end
if string.find(词组和编码,制表符) != nil && #词组和编码>0 && 字符串首尾空(词组和编码)!="" then
  io.open(词库文件,"a+"):write("\n"):close()
  io.open(词库文件,"a+"):write(词组和编码):close()
  service.sendEvent("lua_script_2")
  Toast.makeText(service," 词组【"..词组和编码.."】 添加成功☑",2000).show()

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
  print("当前词条不符合编码规则")
end--string.find(词组和编码,制表符)
