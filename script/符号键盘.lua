require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"
import "android.os.*"
import "com.osfans.trime.*" --载入包

local Emoji={ --存放表情的table
  --{按键名,符号table 或 文本}
  {"123",[[+123()-456[]*789{}/,0.@=øØπ°′″＄￥〒￠￡％＠℃℉﹩﹪‰﹫㎡㎥㏕ml㎜㎝㎞㏎m³㎎㎏㏄mol㏒㏑º○¤%$º¹²³⁴ⁿ₁₂₃₄€£Ұ₴$₰¢₤¥₳₲₪₵元₣₱฿¤₡₮₭₩ރ円₢₥₫₦zł﷼₠₧₯₨Kčर₹ƒ₸￠]]}, --[[长文本，可换行]]
  {"表情",[[🥶🤬🤢🥵😋🤐🤮😏🤗😶😁🤔😴🤓😝☺😪😨😳😀😁😂😃😄😅😆😉😊😋😎😍😘😗😙😚☺😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡😠👦👧👨👩👴👵👶👱👮👲👳👷👸💂🎅👰👼💆💇🙍🙎🙅🙆💁🙋🙇🙌🙏👤👥🚶🏃👯💃👫👬👭💏💑👪💪👈👉☝👆👇✌✋👌👍👎✊👊👋👏👐🖕🖖🤟🤞💩👻👿💋🌂👠✍👣👀👂👃👅👄💋👓👔👕👖👗👘👙👚👛👜👝🎒💼👞👟👠👡👢👑👒🎩🎓💄💅💍🌂📱📲📶📳📴☎📞📟📠♻🏧🚮🚰♿🚹🚺🚻🚼🚾⚠🚸⛔🚫🚳🚭🚯🚱🚷🔞💈😈👿👹👺💀☠👻👽👾💣🐁🐂🐅🐇🐉🐍🐎🐐🐒🐓🐕🐖🦠🦟🦅🐜🕸🐞🦀🐶🦊🐙🐦🐤🦅🐝🐛🦖🦐🐠🐟🦛🐘🐾🐷🐽🐸🦇🦞🙈🙉🙊🐵🐒🐶🐕🐩🐺🐱😺😸😹😻😼😽🙀😿😾🐈🐯🐅🐆🐴🐎🐮🐂🐃🐄🐷🐖🐗🐽🐏🐑🐐🐪🐫🐘🐭🐁🐀🐹🐰🐇🐻🐨🐼🐾🐔🐓🦆🦢🕊🦜🦉🐣🐤🐥🐦🐧🐸🐊🐢🐍🐲🐉🐳🐋🐬🐟🐠🐡🐙🐚🐌🐛🐜🐝🐞🦋💐🌸💮🌹🌺🌻🌼🌷🌱🌲🌳🌴🌵🌾🌿🍀🍁🍂🍃🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜☀🌝🌞⭐🌟🌠☁⛅☔⚡❄🔥💧🌊🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍅🍆🌽🍄🌰🍞🍖🍗🍔🍟🍕🍳🍲🍱🍘🍙🍚🍛🍜🍝🍠🍢🍣🍤🍥🍡🍦🍧🍨🍩🍪🎂🍰🍫🍬🍭🍮🍯🍼☕🍵🍶🍷🍸🍹🍺🍻🍴🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪🏫🏬🏭🏯🏰💒🗼🗽⛪🌆🌇🌉🚂🚃🚄🚅🚆🚇🚈🚉🚊🚝🚞🚋🚌🚍🚎🚏🚐🚑🚒🚓🚔🚕🚖🚗🚘🚚🚛🚜🚲⛽🚨🚥🚦🚧⚓⛵🚣🚤🚢✈💺🚁🚟🚠🚡🚀🌋🗻🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪🏫🏬🏭🏯🏰💒🗼🗽⛪⛲🌁🌃🌆🌇🌉🌌🎠🎡🎢🚂🚃🚄🚅🚆🚇🚈🚉🚊🚝🚞🚋🚌🚍🚎🚏🚐🚑🚒🚓🚔🚕🚖🚗🚘🚚🚛🚜🚲⛽🚨🚥🚦🚧⚓⛵🚤🚢✈💺🚁🚟🚠🚡🚀🎑🗿🛂🛃🛄🛅💌💎🔪💈🚪🚽🚿🛁⌛⏳⌚⏰🎈🎉🎊🎎🎏🎐🎀🎁📯📻📱📲☎📞📟📠🔋🔌💻💽💾💿📀🎥📺📷📹📼🔍🔎🔬🔭📡💡🔦🏮📔📕📖📗📘📙📚📓📃📜📄📰📑🔖💰💴💵💶💷💸💳✉📧📨📩📤📥📦📫📪📬📭📮✏✒📝📁📂📅📆📇📈📉📊📋📌📍📎📏📐✂🔒🔓🔏🔐🔑🔨🔫🔧🔩🔗💉💊🚬🔮🚩🎌💦💨📱📲☎📞📟📠🔋🔌💻💽💾💿📀🎥📺📷📹📼🔍🔎🔬🔭📡📔📕📖📗📘📙📚📓📃📜📄📰📑🔖💳✉📧📨📩📤📥📦📫📪📬📭📮✏✒📝📁📂📅📆📇📈📉📊📋📌📍📎📏📐✂🔒🔓🔏🔐🔑]]},
  {"中文",{"，","。","？","！","：","、","@","……","“”","；","‘’","——","（）","《》","〈〉","〔〕","［］","【】","*","&","+","-","×","÷","=","#","￥","%","ˇ","·","•","～"}},
  {"英文",{",",".","?","!",":","/","^","*",";",'"',"'","#","{","}","_","@","(",")","[","]",'`','~',"$","|","+","-","=","<",">","...","&","Ⓐ","Ⓑ","Ⓒ","Ⓓ","Ⓔ","Ⓕ","Ⓖ","Ⓗ","Ⓘ","Ⓙ","Ⓚ","Ⓛ","Ⓜ","Ⓝ","Ⓞ","Ⓟ","Ⓠ","Ⓡ","Ⓢ","Ⓣ","Ⓤ","Ⓥ","Ⓦ","Ⓧ","Ⓨ","Ⓩ"}},
  {"数学",{"﹢","﹣","·","/","=","≡","﹤","﹥","≦","≧","≮","≯","＋","－","×","÷","＝","≠","＜","＞","≤","≥","≈","≒","㎎","㎏","μm","㎜","㎝","㎞","℃","¥","$","€","฿","￡","㎡","m³","㏄","ml","mol","㏕","℉","￥","£","￠","₠","〒","∝","∽","∈","∩","∧","⊙","⌒","∥","∟","∣","∂","∆","∞","≌","∉","∪","∨","⊕","⊿","⊥","∠","∫","∬","∭","¹","²","³","⁴","⁵","ⁿ","⁶","⁷","⁸","⁹","⁰","ˣ","⁺","⁻","⁼","⁽","⁾","‰","½","⅓","¼","⅔","¾","％","₁","₂","₃","₄","₅","ₙ","₆","₇","₈","₉","₀","ₓ","₊","₋","₌","₍","₎","℅","°","′","″","∮","∯","∰"}},
  {"序号",{"①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩","⒈","⒉","⒊","⒋","⒌","⒍","⒎","⒏","⒐","⒑","⒒","⒓","⒔","⒕","⒖","⒗","⒘","⒙","⒚","⒛","⑴","⑵","⑶","⑷","⑸","⑹","⑺","⑻","⑼","⑽","⑾","⑿","⒀","⒁","⒂","⒃","⒄","⒅","⒆","⒇","㈠","㈡","㈢","㈣","㈤","㈥","㈦","㈧","㈨","㈩","➊","➋","➌","➍","➎","➏","➐","➑","➒","➓","㊀","㊁","㊂","㊃","㊄","㊅","㊆","㊇","㊈","㊉","ⅰ","ⅱ","ⅲ","ⅳ","ⅴ","ⅵ","ⅶ","ⅷ","ⅸ","ⅹ","Ⅰ","Ⅱ","Ⅲ","Ⅳ","Ⅴ","Ⅵ","Ⅶ","Ⅷ","Ⅸ","Ⅹ"}},
  {"特殊",{"△","▽","○","◇","□","☆","▲","▼","●","◆","■","★","▷","◁","▶","◀","√","×","⌫","✡","☑","☒","✔","✘","☼","☽","♀","☻","◐","㏂","☀","☾","♂","☹","◑","㏘","☜","☝","☞","☚","☟","☛","▪","•","‥","…","∷","※","♩","♪","♫","♬","§","°","♭","♯","♮","‖","¶","№","◎","¤","۞","℗","®","©","卍","卐","℡","™","㏇","Φ","↖","↑","↗","◤","㊤","◥","←","↔","→","㊧","㊥","㊨","↙","↓","↘","◣","㊦","◢","⇄","⇅","⇆","⇤","↩","⇥","❏","❐","◲","〼","▢","▣","⇦","⇧","⇨","⇩","⇪","↶","▸","◂","▴","▾","✁","☏","✍","❅","ϟ","📝","✎","✆","☴","☲","☷","⚿","⛮","⚙","☳","☯","☱","⛶","☩","☐","☶","☵","☰","💬","🗨","💭","ღ","✈","☂","🎤","🌐","🔍"}},
  {"单位",[[øØπ°′″＄￥〒￠￡％＠℃℉﹩﹪‰﹫㎡㎥㏕ml㎜㎝㎞㏎m³㎎㎏㏄mol㏒㏑º○¤%$º¹²³⁴ⁿ₁₂₃₄€£Ұ₴$₰¢₤¥₳₲₪₵元₣₱฿¤₡₮₭₩ރ円₢₥₫₦zł﷼₠₧₯₨Kčर₹ƒ₸￠]]},
  {"序号",[[①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳⓪❶❷❸❹❺❻❼❽❾❿⓫⓬⓭⓮⓯⓰⓱⓲⓳⓴㊀㊁㊂㊃㊄㊅㊆㊇㊈㊉㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽⑾⑿⒀⒁⒂⒃⒄⒅⒆⒇⒈⒉⒊⒋⒌⒍⒎⒏⒐⒑⒒⒓⒔⒕⒖⒗⒘⒙⒚⒛ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅪⅫⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵]]},
  {"声韵",[[bpmfdtnlɡkhjqxzhchshrzcsywɑāáǎàoōóǒòeēéěèiīíǐìuūúǔùüǖǘǚǜêḿńňǹ]]},
  {"拼音",{"ɑi","āi","ái","ǎi","ài","ei","ēi","éi","ěi","èi","ui","uī","uí","uǐ","uì","ɑo","āo","áo","ǎo","ào","ou","ōu","óu","ǒu","òu","iu","iū","iú","iǔ","iù","ie","iē","ié","iě","iè","üe","üē","üé","üě","üè","er","ēr","ér","ěr","èr","ɑn","ān","án","ǎn","àn","en","ēn","én","ěn","èn","in","īn","ín","ǐn","ìn","un","ūn","ún","ǔn","ùn","ün","ǖn","ǘn","ǚn","ǜn","ɑnɡ","ānɡ","ánɡ","ǎnɡ","ànɡ","enɡ","ēnɡ","énɡ","ěnɡ","ènɡ","inɡ","īnɡ","ínɡ","ǐnɡ","ìnɡ","onɡ","ōnɡ","ónɡ","ǒnɡ","ònɡ","uɑ","uā","uá","uǎ","uà","uo","uō","uó","uǒ","uò","uɑi","uāi","uái","uǎi","uài","uɑnɡ","uānɡ","uánɡ","uǎnɡ","uànɡ","uɑn","uān","uán","uǎn","uàn","üɑn","üān","üán","üǎn","üàn","iɑ","iā","iá","iǎ","ià","iɑo","iāo","iáo","iǎo","iào","iɑn","iān","ián","iǎn","iàn","iɑnɡ","iānɡ","iánɡ","iǎnɡ","iànɡ","ionɡ","iōnɡ","iónɡ","iǒnɡ","iònɡ"}},

    }
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xff555555)
    c.drawRoundRect(b,10,10,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xff555555)
    c.drawRoundRect(b,8,8,p)
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
        textColor=0xFF000000,
        textSize="10dp"},
      {TextView,
        gravity=17,
        layout_height=-1,
        layout_width=-1,
        textColor=0xFF000000,
        textSize="18dp"}}}
  local msg=Bu[2][2] --上标签
  local label=Bu[2][3] --主标签

  if id==2 then
    label.text=Icon("BackSpace","⌫")
    label.textSize="18dp" --默认符号⌫太小，字体大小改为22dp，后面同理
    Bu.onClick=function()
      service.sendEvent("BackSpace")
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
   elseif id==4 then
    msg.text=Icon("undo","↶")
    label.text=Icon("编辑","编辑")
    Bu.onClick=function()
      service.editFile(脚本名)
    end
    Bu.OnLongClickListener={onLongClick=function()
        service.sendEvent("undo")
        return true
    end}
   elseif id==1 then
    label.text=Icon("Return","⏎")
    label.textSize="18dp"
    Bu.onClick=function()
      service.sendEvent("Return")
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
   elseif id==3 then
    label.text=Icon("K_default","返回")
    Bu.onClick=function()
      service.sendEvent("K_default")
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
  end

  return Bu
end

local height="240dp" --键盘高度
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)
local ids,layout={},{LinearLayout,
  orientation=1,
  --键盘高度
  layout_height=height,
  layout_width=-1,
  --背景颜色
  BackgroundColor=0xff888888,
  {TextView,
    layout_height="1dp",
    layout_width=-1,
    BackgroundColor=0xFF000000},
  {LinearLayout,
    layout_height=-1,
    layout_width=-1,
  
  

     {LinearLayout,
      orientation=1,
      --左侧功能键宽度
      layout_width="45dp",
      layout_height=-1,
      layout_gravity=1|84,
      Bu_R(4),
      Bu_R(2),
      Bu_R(1),
      Bu_R(3)},

      
      {LinearLayout,
      id="main",
      orientation=1,
      layout_height=-1,
      layout_width=-1,
      layout_weight=1,
      {GridView, --列表控件
        id="list",
        numColumns=6, --6列
        paddingLeft="0dp",
        paddingRight="0dp",
        layout_width=-1,
        layout_weight=1}},
        
    {LinearLayout,
      orientation=1,
      --右侧功能键宽度
      layout_width="0dp",
      layout_height=-1,
      layout_gravity=1|84,
      Bu_R(4),
      Bu_R(2),
      Bu_R(1),
      Bu_R(3)}}}
layout=loadlayout(layout,ids)

local data,item={},{LinearLayout,
  layout_width=-1,
  padding="2dp",
  gravity=17,
  {CardView,
    radius="8dp",
    CardElevation=0,
    layout_width=-1,
    {TextView,
      id="a",
      padding="8dp",
      gravity=17,
      layout_width=-1,
      BackgroundColor=0xff555555,
      textColor=0xffdfdfdf,
      textSize="19dp"}}}
local adp=LuaAdapter(service,data,item)
ids.list.Adapter=adp

--刷新列表
local function fresh(t)
  table.clear(data)
  if type(t)~="table" then
    local ts={}
    for a in utf8.gmatch(tostring(t),"%S")
      table.insert(ts,a)
    end
    t=ts
  end
  for _,v in ipairs(t) do
    table.insert(data,{a=v})
  end
  adp.notifyDataSetChanged()
end

ids.list.onItemClick=function(l,v,p)
  local s=data[p+1].a
  service.commitText(s)
  if utf8.len(s)>1 then
    service.sendEvent("Left")
  end
end

ids.list.onItemLongClick=function(l,v,p)
  --返回（真），否则长按也会触发点击事件
  return true
end





--初始显示Emoji第一项内容
fresh(Emoji[1][2])

local Bus={LinearLayout,
  paddingLeft="2dp",
  layout_width=-1}
for _,v in ipairs(Emoji) do
  table.insert(Bus,{TextView,
    text=tostring(v[1]),
    layout_margin="2dp",
    layout_marginLeft="2dp",
    layout_marginRight="2dp",
    padding="8dp",
    gravity=17,
    layout_width=-1,
    layout_height=-1,
    layout_weight=1,
    onClick=function()
      fresh(v[2])
    end,
    OnLongClickListener={onLongClick=function() return true end},
    Background=Back(),
    textColor=0xFF000000,
    textSize="15dp"})
end
ids.main.addView(loadlayout(Bus))

service.setKeyboard(layout)

