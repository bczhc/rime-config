require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.*"
import "android.graphics.drawable.*"
import "script/dex/color:com.a4455jkjh.colorpicker.view.ColorPickerView"
import "android.util.TypedValue"

--必须要给悬浮窗权限

function dp2px(context,dpValue)
  return tointeger(TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,dpValue,context.getResources().getDisplayMetrics()))
end


local 初始颜色 = 0xff000000

function alpback()
local bai=Paint()
bai.setColor(0xffffffff)
bai.setStrokeWidth(1)

local hui=Paint()
hui.setColor(0xFFACACAC)
hui.setStrokeWidth(1)

local abg = LuaDrawable(function(c,p,d)
    if (c ~= nil) then
      local w = d.getBounds().width()/10
      local h = d.getBounds().height()/10
      heng = {0,w+w,w+w,w+w,w+w}
      shu = {0,h+h,h+h,h+h,h+h}

      c.translate(0,0)
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end
      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(w,-(h*9))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,hui)
      end

      c.translate(0,-(h*7))
      for i2 = 1,#shu do
        c.translate(0,shu[i2])
        c.drawRect(0,0,w,h,bai)
      end
    end
    
  end)
return abg
end





function setback()
  local colors2 = { 0xffec5f67 , 0xFF50B3FF, 0xFFD2EC5F,0xffec5f67 }
  local gd2 = GradientDrawable(GradientDrawable.Orientation.TR_BL, colors2)
  --gd.setColor(0xffffffff)--填充
  gd2.setGradientType(2)--渐变模式,0,1,2
  gd2.setCornerRadius(8)--圆角
  gd2.setStroke(4, 0xffffffff,100,10)--边框宽，边框颜色，边框虚线宽，虚线间距
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  return gd2
end

local height = "240dp"
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)

local ids,layout1={},{
  LinearLayout,
  layout_width="fill",
--  orientation="vertical",
  layout_height=height,
  background=setback(),

  {
    ColorPickerView,
    id="color_view",
    layout_width="70%w",
    layout_height="wrap",
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    orientation="vertical",
    background="#ffffffff",
    {
      LinearLayout,
      layout_width="fill",
      layout_height="0dp",
      layout_weight="1",
      background="#ffffff",
      {
        LinearLayout,
        layout_width="fill",
        layout_height="fill",
        layout_margin="2dp",
        Background=alpback(),
        {
        View,
        id="color_img",
        layout_width="fill",
        layout_height="fill",
        background="#ff00a2ff",
      },
      },
    },
    {
      LinearLayout,
      layout_width="fill",
      layout_height="0dp",
      layout_weight="1",
      background="#ffffff",
      {
        TextView,
        id="color_hex",
        layout_width="fill",
        layout_height="fill",
        layout_margin="2dp",
        background="#ec5f67",
        gravity="center",
        text="#FF000000",
        textColor="#ffffff",
        textSize="17dp",
      },
    },
     {
      Button,
      id="f4",
      layout_width="fill",
      layout_height="0dp",
      layout_weight="1",
      layout_margin="2dp",
      text="返回",
    },
  },
}

layy = loadlayout(layout1,ids)

  ids.color_view.setColor(初始颜色)
  
  ids.color_img.setBackgroundColor(初始颜色)
  
  ids.color_view.setOnColorChangedListener{
    onColorChanged=function(n)
      ids.color_img.setBackgroundColor(n)
      local a = string.format("%02x",Color.alpha(n))
      local r = string.format("%02x",Color.red(n))
      local g = string.format("%02x",Color.green(n))
      local b = string.format("%02x",Color.blue(n))
      ids.color_hex.Text = "#"..string.upper(a..r..g..b)
    end
  }

ids.color_hex.onClick = function(v)
  service.commitText(v.Text)
  --service.sendEvent("Keyboard_default")
end

ids.f4.onClick = function(v)
  service.sendEvent("Keyboard_default")
end

service.setKeyboard(layy)







