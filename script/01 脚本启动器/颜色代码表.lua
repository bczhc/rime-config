--[[
--无障碍版专用脚本
--脚本名称: 天气
--用途：联网查找天气相关信息
--版本号: 2.0
▂▂▂▂▂▂▂▂
日期: 2020年08月13日🗓️
农历: 鼠🐁庚子年六月廿四
时间: 11:28:34🕚
星期: 周四
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)

--配置说明
用法一
第①步 将 脚本文件放置 Android/rime/script 文件夹内,

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键LuaTQ1，LuaTQ2

preset_keys:
  LuaTQ1: {label: 当前天气, send: function, command: '天气.lua', option: "《《命令行&&查当前候选》》"}#根据当前候选查找对应城市天气信息
  LuaTQ1: {label: 当前天气, send: function, command: '天气.lua', option: "《《命令行》》【【城市名称】】"}#城市名称为自定义项,可替换为 武汉,北京,广州等常用城市名
  
向该主题方案任意键盘按键中加入上述按键既可
--------------------
用法二
①放到脚本启动器->脚本库目录 下任意位置及子文件夹足中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,点击按键即可
]]




require "import"
import "java.io.File"
import "android.os.*"

import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "cjson"
import "com.osfans.trime.*" --载入包

import "script.包.其它.主键盘"





--自定义颜色键盘(键盘名称,单个键盘短语数,默认宽度,默认高度,按键组,参数,脚本相对路径,数据文件)
function 自定义颜色短语键盘(键盘名称,单个键盘短语数,默认宽度,默认高度,参数,脚本相对路径,数据文件)

import "android.content.pm.PackageManager"
local 版本号 = service.getPackageManager().getPackageInfo(service.getPackageName(), 0).versionName
local 版本号1=tonumber(string.sub(版本号,-8))

if 版本号1<20200526 then
 print("说明: 中文输入法版本号低于20200526,请升级到以上版本,否则无法运行该脚本")
 return
end

local 编号=1
local 短语组1={}
local 按键组={}




if 参数=="《《编辑数据》》" then
 service.editFile(数据文件) 
 return
end


if File(数据文件).exists()==false then
 io.open(数据文件,"w"):write("无数据,请编辑文件"):close()
end


for c in io.lines(数据文件) do
 if c!="" && string.sub(c,1,2)!="##" then
  c=c:gsub("<br>","\n")
  c=c:gsub("\\#","#")
  短语组1[#短语组1+1]=c 
 end
end--for



if 参数=="《《返回首页》》" || 参数=="《《导出数据_取消》》" || 参数=="《《导入数据_取消》》" then  编号=1 end


--跳转位置
if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end



local 总序号=math.ceil(#短语组1/单个键盘短语数)
 local 按键={}
 按键["width"]=100
 按键["height"]=25
 按键["click"]=""
 --按键["click"]={label=短语组1[i],commit=短语组1[i]}
 按键["label"]=键盘名称.."("..编号.."/"..总序号..")"
 按键组[#按键组+1]=按键


--上屏数据
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 位置=tonumber(string.sub(参数,string.find(参数,"【【")+6,string.find(参数,"】】")-1))
 service.commitText(短语组1[位置])
 
end


if 编号==1 then
 if #短语组1<单个键盘短语数 then
  for i=1,#短语组1 do
    local 按键={}
    local 位置=i
    按键["label"]=短语组1[位置]
    按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键["key_back_color"]=短语组1[位置]
    按键组[#按键组+1]=按键
  end--
  local 按键={}
  按键["width"]=默认宽度
  for i=1,单个键盘短语数-#短语组1 do
   按键组[#按键组+1]=按键
  end--for
  
  local 按键={}
  按键["width"]=33
  按键["click"]={label="编辑", send="function",command= 脚本相对路径,option= "《《编辑数据》》"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=33
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键=主键盘()
  按键["width"]=34
  按键组[#按键组+1]=按键
 else
  
 按键组[#按键组+1]=按键2
  for i=1,单个键盘短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    local 按键={}
    local 位置=子编号
    按键["label"]=短语组1[位置]
    按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键["key_back_color"]=短语组1[位置]
    按键组[#按键组+1]=按键
   end--if
  end--for
 local 按键={}
 按键["width"]=25
 按键["click"]={label="编辑", send="function",command= 脚本相对路径,option= "《《编辑数据》》"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=25
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=25
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=25
 按键组[#按键组+1]=按键


 end--if #短语组1<25
end--if 编号==1

if 编号>1 then
if #短语组1<编号*单个键盘短语数 then
  for i=1,#短语组1-(编号-1)*单个键盘短语数 do
    local 按键={}
    local 位置=i+(编号-1)*单个键盘短语数
    按键["label"]=短语组1[位置]
    按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键["key_back_color"]=短语组1[位置]
    按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,单个键盘短语数*编号-#短语组1 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=33
  按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=33
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=34
 按键组[#按键组+1]=按键

else
  for i=1,单个键盘短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    local 按键={}
    local 位置=子编号+(编号-1)*单个键盘短语数
    按键["label"]=短语组1[位置]
    按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键["key_back_color"]=短语组1[位置]
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
  按键["width"]=25
 按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=25
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=25
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=25
 按键组[#按键组+1]=按键
end--if #短语组1>编号*22
end--if 编号>1 


 service.setKeyboard{
  name=键盘名称,
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }

end--function 自定义短语键盘



local 参数=(...)


local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 数据文件=string.sub(脚本名,1,#脚本名-4)..".txt"




local 短语数=20--单个键盘的短语数量
local 默认宽度=25
local 默认高度=32


 自定义颜色短语键盘(string.sub(纯脚本名,1,#纯脚本名-4),短语数,默认宽度,默认高度,参数,脚本相对路径,数据文件)




