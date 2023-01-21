--[[中文输入法 （同文无障碍版）

【颜色表2.0】

作者： 风之漫舞 
调用方式：
将本lua放进以下目录/storage/emulated/0/Android/rime/script

trime.yaml:

preset_keys:
  _Keyboard_Color: {label: 🥶, send: function, command: '颜色表2.0.lua'}

preset_keyboards:
  - {click: _Keyboard_Color}
2020-09-11
]]
require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.Color"
import "android.graphics.drawable.StateListDrawable"
import "java.io.File"


local arr={

  {"Emoji",
    {
      --{按键名,符号table 或 文本}
      {"表情",[[😀😃😄😁😆😅🤣😂🙂🙃😉😊😇🥰😍🤩😘😗☺😚😙🥲😋😛😜🤪😝🤑🤗🤭🤫🤔🤐🤨😐😑😶😏😒🙄😬🤥😌😔😪🤤😴😷🤒🤕🤢🤮🤧🥵🥶🥴😵🤯🤠🥳🥸😎🤓🧐😕😟🙁☹😮😯😲😳🥺😦😧😨😰😥😢😭😱😖😣😞😓😩😫🥱😤😡😠🤬😈👿💀☠💩🤡👹👺👻👽👾🤖😺😸😹😻😼😽🙀😿😾🙈🙉🙊💋💌💘💝💖💗💓💞💕💟❣💔❤❤❤🧡💛💚💙💜🤎🖤🤍💯💢💥💫💦💨🕳💣💬👁🗨🗯💭💤]]}, --[[长文本，可换行]]
      {"手势",[[👋🤚🖐✋🖖👌🤌🤏✌🤞🤟🤘🤙👈👉👆🖕👇☝👍👎✊👊🤛🤜👏🙌👐🤲🤝🙏✍💅🤳💪🦾🦿🦵🦶👂🦻👃🧠🫀🫁🦷🦴👀👁👅👄👶🧒👦👧🧑👱👨🧔👩🧓👴👵🙍🙎🙅🙆💁🙋🧏🙇🤦🤷💆💇🚶🧍🧎🏃💃🕺🕴👯🧖🧗🧘🛀🛌]]},
      {"关系",[[🧑👭👫👬💏👨👨👩💑👪👦👧👦👧👦👧👦👦👧👦👦👧🗣👤👥🫂👣🦰🦱🦳🦲👮🕵🕵🕵💂🥷👷🤴👸👳👲🧕🤵👰🤰🤱👼🎅🤶🦸🦹🧙🧚🧛🧜🧝🧞🧟]]},
      {"动植",[[🐵🐒🦍🦧🐶🐕🦮🐩🐺🦊🦝🐱🐈🦁🐯🐅🐆🐴🐎🦄🦓🦌🦬🐮🐂🐃🐄🐷🐖🐗🐽🐏🐑🐐🐪🐫🦙🦒🐘🦣🦏🦛🐭🐁🐀🐹🐰🐇🐿🦫🦔🦇🐻🐨🐼🦥🦦🦨🦘🦡🐾🦃🐔🐓🐣🐤🐥🐦🐧🕊🦅🦆🦢🦉🦤🪶🦩🦚🦜🐸🐊🐢🦎🐍🐲🐉🦕🦖🐳🐋🐬🦭🐟🐠🐡🦈🐙🐚🐌🦋🐛🐜🐝🪲🐞🦗🪳🕷🕸🦂🦟🪰🪱🦠💐🌸💮🏵🌹🥀🌺🌻🌼🌷🌱🪴🌲🌳🌴🌵🌾🌿☘🍀🍁🍂🍃🍇🍈🍉🍊🍋🍌🍍🥭🍎🍏🍐🍑🍒🍓🫐🥝🍅🫒🥥🥑🍆🥔🥕🌽🌶🫑🥒🥬🥦🧄🧅🍄🥜🌰🍞🥐🥖🫓🥨🥯🥞🧇🧀🍖🍗🥩🥓🍔🍟🍕🌭🥪🌮🌯🫔🥙🧆🥚🍳🥘🍲🫕🥣🥗🍿🧈🧂🥫🍱🍘🍙🍚🍛🍜🍝🍠🍢🍣🍤🍥🥮🍡🥟🥠🥡🦀🦞🦐🦑🦪🍦🍧🍨🍩🍪🎂🍰🧁🥧🍫🍬🍭🍮🍯🍼🥛☕🫖🍵🍶🍾🍷🍸🍹🍺🍻🥂🥃🥤🧋🧃🧉🧊🥢🍽🍴🥄🔪🏺]]},
      {"天地",[[🌍🌎🌏🌐🗺🗾🧭🏔⛰🌋🗻🏕🏖🏜🏝🏞🏟🏛🏗🧱🪨🪵🛖🏘🏚🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪🏫🏬🏭🏯🏰💒🗼🗽⛪🕌🛕🕍⛩🕋⛲⛺🌁🌃🏙🌄🌅🌆🌇🌉♨🎠🎡🎢💈🎪🚂🚃🚄🚅🚆🚇🚈🚉🚊🚝🚞🚋🚌🚍🚎🚐🚑🚒🚓🚔🚕🚖🚗🚘🚙🛻🚚🚛🚜🏎🏍🛵🦽🦼🛺🚲🛴🛹🛼🚏🛣🛤🛢⛽🚨🚥🚦🛑🚧⚓⛵🛶🚤🛳⛴🛥🚢✈🛩🛫🛬🪂💺🚁🚟🚠🚡🛰🚀🛸🛎🧳⌛⏳⌚⏰⏱⏲🕰🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌡☀🌝🌞🪐⭐🌟🌠🌌☁⛅⛈🌤🌥🌦🌧🌨🌩🌪🌫🌬🌀🌈🌂☂☔⛱⚡❄☃⛄☄🔥💧🌊]]},
      {"娱乐",[[🎃🎄🎆🎇🧨✨🎈🎉🎊🎋🎍🎎🎏🎐🎑🧧🎀🎁🎗🎭🖼🎨🧵🪡🧶🪢👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩱🩲🩳👙👚👛👜👝🛍🎒🩴👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢🪖⛑📿💄💍💎🎟🎫🎖🏆🏅🥇🥈🥉⚽⚾🥎🏀🏐🏈🏉🎾🥏🎳🏏🏑🏒🥍🏓🏸🥊🥋🥅⛳⛸🎣🤿🎽🎿🛷🥌🤺🏇⛷🏂🏌🏌🏌🏄🚣🏊⛹⛹⛹🏋🏋🏋🚴🚵🤸🤼🤽🤾🤹🎯🪀🪁🎱🔮🪄🧿🎮🕹🎰🎲🧩🧸🪅🪆♠♥♦♣♟🃏🀄🎴]]},
      {"学科",[[🔇🔈🔉🔊📢📣📯🔔🔕🎼🎵🎶🎙🎚🎛🎤🎧📻🎷🪗🎸🎹🎺🎻🪕🥁🪘📱📲☎📞📟📠🔋🔌💻🖥🖨⌨🖱🖲💽💾💿📀🧮🎥🎞📽🎬📺📷📸📹📼🔍🔎🕯💡🔦🏮🪔📔📕📖📗📘📙📚📓📒📃📜📄📰🗞📑🔖🏷💰🪙💴💵💶💷💸💳🧾💹✉📧📨📩📤📥📦📫📪📬📭📮🗳✏✒🖋🖊🖌🖍📝💼📁📂🗂📅📆🗒🗓📇📈📉📊📋📌📍📎🖇📏📐✂🗃🗄🗑🔒🔓🔏🔐🔑🗝🔨🪓⛏⚒🛠🗡⚔🔫🪃🏹🛡🪚🔧🪛🔩⚙🗜⚖🦯🔗⛓🪝🧰🧲🪜⚗🧪🧫🧬🔬🔭📡💉🩸💊🩹🩺🚪🛗🪞🪟🛏🛋🪑🚽🪠🚿🛁🪤🪒🧴🧷🧹🧺🧻🪣🧼🪥🧽🧯🛒🚬⚰🪦⚱🗿🪧]]},
      {"标牌",[[🏧🚮🚰♿🚹🚺🚻🚼🚾🛂🛃🛄🛅⚠🚸⛔🚫🚳🚭🚯🚱🚷📵🔞☢☣⬆↗➡↘⬇↙⬅↖↕↔↩↪⤴⤵🔃🔄🔙🔚🔛🔜🔝🛐⚛🕉✡☸☯✝☦☪☮🕎🔯♈♉♊♋♌♍♎♏♐♑♒♓⛎🔀🔁🔂▶⏩⏭⏯◀⏪⏮🔼⏫🔽⏬⏸⏹⏺⏏🎦🔅🔆📶📳📴♀♂⚧✖➕➖➗♾‼⁉❓❔❕❗〰💱💲⚕♻⚜🔱📛🔰⭕✅☑✔❌❎➰➿〽✳✴❇©®™🔟🔠🔡🔢🔣🔤🅰🆎🅱🅾🆑🆒🆓ℹ🆔Ⓜ🆕🆖🆗🅿🆘🆙🆚🈁🈂🈷🈶🈯🉐🈹🈚🈲🉑🈸🈴🈳㊗㊙🈺🈵🔴🟠🟡🟢🔵🟣🟤⚫⚪🟥🟧🟨🟩🟦🟪🟫⬛⬜◼◻◾◽▪▫🔶🔷🔸🔹🔺🔻💠🔘🔳🔲]]},
      {"旗子",[[🇨🇳🇭🇰🇲🇴🇷🇺🇺🇸🇺🇲🇯🇵🇰🇵🇰🇷🇩🇪🇫🇷🇬🇧🇮🇹🇪🇸🇮🇳🇨🇦🇦🇺🇻🇳🇧🇷🇹🇼🇦🇨🇦🇩🇦🇪🇦🇫🇦🇬🇦🇮🇦🇱🇦🇲🇦🇴🇦🇶🇦🇷🇦🇸🇦🇹🇦🇼🇦🇽🇦🇿🇧🇦🇧🇧🇧🇩🇧🇪🇧🇫🇧🇬🇧🇭🇧🇮🇧🇯🇧🇱🇧🇲🇧🇳🇧🇴🇧🇶🇧🇸🇧🇹🇧🇻🇧🇼🇧🇾🇧🇿🇨🇨🇨🇩🇨🇫🇨🇬🇨🇭🇨🇮🇨🇰🇨🇱🇨🇲🇨🇴🇨🇵🇨🇷🇨🇺🇨🇻🇨🇼🇨🇽🇨🇾🇨🇿🇩🇬🇩🇯🇩🇰🇩🇲🇩🇴🇩🇿🇪🇦🇪🇨🇪🇪🇪🇬🇪🇭🇪🇷🇪🇹🇪🇺🇫🇮🇫🇯🇫🇰🇫🇲🇫🇴🇬🇦🇬🇩🇬🇪🇬🇫🇬🇬🇬🇭🇬🇮🇬🇱🇬🇲🇬🇳🇬🇵🇬🇶🇬🇷🇬🇸🇬🇹🇬🇺🇬🇼🇬🇾🇭🇲🇭🇳🇭🇷🇭🇹🇭🇺🇮🇨🇮🇩🇮🇪🇮🇱🇮🇲🇮🇴🇮🇶🇮🇷🇮🇸🇯🇪🇯🇲🇯🇴🇰🇪🇰🇬🇰🇭🇰🇮🇰🇲🇰🇳🇰🇼🇰🇾🇰🇿🇱🇦🇱🇧🇱🇨🇱🇮🇱🇰🇱🇷🇱🇸🇱🇹🇱🇺🇱🇻🇱🇾🇲🇦🇲🇨🇲🇩🇲🇪🇲🇫🇲🇬🇲🇭🇲🇰🇲🇱🇲🇲🇲🇳🇲🇵🇲🇶🇲🇷🇲🇸🇲🇹🇲🇺🇲🇻🇲🇼🇲🇽🇲🇾🇲🇿🇳🇦🇳🇨🇳🇪🇳🇫🇳🇬🇳🇮🇳🇱🇳🇴🇳🇵🇳🇷🇳🇺🇳🇿🇴🇲🇵🇦🇵🇪🇵🇫🇵🇬🇵🇭🇵🇰🇵🇱🇵🇲🇵🇳🇵🇷🇵🇸🇵🇹🇵🇼🇵🇾🇶🇦🇷🇪🇷🇴🇷🇸🇷🇼🇸🇦🇸🇧🇸🇨🇸🇩🇸🇪🇸🇬🇸🇭🇸🇮🇸🇯🇸🇰🇸🇱🇸🇲🇸🇳🇸🇴🇸🇷🇸🇸🇸🇹🇸🇻🇸🇽🇸🇾🇸🇿🇹🇦🇹🇨🇹🇩🇹🇫🇹🇬🇹🇭🇹🇯🇹🇰🇹🇱🇹🇲🇹🇳🇹🇴🇹🇷🇹🇹🇹🇻🇹🇿🇺🇦🇺🇬🇺🇾🇺🇿🇻🇦🇻🇨🇻🇪🇻🇬🇻🇮🇻🇺🇼🇫🇼🇸🇽🇰🇾🇪🇾🇹🇿🇦🇿🇲🇿🇼]]},
      {"彩旗",[[🏳️‍🌈🏳️‍⚧🏴‍☠️]]},
      {"旗帜",[[🏁🚩🎌🏴🏳]]}
    }
  }
}

local 参数=(...)
local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)

local 编号=1
if 参数!=nil && string.find(参数,"《《")!=nil && string.find(参数,"》》")!=nil then
  编号=tonumber(string.sub(参数,string.find(参数,"《《")+6,string.find(参数,"》》")-1))
end



local ids,data={},{}
local item={LinearLayout,
  layout_width=-1,
  padding="2dp",
  gravity=17,
  {CardView,
    radius="8dp",
    CardElevation="5dp",
    cardBackgroundColor="0xff000000",
    layout_width=-1,
    {TextView,
      id="a",
      padding="8dp",
      gravity=17,
      layout_width=-1,
      textColor=0xffffffff,
      textSize="18dp"}
  }
}


local adp=LuaAdapter(service,data,item)

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
    p.setColor(0xff444444)
    c.drawRoundRect(b,20,20,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end



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
    if string.find(v,"#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")==nil then
      --print(v.." 非颜色代码")
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor("#ff777777"),
        },
      })
     else
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor(v),
        },
      })
    end

  end
  adp.notifyDataSetChanged()

end

--刷新列表
local function fresh2(t)
  table.clear(data)
  if type(t)~="table" then
    local ts={}
    local c = 0
    local s = ""
    for a in utf8.gmatch(tostring(t),"%S")
      c = c + 1
      s = s..a
      if c == 2 then
       table.insert(ts,s)
       c = 0
       s = ""
      end
      end
    t=ts
  end
  for _,v in ipairs(t) do
    if string.find(v,"#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")==nil then
      --print(v.." 非颜色代码")
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor("#ff777777"),
        },
      })
     else
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor(v),
        },
      })
    end

  end
  adp.notifyDataSetChanged()

end

--刷新列表
local function fresh3(t)
  table.clear(data)
  if type(t)~="table" then
    local ts={}
    local c = 0
    local s = ""
    for a in utf8.gmatch(tostring(t),"%S")
      c = c + 1
      s = s..a
      if c == 4 then
       table.insert(ts,s)
       c = 0
       s = ""
      end
      end
    t=ts
  end
  for _,v in ipairs(t) do
    if string.find(v,"#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")==nil then
      --print(v.." 非颜色代码")
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor("#ff777777"),
        },
      })
     else
      table.insert(data,{
        a={
          Text=v,
          BackgroundColor=Color.parseColor(v),
        },
      })
    end

  end
  adp.notifyDataSetChanged()

end

local function bus(t,id)
  local Bus={LinearLayout,
    paddingLeft="2dp",
    layout_width=-1}

  for _,v in ipairs(t) do
    tex = tostring(v[1])
    if tex == "旗子" then
      table.insert(Bus,{TextView,
      text=tostring(v[1]),
      layout_margin="2dp",
      layout_marginLeft="1dp",
      layout_marginRight="1dp",
      paddingTop="9dp",
      paddingBottom="9dp",
      gravity=17,
      layout_width=-1,
      layout_height=-1,
      layout_weight=1,
      onClick=function()
        fresh2(v[2])
      end,
      OnLongClickListener={onLongClick=function() return true end},
      Background=Back(),
      textColor=0xffffffff,
      textSize="15dp"}) 
    elseif tex == "彩旗" then
      table.insert(Bus,{TextView,
      text=tostring(v[1]),
      layout_margin="2dp",
      layout_marginLeft="1dp",
      layout_marginRight="1dp",
      paddingTop="9dp",
      paddingBottom="9dp",
      gravity=17,
      layout_width=-1,
      layout_height=-1,
      layout_weight=1,
      onClick=function()
        fresh3(v[2])
      end,
      OnLongClickListener={onLongClick=function() return true end},
      Background=Back(),
      textColor=0xffffffff,
      textSize="15dp"}) 
    else
      table.insert(Bus,{TextView,
      text=tostring(v[1]),
      layout_margin="2dp",
      layout_marginLeft="1dp",
      layout_marginRight="1dp",
      paddingTop="9dp",
      paddingBottom="9dp",
      gravity=17,
      layout_width=-1,
      layout_height=-1,
      layout_weight=1,
      onClick=function()
        fresh(v[2])
      end,
      OnLongClickListener={onLongClick=function() return true end},
      Background=Back(),
      textColor=0xffffffff,
      textSize="15dp"})
    end
  end
  if ids.main.getChildAt(1)
    ids.main.removeViewAt(1)
  end
  ids.main.addView(loadlayout(Bus))
end

local function Icon(k,s) --获取k功能图标,没有返回s
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
        textColor=0xffffffff,
        textSize="10dp"},
      {TextView,
        gravity=17,
        layout_height=-1,
        layout_width=-1,
        textColor=0xffffffff,--标签颜色
        textSize="15dp"}}}
  local msg=Bu[2][2] --上标签
  local label=Bu[2][3] --主标签


  if id<=#arr then
    label.text=Icon(arr[id][1],arr[id][1])
    label.textSize="18dp" --默认符号⌫太小,字体大小改为22dp,后面同理
    Bu.onClick=function()
      fresh(arr[id][2][1][2])
      bus(arr[id][2])
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
   elseif id==(#arr+3) then
    label.text=Icon("Keyboard_default","返回")
    Bu.onClick=function()
      service.sendEvent("Keyboard_default")
    end
   elseif id==(#arr+1) then
    label.text=Icon("编辑","编辑")
    Bu.onClick=function()
      service.editFile(脚本路径)--用内置编辑器打开文件
    end
   elseif id==(#arr+2) then
    label.text=Icon("BackSpace","⌫")
    Bu.onClick=function()
      service.sendEvent("BackSpace")
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
  end
  return Bu
end

local height="240dp" --键盘高度
pcall(function()
  --键盘自适应高度,旧版中文不支持,放pcall里防报错
  height=service.getLastKeyboardHeight()
end)

local layout={LinearLayout,
  orientation=1,
  --键盘高度
  layout_height=height,
  layout_width=-1,
  --背景颜色
  BackgroundColor=0xff202022,
  {TextView,
    layout_height="1dp",
    layout_width=-1,
    BackgroundColor=0xff202022},
  {LinearLayout,
    layout_height=-1,
    layout_width=-1,

    {LinearLayout,
      id="main",
      orientation=1,
      --右侧功能键宽度
      layout_width=-1,
      layout_height=-1,
      layout_weight=1,
      --layout_gravity=5|84,
      {GridView, --列表控件
        id="list",
        numColumns=9, --6列
        paddingLeft="2dp",
        paddingRight="2dp",
        layout_width=-1,
        layout_weight=1}},
    {LinearLayout,
      orientation=1,
      layout_width="49dp",
      layout_height=-1,
      layout_gravity=5|84,

      --Bu_R(1),

    },
  }}

for i=1,#arr+3 do
  table.insert(layout[3][3],Bu_R(i))
end

layout=loadlayout(layout,ids)

ids.list.Adapter=adp

ids.list.onItemClick=function(l,v,p)
  local s=data[p+1].a.Text
  --dofile(tostring(service.getLuaExtDir("script")).."/包/字符串/字符串数组互转.lua")
  --print(数组转字符串(s))
  service.commitText(s)
end

ids.list.onItemLongClick=function(l,v,p)
  --返回（真）,否则长按也会触发点击事件
  return true
end




--初始显示Emoji第一项内容
fresh(arr[1][2][1][2])
bus(arr[1][2],1)



service.setKeyboard(layout)