
--[[
--无障碍版专用脚本
--脚本名称: 切换主题
--用途：如上
--版本号: 2.0
▂▂▂▂▂▂▂▂
日期: 2020年08月25日🗓️
农历: 鼠🐁庚子年七月初七
时间: 17:59:17🕠
星期: 周二
--制作者: 风之漫舞
--首发qq群: Rime 同文斋(458845988)
--邮箱: bj19490007@163.com(不一定及时看到)

--配置说明
用法一
第①步 将 脚本文件放置 Android/rime/script 文件夹内,

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，LuaTheme0，LuaTheme2

preset_keys:
  LuaTheme0: {label: 主题, send: function, command: '切换主题.lua', option: ""}#显示rime目录下所有主题到一个键盘,点击切换并显示
  LuaTheme1: {label: 主题1, send: function, command: '切换主题.lua', option: "《《命令行》》【【主题名.trime】】"}#主题名称为自定义项,无后缀名yaml,默认主题命名为trime即可
  
向该主题方案任意键盘按键中加入上述按键既可
--------------------
用法二
①放到脚本启动器->脚本库目录 下任意位置及子文件夹足中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,点击按键即可

功能跳转

]]




require "import"
import "java.io.*"
import "android.content.*"

import "com.osfans.trime.*" --载入包

local 参数=(...)
local 输入法目录=tostring(service.getLuaExtDir(""))

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)

local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)


local 主题组1=Config.getThemeKeys(true)

local 主题组={}

--读取数组元素
for i=1,#主题组1 do
 主题组[i]=tostring(主题组1[i-1])
end
table.sort(主题组)--数组排序

local 文件组={}
local 主题名称组={}
--读取数组元素
for i=1,#主题组 do
 文件组[i]=主题组[i]:sub(1,-6)
 主题名称组[i]=主题组[i]:sub(1,-12)
 if 主题组[i]=="tongwenfeng.trime.yaml" then 主题名称组[i]="同文风" end
 if 主题组[i]=="trime.yaml" then 主题名称组[i]="默认" end
end




if 参数!=nil && string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 数据文件=string.sub(参数 ,string.find(参数,"【【")+6,string.find(参数,"】】")-1)
 local 路径=输入法目录.."/"..数据文件..".yaml"
 if File(路径).exists()==false then
   print(路径.." 主题文件不存在")
   return
 end
 
 local 主题=Config.get()
 主题.setTheme(tostring(数据文件)) 
 local 按键界面=Trime.getService()
 按键界面.initKeyboard()
 print("主题已刷新")
 return
end

--命令行模式,不显示选择界面
--local 命令行模式=false
if string.find(参数,"《《命令行》》")!=nil then
  return --退出
end



local 编号=1
local 短语数=10--单个键盘的短语数量
local 默认宽度=50

local 总序号=math.ceil(#文件组/短语数)

if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end



local 按键组={}

local 按键1={}
 按键1["width"]=100
 按键1["height"]=25
 按键1["click"]=""
 按键1["label"]=string.sub(纯脚本名,1,#纯脚本名-4).."("..tostring(编号).."/"..总序号..")"
 按键组[#按键组+1]=按键1



if 编号==1 then
 if #文件组<短语数 then
  --按键组=文件组
  for i=1,#文件组 do
   local 按键={}
   local 位置=i
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option= "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
   
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数-1-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  按键组[#按键组+1]=主键盘()
 else
  for i=1,短语数 do
   local 子编号=i
   if #文件组>子编号-1 then
    local 按键={}
    local 位置=i
    按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
    按键组[#按键组+1]=按键
   end--if
  end--for

 local 按键2={}
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键2
 按键组[#按键组+1]=主键盘()

 end--if #文件组<25
end--if 编号==1

if 编号>1 then
if #文件组<编号*短语数 then
  for i=1,#文件组-(编号-1)*短语数 do
  local 按键={}
  local 位置=i+(编号-1)*短语数
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键1={}
  按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键1
 
 按键组[#按键组+1]=主键盘()
else
  for i=1,短语数 do
   local 按键={}
   local 位置=i+(编号-1)*短语数
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
  end--for
  local 按键1={}
  按键1["width"]=33
 按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键1
 local 按键2={}
 按键2["width"]=33
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键2
 
 
 按键组[#按键组+1]=主键盘(32,33)

end--if #文件组>编号*22
end--if 编号>1 



service.setKeyboard{
  name=string.sub(纯脚本名,1,#纯脚本名-4),
  ascii_mode=0,
  width=默认宽度,
  height=32,
  keys=按键组
  }



