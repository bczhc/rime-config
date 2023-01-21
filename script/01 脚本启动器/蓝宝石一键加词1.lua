--[[无障碍版专用脚本
--用途：一键加词，可自定义编码和自动编码
--配置说明：
  第①步 将 一键加词.lua 文件放置 rime/script 文件夹内，修改lua内单表路径
  第②步 向主题方案中加入按键
  以 XXX.trime.yaml主题方案为例
  preset_keys:
    yjjc_lua: {label: 加词, send: function, command: '蓝宝石一键加词.lua'}
  向任意按键加入上述按键既可
  第③步 
  	第一种：在任意输入框输入“词条+tab符号+编码”，例如：自动编码	tfxd
  	第二种：在任意输入框输入“词条+空格+编码”，例如：自动编码 tf
  	第三种：在任意输入框只输入“词条”即可，例如：自动编码
  	注：自定义的编码为一⾄四码内的小写英文字母，分隔符可用空格和tab两种
  然后点击或长按第②步添加的按键即可一键加词]]
require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "com.osfans.trime.*"
import "script.包.字符串.其它"
Key.presetKeys.lua_script_1={label= '全选', send= "Control+a"}
Key.presetKeys.lua_script_2={label= '删除', send="BackSpace"}
service.sendEvent("lua_script_1")
local 词组 = service.getCurrentInputConnection().getSelectedText(0)
local 词库文件=tostring(service.getLuaDir("")).."/SapphirePro_yhc.txt"--用户挂接码表
local 单表路径=tostring(service.getLuaDir("")).."/SapphirePro_danzi.txt"--自动编码所用单字码表
if 词组== nil or 词组=="" then do return end end
local function 写入词库(字符串)
	io.open(词库文件,"a+"):write("\n"..字符串):close()
	service.sendEvent("lua_script_2")
	Toast.makeText(service," 词组【"..字符串.."】 添加成功",2000).show()
	local 方案索引=Rime.getSchemaIndex()
	if 方案索引==0 then Rime.selectSchema(1) else Rime.selectSchema(0) end
	Rime.selectSchema(方案索引)
end
local function 格式判断(字符串)
  if string.byte(词组) >= 33 && string.byte(string.reverse(词组)) >= 97 && string.byte(string.reverse(词组)) <= 122 then
    local 位置=utf8.find(字符串," ")
    if  位置==nil then 位置=utf8.find(字符串,"\t") end
    if  位置==nil then return 0 end
    for i= 位置+1,utf8.len(字符串) do
      if string.byte(utf8.sub(字符串,i,i))<97 || string.byte(utf8.sub(字符串,i,i))>122 then return 0 end
    end
    return 1
  end
end
if string.byte(词组) >= 127 && string.byte(string.reverse(词组)) >= 127 && utf8.len(词组)>= 2 then
	local 单表内容=string.gsub(io.open(单表路径):read("*a"),"\n","")
	local n=utf8.len(词组)
	local 编码,定位=""
	if n==2 then
		for i=1,n do
		  定位=utf8.find(单表内容,utf8.sub(词组,i,i))
			编码=编码..utf8.sub(单表内容,定位+2,定位+3)
		end
	end
	if n>=3 then
		for i=1,3 do
			定位=utf8.find(单表内容,utf8.sub(词组,i,i))
			编码=编码..utf8.sub(单表内容,定位+2,定位+2)
		end
    定位=utf8.find(单表内容,utf8.sub(词组,n,n))
		if n==3 then
		  编码=编码..utf8.sub(单表内容,定位+3,定位+3)
		else
		  编码=编码..utf8.sub(单表内容,定位+2,定位+2)
		end
	end
	写入词库(词组.."\t"..编码)
elseif 格式判断(词组)==1 then
  local 位置=utf8.find(词组," ")
	if utf8.find(词组," ")!=nil then 词组=utf8.sub(词组,1,位置-1).."\t"..utf8.sub(词组,位置+1) end
	写入词库(词组)
else
  service.sendEvent("lua_script_2")
	print("当前词条不符合编码规则")
end
