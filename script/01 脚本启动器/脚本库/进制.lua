require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "java.math.BigInteger"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.Color"
import "android.graphics.drawable.StateListDrawable"

function backgrounds(颜色,边框颜色,圆角,边框宽度)
  local gd = GradientDrawable()
  gd.setColor(Color.parseColor(颜色))
  gd.setCornerRadius(圆角)
  gd.setStroke(边框宽度, Color.parseColor(边框颜色))
  return gd
end

function sdraw(bn,bh)
  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bn)
  stb.addState({android.R.attr.state_pressed},bh)
  return stb
end
local height = "240dp"
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)
local buttfontsize = "15dp"
local buttfontcolor = "#ffffff"
local ids,layout = {},{
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  orientation="vertical",
  {
    LinearLayout,
    layout_width="fill",
    layout_height=height,
    orientation="vertical",
    background="#000000",
    {
      LinearLayout,
      layout_width="fill",
      layout_height="40dp",
      orientation="horizontal",
      background="#ffffff",
      {
        LinearLayout,
        layout_width="50%w",
        layout_height="fill",
        {
          Spinner,
          id="lspinn",
          layout_width="16%w",
          layout_height="fill",
          layout_margin="1dp",
          paddingLeft="2dp",
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
        {
          TextView,
          id="txt_from",
          layout_width="33%w",
          layout_height="fill",
          layout_margin="1dp",
          paddingLeft="1dp",
          paddingRight="1dp",
          gravity="center",
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
          textColor="#ffffff",
          textSize="10dp",
        },
      },
      {
        LinearLayout,
        layout_width="50%w",
        layout_height="fill",
        {
          TextView,
          id="txt_to",
          layout_width="33%w",
          layout_height="fill",
          layout_margin="1dp",
          paddingLeft="1dp",
          paddingRight="1dp",
          gravity="center",
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
          textColor="#ffffff",
          textSize="10dp",
        },
        {
          Spinner,
          id="rspinn",
          layout_width="16%w",
          layout_height="fill",
          layout_margin="1dp",
          paddingRight="2dp",
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },

      },
    },
    {
      LinearLayout,
      layout_width="fill",
      layout_height="fill",
      orientation="vertical",
      background="#ffffff",
      {
        LinearLayout,
        layout_width="fill",
        layout_height="0dp",
        layout_weight="1",
        {
          Button,
          id="but_a",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="A",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#FF545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_b",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="B",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_9",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="9",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_8",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="8",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_7",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="7",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_←",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="←",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      },
     {
        LinearLayout,
        layout_width="fill",
        layout_height="0dp",
        layout_weight="1",
        {
          Button,
          id="but_c",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="C",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_d",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="D",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_6",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="6",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_5",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="5",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_4",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="4",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_f40",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="清空",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#FFB20012","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      },
     {
        LinearLayout,
        layout_width="fill",
        layout_height="0dp",
        layout_weight="1",
        {
          Button,
          id="but_e",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="E",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_f",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="F",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          clickable=false,
          Background=sdraw(backgrounds("#545454","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_3",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="3",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_2",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="2",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_1",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="1",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      {
          Button,
          id="but_0",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="0",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#ec5f67","#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)),
        },
      },
     {
        LinearLayout,
        layout_width="fill",
        layout_height="0dp",
        layout_weight="1",
        {
          Button,
          id="but_f4",
          layout_width="0dp",
          layout_height="fill",
          layout_weight="1",
          layout_margin="1dp",
          text="返回",
          textSize=buttfontsize,
          textColor=buttfontcolor,
          Background=sdraw(backgrounds("#FF10C7F4","#ffffff",5,2),backgrounds("#ec5f67","#ffffff",5,2)),
        },
      },
    },
  },
}

layouts = loadlayout(layout,ids)

function setclick(ida,booll,color1)
ida.setClickable(booll)
ida.setBackground(sdraw(backgrounds(color1,"#ffffff",5,2),backgrounds("#00a2ff","#ffffff",5,2)))
end


function setAdap(idd)
  local txtview = {
    TextView,
    id="txtv",
    layout_width="fill",
    layout_height="35dp",
    padding="4dp",
    gravity="center",
    textSize="9dp",
    textColor="#ffffff",
    background="#aaec5f67",
  }
  local adap = LuaArrayAdapter(this,txtview)
  local hex = {"16进制","10进制","8进制","2进制"}
  for i,n in pairs(hex) do
    adap.add(n)
  end
  idd.setAdapter(adap)
end

setAdap(ids.lspinn)
ids.lspinn.setSelection(1)
local spinns = {}
local idd_tab = {ids.but_0,ids.but_1,ids.but_2,ids.but_3,ids.but_4,ids.but_5,ids.but_6,ids.but_7,ids.but_8,ids.but_9,ids.but_a,ids.but_b,ids.but_c,ids.but_d,ids.but_e,ids.but_f}

ids.lspinn.onItemSelected=function(l,v,p,i)
  spinns.ltxt = v.Text
if(spinns.ltxt == "16进制")
for i = 1,#idd_tab do
setclick(idd_tab[i],true,"#ec5f67")
end
elseif (spinns.ltxt == "10进制")

for i = 1,#idd_tab do
if (i <= 10)
setclick(idd_tab[i],true,"#ec5f67")
else
setclick(idd_tab[i],false,"#545454")
end
end

elseif (spinns.ltxt == "8进制")
for i = 1,#idd_tab do
if (i <= 8)
setclick(idd_tab[i],true,"#ec5f67")
else
setclick(idd_tab[i],false,"#545454")
end
end

elseif (spinns.ltxt == "2进制")

for i = 1,#idd_tab do
if (i <= 2)
setclick(idd_tab[i],true,"#ec5f67")
else
setclick(idd_tab[i],false,"#545454")
end
end

end
end
setAdap(ids.rspinn)
ids.rspinn.onItemSelected=function(l,v,p,i)
  spinns.rtxt = v.Text
end


function init_click()
--数字字母
for i = 1,#idd_tab do
idd_tab[i].onClick=function(v)
ids.txt_from.Text=ids.txt_from.Text..v.Text
end
end
--退格
ids.but_←.onClick=function(v)
local txts = ids.txt_from.Text
if(txts ~= nil and txts ~= "")
ids.txt_from.Text=utf8.sub(txts,0,utf8.len(txts)-1)
end
end
--清空
ids.but_f40.onClick=function()
  ids.txt_from.Text = ""
  ids.txt_to.Text = ""
end
--返回
ids.but_f4.onClick=function()
service.sendEvent("Keyboard_default")
end
end

init_click()

ids.txt_from.addTextChangedListener{
onTextChanged=function(all_str, i1, s1, r1)
local ltxt = spinns.ltxt
local rtxt = spinns.rtxt
if(all_str ~= nil and tostring(all_str) ~= "")

if(ltxt == "16进制" and rtxt == "10进制")
local str = BigInteger(tostring(all_str), 16).toString(10)
ids.txt_to.Text = str
elseif(ltxt == "16进制" and rtxt == "2进制")
local str = BigInteger(tostring(all_str), 16).toString(2)
ids.txt_to.Text = str
elseif(ltxt == "16进制" and rtxt == "8进制")
local str = BigInteger(tostring(all_str), 16).toString(8)
ids.txt_to.Text = str
elseif(ltxt == "16进制" and rtxt == "16进制")
ids.txt_to.Text = tostring(all_str)
elseif(ltxt == "10进制" and rtxt == "16进制")
local str = BigInteger(tostring(all_str), 10).toString(16)
ids.txt_to.Text = string.upper(str)
elseif(ltxt == "10进制" and rtxt == "10进制")
ids.txt_to.Text = tostring(all_str)
elseif(ltxt == "10进制" and rtxt == "8进制")
local str = BigInteger(tostring(all_str), 10).toString(8)
ids.txt_to.Text = str
elseif(ltxt == "10进制" and rtxt == "2进制")
local str = BigInteger(tostring(all_str), 10).toString(2)
ids.txt_to.Text = str
elseif(ltxt == "8进制" and rtxt == "16进制")
local str = BigInteger(tostring(all_str), 8).toString(16)
ids.txt_to.Text = string.upper(str)
elseif(ltxt == "8进制" and rtxt == "10进制")
local str = BigInteger(tostring(all_str), 8).toString(10)
ids.txt_to.Text = str
elseif(ltxt == "8进制" and rtxt == "8进制")
ids.txt_to.Text = tostring(all_str)
elseif(ltxt == "8进制" and rtxt == "2进制")
local str = BigInteger(tostring(all_str), 8).toString(2)
ids.txt_to.Text = str
elseif(ltxt == "2进制" and rtxt == "16进制")
local str = BigInteger(tostring(all_str), 2).toString(16)
ids.txt_to.Text = string.upper(str)
elseif(ltxt == "2进制" and rtxt == "10进制")
local str = BigInteger(tostring(all_str), 2).toString(10)
ids.txt_to.Text = str
elseif(ltxt == "2进制" and rtxt == "8进制")
local str = BigInteger(tostring(all_str), 2).toString(8)
ids.txt_to.Text = str
elseif(ltxt == "2进制" and rtxt == "2进制")
ids.txt_to.Text = tostring(all_str)
end

end
end}

ids.txt_to.onClick=function(v)
local ftxt = v.Text
if(ftxt ~= nil and ftxt ~= "")
service.commitText(ftxt)
end
end

service.setKeyboard(layouts)


