
require "import"
import "android.widget.*"
import "android.view.*"
import "android.media.MediaPlayer"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"
import "android.graphics.Typeface"
import "java.io.File"

import "android.os.*"
import "com.osfans.trime.*" --载入包
import "android.content.Context"
Key.presetKeys.LuaKey_phrase={send="function", command='剪切板.lua'}

参数=(...)
local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 目录=string.sub(脚本名,1,#脚本名-#纯脚本名)
local 通用脚本=目录.."通用脚本.addlua"
local 数据文件=string.sub(脚本名,1,#脚本名-4)..".txt"
local 文件= tostring(service.getLuaDir("")).."/phrase.json"
local 字体目录= tostring(service.getLuaExtDir("")).."/fonts"
local 字体,字体存在=字体目录.."/B2G.ttf",false
local vibeFont
if File(字体).exists() then
  vibeFont = Typeface.createFromFile(字体)
  字体存在=true
end


Key.presetKeys.LuaKey_add={send="function", command="add_phrase"}


local 键盘名=""
if 参数=="1" or 参数=="" or 参数==nil then
  键盘名="Keyboard_default" 
else
  键盘名="Keyboard_"..参数
end

local 文件=tostring(service.getLuaDir("")).."/clipboard.json"






local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
	local b=d.bounds
	b=RectF(b.left,b.top,b.right,b.bottom)
	p.setColor(0x49ffffff)
	c.drawRoundRect(b,20,20,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
	local b=d.bounds
	b=RectF(b.left,b.top,b.right,b.bottom)
	p.setColor(0x49d3d7da)
	c.drawRoundRect(b,20,20,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end

local function Icon(k,s) --获取功能键图标
  k=Key.presetKeys[k]
  return k and k.label or s
end

local function Bu_R(id) --生成功能键
  local ta={TextView,
	gravity=17,
	Background=Back(),
	layout_height=-1,
	layout_width=-1,
	layout_weight=1,
	layout_margin="1dp",
	layout_marginTop="2dp",
	layout_marginBottom="2dp",
	textColor=0xff232323,
	textSize="18dp"}

  if id==4 then
    ta.text=Icon(键盘名,"返回")
    ta.onClick=function()
      import "script.包.其它.主键盘"
      local 按键=主键盘()
      Key.presetKeys.lua_Keyboard=按键["click"]
      service.sendEvent("lua_Keyboard")
    end
    ta.OnLongClickListener={onLongClick=function()
        service.sendEvent("undo")
        return true
    end}
	ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==2 then
	ta.text=Icon("+","+")
	ta.textSize="29dp"
	ta.onClick=function()
	  service.sendEvent("LuaKey_add")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==3 then
	ta.text=Icon("⌫","￩")
	ta.textSize="29dp"
	ta.onClick=function()
	  service.sendEvent("BackSpace")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==1 then
	ta.text=Icon("⏍","⏍")
	ta.textSize="25dp"
	ta.onClick=function()
	  service.sendEvent("LuaKey_phrase")
	end
	ta.OnLongClickListener={onLongClick=function()
	  service.sendEvent("undo")
	  return true
	end}
  end
  return ta
end

local ids,layout={},{FrameLayout,
  --键盘高度
  layout_height=service.getLastKeyboardHeight(),
  layout_width=-1,
  --背景颜色，默认透明
  BackgroundColor=0x88ffffff,
  {ListView,
	id="list",
	layout_width=-1},
  {LinearLayout,
	orientation=1,
	--右侧功能键宽度
	layout_width="72dp",
	layout_height=-1,
	layout_gravity=5|84,
	Bu_R(1),
	Bu_R(2),
	Bu_R(3),
	Bu_R(4)}}
layout=loadlayout(layout,ids)

local data,item={},{LinearLayout,
  layout_width=-1,
  padding="4dp",

  gravity=3|17,
  {TextView,
	Typeface=vibeFont,
	id="a",
	textColor=0xff232323,
	textSize="15dp"},
  {TextView,
	Typeface=vibeFont,
	id="b",
	gravity=3|17,
	paddingLeft="4dp",
	--最大显示行数
	MaxLines=30,
	--最小高度
	MinHeight="30dp",
	textColor=0xff232323,
	textSize="15dp"}}
local adp=LuaAdapter(service,data,item)
ids.list.Adapter=adp

local Clip=service.getPhrase()
local function fresh()
  table.clear(data)
  for i=0,#Clip-1 do
	local v=Clip[i]
	local a,b,c=v:match("^(.*)(\n*.*)(\n*.*)")
	a=table.concat{utf8.sub(a,1,9900),utf8.sub(b,1,9900),utf8.sub(c,1,9900)}
	table.insert(data,{a=tostring(i+1)..".",b=a})
  end
  adp.notifyDataSetChanged()
end
fresh()

ids.list.onItemClick=function(l,v,p)
  local s=Clip[p]
  service.commitText(s)
  --置顶已上屏内容
  --[[
  if p>0 then
	Clip.remove(p)
	Clip.add(0,s)
	fresh()
  end
  --]]
end

ids.list.onItemLongClick=function(l,v,p)
  local str=Clip[p]
  pop=PopupMenu(service,v)
  menu=pop.Menu
  menu.add("复制").onMenuItemClick=function(ae)
	service.getSystemService(Context.CLIPBOARD_SERVICE).setText(str)





  end
  menu.add("删除").onMenuItemClick=function(ae)
	pop=PopupMenu(service,v)
	menu=pop.Menu
	menu.add("删除:"..str.."").onMenuItemClick=function(ae)
	  Clip.remove(p)
	  fresh()
	end
	pop.show()
  end
  menu.add("置顶").onMenuItemClick=function(ae)
	if p>0 then
	  Clip.remove(p)
	  Clip.add(0,str)
	  fresh()
	end
  end--[[
  menu.add("清空").onMenuItemClick=function(ae)
	pop=PopupMenu(service,v)
	menu=pop.Menu
	menu.add("确认清空 短语").onMenuItemClick=function(ae)
	  pop=PopupMenu(service,v)
	  menu=pop.Menu
	  menu.add("请再次确认").onMenuItemClick=function(ae)
		io.open(文件,"w"):write("[\n]"):close()
		task(300,function()  end)
		local 输入法实例=Trime.getService()
		输入法实例.loadPhrase()
		print("短语 已清空✔")
		功能_返回()
	  end
	  pop.show()
	end
	pop.show()
  end]]
  pop.show()

  return true
end

service.setKeyboard(layout)

--视频路径
local path=service.LuaDir.."/sounds/mv.mp4"

pcall(function()
  local play=MediaPlayer()
  play.setDataSource(path)
  play.prepare()
  --音量
  --play.setVolume(0,0)
  play.setLooping(true)
  local video=loadlayout{SurfaceView,
	--添加背景色，避免看不清按键
	BackgroundColor=0x99ffffff,
	layout_width=-1,
	layout_height=-1}
  layout.addView(video,0)
  video.getHolder().addCallback({
	surfaceCreated=function(holder)
	  play.setDisplay(holder)
	  play.start()
	end,
	surfaceDestroyed=function()
	  play.pause()
  end})
end)
