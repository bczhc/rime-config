--[[
--无障碍版专用脚本
--用途：快捷加词
--如何使用: 请参考群文件：同文无障碍版lua脚本使用说明.pdf
--配置说明
第①步 将 快捷加词.lua 文件放置 rime/script 文件夹内
第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例

preset_keys:
  yjjc_lua: {label: 快捷加词, send: function, command: '加词自动编码【定长】.lua', option: "《《命令行》》【【词库名.txt】】【【单字码表名】】【【1】】"}#加词模式 1为弹出输入框，2为在第三方输入框添加，词库名称和单字码表名为自定义项，可以不是单字表，但是建议使用单字表，(PS：码表文件太大会卡死
  yjjc_lua2: {label: 快捷加词, send: function, command: '加词自动编码【定长】.lua', option: "《《命令行》》【【词库名.txt】】【【单字码表名】】【【2】】"}#加词模式 1为弹出输入框，2为在第三方输入框添加，词库名称和单字码表名为自定义项，可以不是单字表，但是建议使用单字表，(PS：码表文件太大会卡死
向任意按键加入上述按键既可

或者在脚本启动器运行，这个时候就需要修改本文件的，40、41、42行
]]
require "import"
import "android.widget.*"
import "android.view.*"
import "android.widget.EditText"
import "android.widget.Toast"
import "android.widget.GridView"
import "android.widget.CardView"
import "android.widget.FrameLayout"
import "android.widget.Button"
import "android.view.Gravity"
import "android.graphics.RectF"
import "java.io.File"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "android.content.Context"
import "android.widget.ListView"
import "android.graphics.drawable.StateListDrawable"
import "com.androlua.LuaDialog"
import "android.graphics.drawable.Icon"
import "com.androlua.LuaAdapter"
import "com.androlua.LuaDrawable"
import "android.widget.PopupWindow"

local 加词模式="1" --加词模式 1为弹出输入框，二为在第三方输入框添加
local 词库文件名="SapphirePro_yhc.txt"
local 单字码表名="SapphirePro_danzi.txt"--单字码表，可以不是单字表，但是建议使用单字表，(PS：码表文件太大会卡死
local 版本号=""
local 参数=(...)
local 输入法目录=tostring(service.getLuaExtDir(""))
local 脚本目录=输入法目录.."/script"
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)
if 参数!=nil && string.find(参数,"《《命令行》》")!=nil then
  词库文件名 = 参数:match("》》【【(.-)】】【【")
  单字码表名 = 参数:match("】】【【(.-)】】【【")
  加词模式= 参数:match("】】【【.-】】【【(.-)】】$")
end
local 词库文件路径=输入法目录.."/"..词库文件名
local 单字码表路径=输入法目录.."/"..单字码表名
local function 数组去重复(数组)
  local exist = {}
  --把相同的元素覆盖掉
  for v, k in pairs(数组) do
    exist[k] = true
  end
  --重新排序表
  local newTable = {}
  for v, k in pairs(exist) do
    table.insert(newTable, v)
  end
  return newTable
end
local function 获取编码(词条)
  local 词组=""
  local 单字码表内容=io.open(单字码表路径):read("*a")
  for i=1,#词条 do
    if utf8.find(单字码表内容,"\n"..utf8.sub(词条,i,i).."\t")~= nil then
      词组=词组..utf8.sub(词条,i,i)
    end
  end
  local n=utf8.len(词组)
  local 编码组={}
  local a={}
  local b={}
  local q={}
  local f={}
  local e={}
  local i=1
  local k=1
  local d=1
  local p=1
  local m=1
  if n==2 then
    for c in io.lines(单字码表路径) do
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,1,1) then
        a[i]=utf8.match(c,"\t([a-z][a-z])")
        i=i+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,2,2)then
        b[k]=utf8.match(c,"\t([a-z][a-z])")
        k=k+1
      end
    end
    for i =1,#a do
      for n =1,#b do
        e[m]=a[i]..b[n]
        m=m+1
      end
    end
    for i=1,#e do
      编码组[i]=e[i]
    end
   elseif n==3 then
    for c in io.lines(单字码表路径) do
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,1,1) then
        a[i]=string.match(c,"\t([a-z][a-z])")
        i=i+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,2,2) then
        b[k]=string.match(c,"\t([a-z][a-z])")
        k=k+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,3,3) then
        q[d]=string.match(c,"\t([a-z][a-z])")
        d=d+1
      end
    end
    for i =1,#a do
      for n =1,#b do
        for t =1,#q do
          e[m]=a[i]..b[n]..q[t]
          m=m+1
        end
      end
    end
    for i=1,#e do
      编码组[i]=string.sub(e[i],1,1)..string.sub(e[i],3,3)..string.sub(e[i],5,5)
      编码组[#e+i]=string.sub(e[i],1,1)..string.sub(e[i],3,3)..string.sub(e[i],5,6)
    end
   elseif n>=4 then
    for c in io.lines(单字码表路径) do
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,1,1) then
        a[i]=string.match(c,"\t([a-z][a-z])")
        i=i+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,2,2) then
        b[k]=string.match(c,"\t(..)")
        k=k+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,3,3) then
        q[d]=string.match(c,"\t(..)")
        d=d+1
      end
      if utf8.match(c,"(.-)\t.*")== utf8.sub(词组,-1,-1) then
        f[p]=string.match(c,"\t([a-z][a-z])")
        p=p+1
      end
    end
    for i =1,#a do
      for n =1,#b do
        for t =1,#q do
          for s =1,#f do
            e[m]=a[i]..b[n]..q[t]..f[s]
            m=m+1
          end
        end
      end
    end
    for i=1,#e do
      编码组[i]=string.sub(e[i],1,1)..string.sub(e[i],3,3)..string.sub(e[i],5,5)..string.sub(e[i],7,7)
    end
  end --if n>=4 then
  编码组=数组去重复(编码组)
  return 编码组
end
local function 刷新方案()
  if Rime.select_schema(Rime.getSchemaId().."")==false print("方案刷新失败") end
end
local function 写入词库(字符串,词库文件)
  io.open(词库文件,"a+"):write("\n"..字符串):close()
  Toast.makeText(service," 词组【"..字符串.."】 添加成功",2000).show()
  刷新方案()
end
local function 加词位置按照字母表顺序(路径,词条,编码)
  local d={}
  for c in io.lines(路径) do
    if c:find("	")~=nil then
      d[#d+1]=c:match("	(.+)")
    end
  end
  d[#d+1]=编码
  table.sort(d)
  for i=1, #d do
    if d[i]==编码 then
      内容=io.open(路径):read("*a")
      io.open(路径,"w+"):write(tostring(内容:gsub("\t"..d[i-1],"\t"..d[i-1].."\n"..词条.."\t"..编码))):close()
    end
  end
  刷新方案()
end
local function 一键加词重码选择函数(项目组)
  local ids={}
  local data={}
  local item={LinearLayout,
    layout_width=-1,
    layout_height="30dp",
    padding="2dp",
    orientation="vertical",
    gravity=17,
    {CardView,
      radius="5dp",
      layout_height="36dp",
      CardElevation=0,
      layout_width=-1,
      BackgroundColor=0x49d3d7da,
      --gravity=3|17,
      {LinearLayout,
        layout_width=-1,
        --BackgroundColor=0x49d3d7da,
        --gravity=3|17,
        {TextView,
          id="b",
          textColor=0xffAA7700,
          textSize="14dp"},
        {TextView,
          id="a",
          padding="8dp",
          --gravity=17,
          layout_width=-1,
          gravity="center",
          --BackgroundColor=0x49d3d7da,
          textColor=0xff232323,
          textSize="14dp"}
      }
    }
  }
  local layout=
  {LinearLayout,
    gravity="right",
    layout_height=-1,
    {LinearLayout,
      id="main",
      orientation=1,
      --右侧功能键宽度
      layout_weight=1,
      layout_height=-1,
      layout_gravity=8|3,
      {GridView, --列表控件
        id="list",
        numColumns=1, --6列
        paddingLeft="2dp",
        paddingRight="2dp",
        layout_width=-1,
        layout_weight=1}},
  }
  local adp=LuaAdapter(service,data,item)
  local function fresh(t)
    table.clear(data)
    for i=1,#t do
      local v=t[i]
      local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
      a=table.concat{utf8.sub(a or "",1,99),utf8.sub(b or "",1,99),utf8.sub(c or "",1,99)}
      table.insert(data,{b=tostring(i),a=a})
    end
    adp.notifyDataSetChanged()
  end
  弹出布局=loadlayout(layout,ids)
  ids.list.Adapter=adp
  fresh(项目组)
  local height=service.getLastKeyboardHeight()
  local width=service.getWidth()--取键盘宽度
  local 宽度,高度=width*0.35,height*0.38
  local popWnd = PopupWindow(this);
  popWnd.setContentView(弹出布局);
  popWnd.setWidth(宽度) --设置显示宽度
  popWnd.setHeight(高度) --设置显示高度
  --popWnd.setFocusable(false);设置焦点
  popWnd.setOutsideTouchable(true)--点击外面区域消失
  --相对某个控件的位置（正左下方），无偏移
  --popWnd.showAsDropDown(v)
  --相对某个控件的位置，有偏移;xoff表示x轴的偏移，正值表示向左，负值表示向右；yoff表示相对y轴的偏移，正值是向下，负值是向上；
  --popWnd.showAsDropDown(View anchor, int xoff, int yoff)
  --相对于父控件的位置（例如正中央Gravity.CENTER，下方Gravity.BOTTOM,Gravity.TOP,Gravity.RIGHT等），可以设置偏移或无偏移
  local v=service.getCandidateView()
  popWnd.showAtLocation(v,Gravity.TOP, 0, 0)
  ids.list.onItemClick=function(l,v,p)
    popWnd.dismiss()
    写入词库(项目组[p+1],词库文件路径)
  end
  ids.list.onItemLongClick=function(l,v,p)
    print(项目组[p+1])
    return true
  end
end
local function 快捷加词重码选择模块(项目组)
  local ids={}
  local data={}
  local item={LinearLayout,
    layout_width=-1,
    layout_height="30dp",
    padding="2dp",
    orientation="vertical",
    gravity=17,
    {CardView,
      radius="5dp",
      layout_height="36dp",
      CardElevation=0,
      layout_width=-1,
      BackgroundColor=0x49d3d7da,
      --gravity=3|17,
      {LinearLayout,
        layout_width=-1,
        --BackgroundColor=0x49d3d7da,
        --gravity=3|17,
        {TextView,
          id="b",
          textColor=0xffAA7700,
          textSize="14dp"},
        {TextView,
          id="a",
          padding="8dp",
          --gravity=17,
          layout_width=-1,
          gravity="center",
          --BackgroundColor=0x49d3d7da,
          textColor=0xff232323,
          textSize="14dp"}}}}
  local adp=LuaAdapter(service,data,item)
  local function fresh(t)
    table.clear(data)
    for i=1,#t do
      local v=t[i]
      local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
      a=table.concat{utf8.sub(a or "",1,99),utf8.sub(b or "",1,99),utf8.sub(c or "",1,99)}
      table.insert(data,{b=tostring(i),a=a})
    end
    adp.notifyDataSetChanged()
  end
  local function Back() --生成功能键背景
    local bka=LuaDrawable(function(c,p,d)
      local b=d.bounds
      b=RectF(b.left,b.top,b.right,b.bottom)
      p.setColor(0xffffffff)
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
  local function Icon(k,s) --获取k功能图标，没有返回s
    k=Key.presetKeys[k]
    return k and k.label or s
  end
  local function Bu_R(id) --生成功能键
    local Bu={LinearLayout,
      layout_height=-1,
      layout_width=-1,
      layout_weight=1,
      padding="2dp",
      {FrameLayout,
        layout_height=-1,
        layout_width=-1,
        Background=Back(),
        {TextView,
          gravity=17|48,
          layout_height=-1,
          layout_width=-1,
          layout_marginTop="2dp",
          textColor=0xff232323,
          textSize="10dp"},
        {TextView,
          gravity=17,
          layout_height=-1,
          layout_width=-1,
          textColor=0xff232323,
          textSize="18dp"}}}
    local msg=Bu[2][2] --上标签
    local label=Bu[2][3] --主标签
    if id==1 then
      label.text=Icon("关闭","关闭")
      Bu.onClick=function()
        dialog.dismiss()
      end
    end
    return Bu
  end
  local layout={LinearLayout,
    orientation=1,
    --键盘高度
    layout_width=-1,
    --背景颜色
    --BackgroundColor=0xffd7dddd,
    {TextView,
      id="title",
      layout_height="30dp",
      layout_width=-1,
      text="",
      gravity="center",
      paddingLeft="2dp",
      paddingRight="2dp",
      BackgroundColor=0x49d3d7da
    },
    {LinearLayout,
      gravity="right",
      layout_height=-1,
      {LinearLayout,
        id="main",
        orientation=1,
        --右侧功能键宽度
        layout_weight=1,
        layout_height=-1,
        layout_gravity=8|3,
        {GridView, --列表控件
          id="list",
          numColumns=1, --6列
          paddingLeft="2dp",
          paddingRight="2dp",
          layout_width=-1,
          layout_weight=1}},
      {LinearLayout,
        orientation=1,
        layout_weight=1,
        layout_width="100dp",
        layout_height=-1,
        --layout_gravity=5|84,
        Bu_R(1),
      },
  }}
  layout=loadlayout(layout,ids)
  ids.list.Adapter=adp
  fresh(项目组)
  local 标题="重码选择模块1.0"
  ids.title.setText(标题)
  ids.list.onItemClick=function(l,v,p)
    写入词库(项目组[p+1],词库文件路径)
    dialog.dismiss()
    print()
  end
  ids.list.onItemLongClick=function(l,v,p)
    print(项目组[p+1])
    return true
  end
  local Bus={LinearLayout,
    paddingLeft="2dp",
    layout_width=-1}
  ids.main.addView(loadlayout(Bus))
  local dl=LuaDialog(service)
  .setView(layout)
  dl.show()
  dialog=dl.show()
end
layout={
  LinearLayout,
  orientation="vertical",
  {
    LinearLayout,
    layout_width="fill",
    orientation="horizontal",
    layout_height="145",
    gravity="center",
    {
      Button,
      id="citiao",
      text="词条 ：",
      layout_weight="1",
    },
    {
      EditText,
      id="edit",
      layout_weight="20",
      Hint="请在此处输入词条",
      singleLine=true, --设置单行输入
    }
  },
  {
    LinearLayout,
    layout_width="fill",
    orientation="horizontal",
    layout_height="145",
    gravity="center",
    {
      Button,
      id="bianma",
      text="编码 ：",
      layout_weight="1",
    },
    {
      EditText,
      id="edit2",
      layout_weight="20",
      Hint="请在此处输入编码",
      singleLine=true, --设置单行输入
    }
  },
  {
    LinearLayout,
    layout_width="fill",
    orientation="horizontal",
    layout_height="145",
    gravity="center",
    {
      Button,
      id="quxiao",
      text="取消",
      layout_weight="1",
    },
    {
      Button,
      id="shengcheng",
      text="生成",
      layout_weight="1",
    },
    {
      Button,
      id="queding",
      text="确定",
      layout_weight="1",
    }
  }
}
if 加词模式=="1" then
  local ids,layout2={},{LinearLayout,
    --键盘高度
    layout_height=service.getLastKeyboardHeight(),
    layout_width=-1,
    --背景颜色，默认透明
    BackgroundColor=0x88ffffff,
    {ListView,
      id="list",
      layout_width=-1}}
  layout2=loadlayout(layout2,ids)
  local data,item={},{LinearLayout,
    layout_width=-1,
    padding="4dp",
    gravity=3|17,
    {TextView,
      id="a",
      textColor=0xff232323,
      textSize="15dp"},
    {TextView,
      id="b",
      gravity=3|17,
      paddingLeft="4dp",
      --最大显示行数
      MaxLines=3,
      --最小高度
      MinHeight="30dp",
      textColor=0xff232323,
      textSize="25dp"}}
  local adp=LuaAdapter(service,data,item)
  ids.list.Adapter=adp
  local dl=LuaDialog(service)
  .setTitle(纯脚本名:sub(1,-5)..版本号)
  .setView(loadlayout(layout))
  dl.show()
  dialog=dl.show()
  local function 获取词条和编码()
    local 词条=""
    if service.getClipBoard().toString() ~="[]" then
      词条=service.getClipBoard()[0] --读取剪切板数组"从0开始"
      edit.setHint(service.getClipBoard()[0])
    end
    if edit.getText().toString()~="" then
      词条= edit.getText().toString()
    end
    local 编码=""
    local 编码组0=获取编码(词条)
    if #获取编码(词条)==1 then
      edit2.setText(编码组0[1])
      编码=编码组0[1]
     elseif #获取编码(词条)>1 then
      local 词条编码组={}
      for i =1,#编码组0 do
        词条编码组[i]=词条.."\t"..编码组0[i]
      end
      快捷加词重码选择模块(词条编码组)
    end
  end
  --自动编码提示
  获取词条和编码()
  shengcheng.onClick=function()
    获取词条和编码()
    return true
  end
  queding.onClick=function()
    local 词条=edit.getText().toString()
    local 编码=edit2.getText().toString()
    if 编码=="" or 编码==nil then
      获取词条和编码()
      编码=edit2.getText().toString()
    end
    if 词条==nil or 词条=="" then
      词条=service.getClipBoard()[0] --读取剪切板数组"从0开始"
    end
    local 词条和编码=词条.."\t"..编码
    if 词条和编码~="	" and 词条~=nil and 编码~=nil then
      写入词库(词条和编码,词库文件路径)
    end
    dialog.dismiss()
  end
  citiao.onClick=function()
    edit.setText(service.getClipBoard()[0])
  end
  quxiao.onClick=function()
    print("取消")
    dialog.dismiss()
  end
  --自动弹出输入法
  task(100,function()
    --让页面上的某个控件获得焦点，比如edit,则可以通过如下代码实现：
    edit.setFocusable(true);
    edit.setFocusableInTouchMode(true);
    edit.requestFocus();
    local imm = service.getSystemService(Context.INPUT_METHOD_SERVICE)
    imm.showSoftInput(edit, 0)
  end)--间隔时间间
 elseif 加词模式=="2" then
  service.sendEvent({send= "Control+a"})--全选
  --取编辑框选中内容,部分app内无效
  local 选中内容=service.getCurrentInputConnection()
  if 选中内容!=nil then
    选中内容=选中内容.getSelectedText(0)
  end
  if 选中内容==nil then
    import "android.content.Context" --导入类
    选中内容=service.getSystemService(Context.CLIPBOARD_SERVICE).getText() --获取剪贴板
  end
  local 新增词组内容=选中内容
  if 新增词组内容== nil or 新增词组内容=="" then
    do return end --强制退出
  end
  local 编码组=获取编码(新增词组内容)
  if #编码组==1 then
    写入词库(新增词组内容.."\t"..编码组[1],词库文件路径)
   elseif #编码组>1 then
    print("有重码")
    local 词条编码组={}
    for i =1,#编码组 do
      词条编码组[i]=新增词组内容.."\t"..编码组[i]
    end
    一键加词重码选择函数(词条编码组)
  end--if#编码组
end