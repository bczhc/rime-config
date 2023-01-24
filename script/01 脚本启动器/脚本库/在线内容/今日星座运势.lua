

require "import"

local 参数 = (...)

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)


local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)

local  星座组={"♈白羊座","♉金牛座","♊双子座","♌巨蟹座","♌狮子座","♎处女座","♏天秤座","♐天蝎座","♑射手座","♓摩羯座","♒水瓶座","♍双鱼座"}

local  星座拼音={"baiyang","jinniu","shuangzi","juxie","shizi","chunv","tiancheng","tianxie","sheshou","mojie","shuiping","shuangyu"}


local 编号=0
local 日期=tostring(os.date("%Y%m%d"))
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 编号=tonumber(string.sub(参数,7,#参数-6))
 --print(日期)
end--if string.find(参数

if 编号!=0 then
local 云输入内容="https://m.smxs.com/xingzuoriyun/"..星座拼音[编号].."/date/"..日期..".html"
local 内容=""
local 内容组={}
Http.get(云输入内容,nil,"utf-8",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"span class=\"blue\">")
  内容="▂▂▂▂▂▂▂▂\n"..星座组[编号].."今日运势: \n☀"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+54)--整体运势
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n💗"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+54)--爱情运势
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n🎓"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+54)--事业学业
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n💰"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+54)--财富运势
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n🎏"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+45)--幸运颜色
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n🎰"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+40)--幸运数字
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n⭐"..string.sub(b,开始位置+18,开始位置+32)..string.sub(b,开始位置+40,开始位置+48)--速配星座
  
  开始位置=string.find(b,"span class=\"blue\">",开始位置+1)
  内容=内容.."\n📝"..string.sub(b,开始位置+18,开始位置+26)
  开始位置=string.find(b,"</span>",开始位置+1)
  local 结束位置=string.find(b,"</p>",开始位置+1)
  内容=内容..string.sub(b,开始位置+7,结束位置-1)--短评
  
  开始位置=string.find(b,"爱情运势",开始位置+1)
  开始位置=string.find(b,"<p>",开始位置+1)
  local 结束位置=string.find(b,"</p>",开始位置+1)
  内容=内容.."\n💏爱情运势: "..string.sub(b,开始位置+3,结束位置-1)
  
  开始位置=string.find(b,"健康运势",开始位置+1)
  开始位置=string.find(b,"<p>",开始位置+1)
  local 结束位置=string.find(b,"</p>",开始位置+1)
  内容=内容.."\n🏃健康运势: "..string.sub(b,开始位置+3,结束位置-1)
  
  
  内容=string.gsub(内容,"<br>","\n")
  内容=string.gsub(内容,"&nbsp;"," ")
  内容=string.gsub(内容,"<.->","")
  内容=string.gsub(内容,"&ldquo;","\"")
  内容=string.gsub(内容,"&rdquo;","\"")
  --内容=string.gsub(内容,"&nbsp"," ")
 --print(内容)
 task(100,function()
  service.addCompositions({内容}) end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)


end--if 星座


local 默认宽度=25
local 默认高度=40





local 按键组={}
 --第1行
 local 按键={}
 按键["width"]=100
-- 按键["height"]=25
 按键["click"]=""
 按键["label"]="今日星座运势"
 按键组[#按键组+1]=按键

for i=1,#星座组 do
 local 按键={}
 按键["click"]={label="", send="function",command= 脚本相对路径,option= "【【"..i.."】】"}
 按键["label"]=星座组[i]
 按键组[#按键组+1]=按键
 
 
end


import "script.包.其它.主键盘"
 local 按键=主键盘()
 按键["width"]=100
 按键组[#按键组+1]=按键

service.setKeyboard{
  name="今日星座运势",
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }


