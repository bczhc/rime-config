require "import"
import "cjson"
import "android.widget.*"
import "java.io.File"
import "android.content.Context" 
import "android.view.*"
import "java.io.*"
import "android.content.*"
import "com.osfans.trime.*" --载入包


local 真=true
local 假=false
local 执行否=假
--当前候选处理
function updateComposing(i,c,t)
--[[if t== nil or t=="" then
do return end --强制退出
end]]

--防止执行两次
if 执行否 then
 执行否=假
else
 执行否=真
end

if i=="sj" && 执行否 
or i=="rq" && 执行否 then
Key.presetKeys.lua_window={label= "脚本", send="function", command="01 脚本启动器/脚本库/8 其它/时间信息.lua", option="%1$s"}
service.sendEvent("lua_window")
end

if i=="/xku" && 执行否 then
local 数据文件=tostring(service.getLuaDir("")).."/xklb__user.dict.yaml"--用户码表
service.editFile(数据文件) 
end
if i=="/xkz" && 执行否 then
local 数据文件=tostring(service.getLuaDir("")).."/xklb.dict.yaml"--主码表
service.editFile(数据文件) 
end
if i=="/xkd" && 执行否 then
local 数据文件=tostring(service.getLuaDir("")).."/xklb_dz.dict.yaml"--单字码表
service.editFile(数据文件) 
end

if i=="tq" && 执行否 then
Key.presetKeys.lua_window={label= "脚本", send="function", command="01 脚本启动器/脚本库/5 在线内容/天气.lua", option="《《命令行》》【【郑州】】"}
service.sendEvent("lua_window")
end

if i == "/ww"  && 执行否 then 
  Toast.makeText(service,"打开〔微信〕",2000).show()
  service.sendEvent("WeChat")
  i=""
end


if i == "/qj" && 执行否 then
  service.sendEvent("BackSpace")
  service.sendEvent("BackSpace")
  service.sendEvent("BackSpace")
  Toast.makeText(service,"执行 〔全选并剪切〕 命令",2000).show()
  service.sendEvent("select_all")
  service.sendEvent("cut")
end



  有网络=true
  local 有道启动码="e"
  local 其它编码=string.sub(i,#有道启动码+1)
  首字符="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  字符="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  if string.sub(i,1,#有道启动码)==有道启动码  && #i>#有道启动码 && string.find(首字符,string.sub(其它编码,1,1))>0 && 执行否 then
    geting=true
    local 其它编码=string.gsub(其它编码,"//"," ")
    local 其它编码=string.gsub(其它编码,"/"," ")
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i="..其它编码
    Http.get(云输入内容0,function(c,t)
    local s1 = string.find(t,"tgt\":\"",1, true)+6
    local s2 = string.find(t,"}]]}")-2
    local 候选=string.sub(t,s1,s2)
    service.addCompositions({其它编码,候选})
    geting=false
    end)
  end

  候选后缀="英语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 && 执行否 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
   geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end

--翻译法语
  候选后缀="法语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 && 执行否 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
    geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=ZH_CN2FR&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end

--翻译日语
  候选后缀="日语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 && 执行否 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
    geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=ZH_CN2JA&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end

--分享文字到微信
候选后缀="微信"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 && 执行否 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
  微信分享(实际内容)
  end
function 微信分享(内容)
text=内容
intent=Intent(Intent.ACTION_SEND); 
intent.setType("text/plain"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
intent.putExtra(Intent.EXTRA_TEXT, text); 
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
componentName =ComponentName("com.tencent.mm","com.tencent.mm.ui.tools.ShareImgUI");
intent.setComponent(componentName)

service.startActivity(Intent.createChooser(intent,"分享到:")); 
end


if t=="考研" && 执行否 then 
   local 提醒内容="考研时间为 2020-12-26 \n还有 "..倒计时("2020-12-26").."天 加油👍👍👍"
   service.addCompositions({提醒内容})
  end
function 倒计时(结束日期)
 local strDate1 =  tostring(os.date("%Y-%m-%d"))
 local _, _, y, m, d, _hour, _min, _sec = string.find(strDate1, "(%d+)-(%d+)-(%d+)");
 --转化为时间戳
 local s1 = os.time({year=y, month = m, day = d});
 
  local strDate2 = 结束日期
  local _, _, y, m, d, _hour, _min, _sec = string.find(strDate2, "(%d+)-(%d+)-(%d+)");
  --转化为时间戳
  local s2 = os.time({year=y, month = m, day = d});
  local s = os.difftime(s2, s1)
  local t_time=tostring((s/(60*60*24))-1)
 return string.sub(t_time,1,#t_time-2)
end

end


