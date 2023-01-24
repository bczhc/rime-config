--[[
--无障碍版专用脚本
--用途：欧路词典，自动打开欧路词典(若存在)查词界面，查询指定内容

--版本号: 2.0
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月25日🗓️
农历: 鼠(庚子)年三月初二
时间: 22:53:50🕥
星期: 周三
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)
--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 词典.lua 文件放置 rime/script 文件夹内


]]

require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.*" 

import "script.包.其它.主键盘"
import "script.包.其它.首次启动提示"


local function 分享文字到欧路(导入内容)
 --分享文字到欧路
 text=导入内容
 intent=Intent(Intent.ACTION_SEND); 
 intent.setType("text/plain"); 
 intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
 intent.putExtra(Intent.EXTRA_TEXT, text); 
 intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
 --重点，指定包名和分享界面
 componentName =ComponentName("com.eusoft.eudic","com.eusoft.dict.activity.dict.LightpeekActivity");
 intent.setComponent(componentName)
 
 service.startActivity(Intent.createChooser(intent,"分享到:")); 

end--function 分享文字到欧路

--大写字母前面加空格
local function 大写字母前加空格(内容)
 大写字母="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 for i=1,#大写字母 do
  内容=内容:gsub(大写字母:sub(i,i)," "..大写字母:sub(i,i))
  
  
 end
 
 return 内容
end--function 大写加空格(内容)


local 参数 = (...)
local 编号=1

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 脚本名=File(脚本路径).getName()
local 纯脚本名=脚本名:sub(1,-5)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)
local 配置文件=脚本目录.."/脚本配置_勿删.txt"


local 提示内容=[[
说明:本脚本需配合欧路词典app
将自动打开欧路词典(若存在)查词界面，查询指定内容
若存在多个候选,点击内容后自动进行查询
]]
首次启动提示(脚本名,提示内容)


--跳转位置
if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end
--拆分上屏数据
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 内容=string.sub(参数,string.find(参数,"【【")+6,string.find(参数,"】】")-1)
 分享文字到欧路(内容)
 return
end


local 已启用=false
local 定制宽度=默认宽度
if File(配置文件).exists() then--配置文件存在
  for c in io.lines(配置文件) do--按行读取文件,检测脚本是否己启用
   if c=="测试功能=已启用" then
    已启用=true
    定制宽度=25
   end
  end--for
end--if 配置文件

import "com.osfans.trime.*" --载入包
local 候选组=Rime.getCandidates()
local 编码=Rime.RimeGetInput() --當前編碼

local 显示内容组={}
local 提示内容组={}

import "android.content.Context"  --导入类
local 剪贴板=tostring(service.getSystemService(Context.CLIPBOARD_SERVICE).getText()) --获取剪贴板 
显示内容组[#显示内容组+1]=剪贴板
提示内容组[#提示内容组+1]="剪贴板"

if 编码==nil || 编码=="" then
 分享文字到欧路(剪贴板)
 print("无候选,自动查询剪切板内容")
 return 
end




if string.find(编码,"\'")!=nil then
  local 句子=string.gsub(编码,"\'"," ")  
  显示内容组[#显示内容组+1]=句子
  提示内容组[#提示内容组+1]="句子"
else
 显示内容组[#显示内容组+1]=编码
 提示内容组[#提示内容组+1]="编码"
 显示内容组[#显示内容组+1]=string.upper(string.sub(编码,1,1))..string.sub(编码,2,#编码)
 提示内容组[#提示内容组+1]="首大写"
 显示内容组[#显示内容组+1]=string.upper(编码)
 提示内容组[#提示内容组+1]="大写"
end--if



if #候选组>0 then
 for i=1,#候选组 do
  显示内容组[#显示内容组+1]=tostring(候选组[i-1].text)
  提示内容组[#提示内容组+1]=tostring(候选组[i-1].comment)
  if 候选组[i-1].comment==nil then 提示内容组[#提示内容组]="" end
 end--for
end--if



--定义键盘
--------------------
local 短语数=25--单个键盘的短语数量
local 默认宽度=20
local 默认高度=32

import "android.content.pm.PackageManager"
local 版本号 = service.getPackageManager().getPackageInfo(service.getPackageName(), 0).versionName
local 版本号1=tonumber(string.sub(版本号,-8))

if 版本号1<20200526 then
 print("说明: 中文输入法版本号低于20200526,请升级到以上版本,否则无法运行该脚本")
 return
end


local 按键组={}

local 总序号=math.ceil(#显示内容组/短语数)
 local 按键={}
 按键["width"]=100
 按键["height"]=25
 按键["click"]=""
 按键["label"]=纯脚本名.."("..编号.."/"..总序号..")【长按上屏】"
 按键组[#按键组+1]=按键

if 编号==1 then
 if #显示内容组<短语数 then
  for i=1,#显示内容组 do
    local 按键={}
    local 位置=i
    按键["hint"]=提示内容组[位置]
    按键["long_click"]={label="", commit=显示内容组[位置]}
    按键["click"]={label=显示内容组[位置], send="function",command= 脚本相对路径,option= "【【"..显示内容组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数-#显示内容组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  local 按键=主键盘()
  按键["width"]=100
  按键组[#按键组+1]=按键
 else
  
 按键组[#按键组+1]=按键2
  for i=1,短语数 do
   local 子编号=i
   if #显示内容组>子编号-1 then
    local 按键={}
    local 位置=子编号
    按键["hint"]=提示内容组[位置]
    按键["long_click"]={label="", commit=显示内容组[位置]}
    按键["click"]={label=显示内容组[位置], send="function",command= 脚本相对路径,option= "【【"..显示内容组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
   end--if
  end--for
 local 按键={}
 按键["width"]=50
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=50
 按键组[#按键组+1]=按键


 end--if #显示内容组<25
end--if 编号==1

if 编号>1 then
if #显示内容组<编号*短语数 then
  for i=1,#显示内容组-(编号-1)*短语数 do
    local 按键={}
    local 位置=i+(编号-1)*短语数
    按键["hint"]=提示内容组[位置]
    按键["long_click"]={label="", commit=显示内容组[位置]}
    按键["click"]={label=显示内容组[位置], send="function",command= 脚本相对路径,option= "【【"..显示内容组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#显示内容组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=33
  按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=34
 按键组[#按键组+1]=按键

else
  for i=1,短语数 do
   local 子编号=i
   if #显示内容组>子编号-1 then
    local 按键={}
    local 位置=子编号+(编号-1)*短语数
    按键["hint"]=提示内容组[位置]
    按键["long_click"]={label="", commit=显示内容组[位置]}
    按键["click"]={label=显示内容组[位置], send="function",command= 脚本相对路径,option= "【【"..显示内容组[位置].."】】<<"..编号..">>"}
    if 提示内容组[位置]=="句子" then 按键["click"]={label=显示内容组[位置], send="function",command= 脚本相对路径,option= "【【"..显示内容组[位置].."】】《《翻译》》<<"..编号..">>"} end
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
  按键["width"]=33
 按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=33
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=34
 按键组[#按键组+1]=按键
end--if #显示内容组>编号*22
end--if 编号>1 







service.setKeyboard{
  name=string.sub(纯脚本名,1,#纯脚本名-4),
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }









