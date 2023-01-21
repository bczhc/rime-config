--[[

仿大厂样式的符号键盘
作者：6486449j
版本：1.1

]]--
require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"
import "java.io.File"

import "android.os.*"
import "com.osfans.trime.*"


--键盘高度
local keyboard_height="300dp"
pcall(function()
  keyboard_height=service.getLastKeyboardHeight()
end)

--底部按键高度
local botmButmHeight=140

--功能键区域宽度
local funButnWidth=140

local currSelect=1

local symbol_icons={"数字","英文","中文","运算","角标","序号","音标","平假","片假","谚文","阿文","箭头","特殊","拼音","注音","竖标","部首","俄文","希腊","拉丁","制表","土文","藏文"}
local symbols={
  {"÷","1","2","3","×","4","5","6","-","7","8","9","+","()","0",".","=","/","%","元","£","€","$","¥"},
  {".","@", "~", "-", ",", ":", "*","?","!","_","#","/","=","+","﹉","&","^",";","%","…","$","(",")","\\","..","<",">","|","·","¥","[","]","\"","{","}","–","'","€","¡","¿","`","´","＂","＇","£","¢","฿","♀","♂"},
  {"，","。","？","！","～","、","：","＃","；","％","＊","——","……","＆","·","￥","（","）","‘","’","“","”","[","]","『","』","〔","〕","｛","｝","【","】","‖","〖","〗","〘","〙","〚","〛","《","》","「","」","｜","〈","〉","«","»","‹","›"}, 
  [[=+-·/×÷^＞＜≥≤≮≯≡≠≈≒±√³√π%‰％℅½⅓⅔¼¾∶∵∴∷㏒㏑∫∬∭∮∯∰∂∑∏∈∉∅⊂⊃⊆⊇⊄⊅⊊⊈⫋⫌∀∃∩∪∧∨⊙⊕∥⊥⌒∟∠△⊿∝∽∞≌°℃℉㎎㎏μm㎜㎝㎞㎡m³㏄㏕]],
  [[º⁰¹²³⁴⁵⁶⁷⁸⁹ⁱ⁺⁻⁼⁽⁾ˣʸⁿᶻˢ₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₒₓᵧₔᴬᴮᶜᴰᴱᶠᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᶞᴿᵀᵁᵛᵂᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ]],
  [[①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳❶❷❸❹❺❻❼❽❾❿⓫⓬⓭⓮⓯⓰⓱⓲⓳⓴⓵⓶⓷⓸⓹⓺⓻⓼⓽⓾⒈⒉⒊⒋⒌⒍⒎⒏⒐⒑⒒⒓⒔⒕⒖⒗⒘⒙⒚⒛⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽⑾⑿⒀⒁⒂⒃⒄⒅⒆⒇㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩㊀㊁㊂㊃㊄㊅㊆㊇㊈㊉壹贰叁肆伍陆柒捌玖拾佰仟萬億ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅪⅫⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵]],
  {"ɑː","ɔ:","ɜː","i:","u:","ʌ","ɒ","ə","ɪ","ʊ","e","æ","eɪ","aɪ","ɔɪ","ɪə","eə","ʊə","əʊ","aʊ","p","t","k","f","θ","s","b","d","g","v","ð","z","ʃ","h","ts","tʃ","j","tr","ʒ","r","dz","dʒ","dr","w","m","n","ŋ","l"},
  [[あいうえおぁぃぅぇぉかきくけこがぎぐげごさしすせそざじずぜぞたちつてとだぢづでどっなにぬねのはひふへほばびぶべぼぱぴぷぺぽまみむめもやゆよゃゅょらりるれろわをんゎ]],
  [[アイウエオァィゥェォカキクケコガギグゲゴサシスセソザジズゼゾタチツテトダヂヅデドッナニヌネノハヒフヘホバビブベボパピプペポマミムメモヤユヨャュョラリルレロワヲンヮ]],
  {"ㅏ ","ㅐ ","ㅑ ","ㅒ ","ㅓ ","ㅔ ","ㅕ ","ㅖ ","ㅗ ","ㅘ ","ㅙ ","ㅚ ","ㅛ ","ㅜ ","ㅝ ","ㅞ ","ㅟ ","ㅠ ","ㅡ ","ㅢ ","ㅣ","ㄱ ","ㄷ ","ㅂ"," ㅅ"," ㅈ","ㄲ ","ㄸ ","ㅃ ","ㅆ ","ㅉ","ㅋ ","ㅌ ","ㅍ"," ㅊ ","ㄴ","ㅁ ","ㄹ ","ㅎ ","ㅇ",},
  {"ث‎","ت‎","ب‎","ا‎","د‎","خ‎","ح‎","ج‎","س‎","ز‎","ر‎","ذ‎","ط‎","ض‎","ص‎","ش‎","ف‎","غ‎","ع‎","ظ‎","م‎","ل‎","ك‎","ق‎","ي‎","و‎","ه‎","ن‎"},
  [[→←↑↓↖↗↙↘↔↕⇞⇟⇆⇅⇔⇕↰↱↲↴↶↷↺↻↜↝↞↟↠↡➺➻➼➳➽➸➹➷⇎➠↣☞☜☟⇦⇧⇨⇩⇪➩➪➫➬➯➱➮➭➠➡➢➣➤➥➦➧➨]],
  [[△▽○◇□☆▷◁♤♡♢♧▲▼●◆■★▶◀♠♥♦♣囍☼☽☺◐☑√✔㏂☀☾♂☹◑×✕✘☚☛㏘▪•‥…▁▂▃▄▅▆▇█∷※░▒▓▏▎▍▌▋▊▉♩♪♫♬§〼◎¤۞℗®©♭♯♮‖¶卍卐▬〓℡™㏇☌☍☋☊㉿◮◪◔◕@㈱№♈♉♊♋♌♎♏♐♑♓♒♍☰☱☲☳☯☴☵☶☷*＊✲❈❉✿❀❃❁☸✖✚✪❤ღ❦❧₪✎✍📝✌☁☂☃☄♨☇☈☡➷⊹✉☏☢☣☠☮〄➹☩ஐ☎✈〠۩✙✟☤☥☦☧☨☫☬♟♙♜♖♞♘♝♗♛♕♚♔✄✁✃❥✪☒❅✣✰⚀⚁⚂⚃⚄⚅]],
  [[āáǎàōóǒòēéěèīíǐìūúǔùǖǘǚǜü]],
  [[ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦ]],
  [[︐︑︒︓︔︕︖︵︶︷︸︹︺︿﹀︽︾﹁﹂﹃﹄︻︼︗︘_¯＿￣﹏﹋﹍﹉﹎﹊¦︴¡¿^ˇ¨ˊ]],
  [[丨亅丿乛一乙乚丶八勹匕冫卜厂刀刂儿二匚阝丷几卩冂力冖凵人亻入十厶亠匸讠廴又艹屮彳巛川辶寸大飞干工弓廾广己彐彑巾口马门宀女犭山彡尸饣士扌氵纟巳土囗兀夕小忄幺弋尢夂子贝比灬长车歹斗厄方风父戈卝户火旡见斤耂毛木肀牛牜爿片攴攵气欠犬日氏礻手殳水瓦尣王韦文毋心牙爻曰月爫支止爪白癶歺甘瓜禾钅立龙矛皿母目疒鸟皮生石矢示罒田玄穴疋业衤用玉耒艸臣虫而耳缶艮虍臼米齐肉色舌覀页先行血羊聿至舟衣竹自羽糸糹貝采镸車辰赤辵豆谷見角克里卤麦身豕辛言邑酉豸走足青靑雨齿長非阜金釒隶門靣飠鱼隹風革骨鬼韭面首韋香頁音髟鬯鬥高鬲馬黄鹵鹿麻麥鳥魚鼎黑黽黍黹鼓鼠鼻齊齒龍龠]],
  [[абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]],
  [[ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρστυφχψω]],
  [[ÀÁÂÃÄÅĀÆÇÈÉÊËĒÌÍÎÏĪÐÑÒÓÔÕÖŌØŒÙÚÛÜŪÝŸÞŠàáâãäåæçèéêëēìíîǐïīðñòóõǒôöōøœùúǔûüūýþšÿ]],
  [[┝┞┟┠┡┢═╞╟╡╢╪┭┮┯┰┱┲║╤╥╧╨╫┥┦┧┨┩┪┽┾┿╀╁╂┵┶┷┸┹┺╄╅╆╇╈╉┈┉┊┋╃╊┍┑┕┙┎┒┖┚╒╕╘╛╓╖╙╜┄┅┆┇┌┬┐├┼┤└┴┘┏┳┓┣╋┫┗┻┛╔╦╗╠╬╣╚╩╝]],
  [[ᐁᐂᐃᐄᐅᐆᐇᐈᐉᐊᐋᐒᐓᐜᐷᐶᐵᐴᐳᑄᑅᑌᑍᑏᑎᑒᑓᑔᑞᑡᑫᑬᑭᑮᑯᑱᑰᑳᑴᑷᒎᒏᒑᒠᒢᒡᒤᒥᒦᓀᓂᓁᓃᓄᓉᓋᓔᓖᓙᓛᓳᓻᓵᓲᓰᔂᓿᓾᗤᗥᗦᘑᘗᘜᘲᙀᙁ]],
  {"྅","ཽ","༒","ྀ","ི","༄༅","༽","༼","ཨོཾ","།","ྈ","ༀ","༂","༃","༆","༇","༈","༉","༊","༓","༔","༕","༖","༗","༙","༜","༴","༵","༶","༷","༺","༻","༾","༿","ི",",ུ","ེ","ོ","་","།","ྲ","ྱ","༡","༢","༣","༤","༥","༦","༧","༨","༩","༠"}
  }

local layout_ids={}
--local selected_id="tab_"+tostring(selected_id)

--功能键颜色与边框颜色
local funButnColor=0xffc4c9ca
local funButnBorderColor=0xff777777

--底部按键边框与颜色
local botmButnColor=0xffffffff
local botmButnBorderColor=0xff777777
local cliedBotmButnColor=0xffc4c9ca

local symButnColor=0xffffffff
local symButnBorderColor=0xff777777
local cliedSymButnColor=0xffc4c9ca

local curr_tab_id="tab"..tostring(currSelect)
local last_tab_id=""

--获取k功能图标，没有返回s
local function icon(k,s)
  k=Key.presetKeys[k]
  return k and k.label or s
end

--生成背景
local function background(color, borderColor)
  local background=LuaDrawable(function(canvas, paint, drawable)
    local b=drawable.bounds
    --paint.setColor(color)
    canvas.drawColor(color)
    paint.setColor(borderColor)
    canvas.drawLine(b.left, b.top, b.left, b.bottom, paint)
    canvas.drawLine(b.left, b.top, b.right, b.top, paint)
    canvas.drawLine(b.right, b.top, b.right, b.bottom, paint)
    canvas.drawLine(b.left, b.bottom, b.right, b.bottom, paint)
  end)

  return background
end

local function bg_effect(color, clickedColor, borderColor)
  local state_1=background(color, borderColor)
  local state_2=background(clickedColor, borderColor)

  local bg=StateListDrawable()
  bg.addState({-android.R.attr.state_pressed},state_1)
  bg.addState({android.R.attr.state_pressed},state_2)
  return bg
end

local data={}
local item={
  LinearLayout,
  layout_height=150,
  layout_width=-1,
  gravity="center",
  {
    TextView,
    id="text",
    layout_width=-1,
    layout_height=-1,
    textColor=0xff232323,
    gravity="center",
    textSize="16dp",
    background=background(symButnColor,symButnBorderColor)
}}
local adp=LuaAdapter(service, data, item)

--
local function getSideKeys()
  local funButnHeight=(keyboard_height-botmButmHeight)/4
  local layout={LinearLayout,
    Orientation=1,
    layout_padding=0,
    layout_width="fill",
    {Button,
      id="back",
      text=icon("Keyboard_default", "返回"),
      layout_height=funButnHeight,
      onClick=function()
        service.sendEvent("Keyboard_default")
      end,
      --layout_margin=-14,
      background=background(funButnColor,funButnBorderColor)
    },
    {Button,
      text=icon("space", "空格"),
      layout_height=funButnHeight,
      --layout_margin=-14,
      onClick=function()
        service.sendEvent("space")
      end,
      background=background(funButnColor,funButnBorderColor)
    },
    {Button,
      text=icon("BackSpace","退格"),
      layout_height=funButnHeight,
      --layout_margin=-14,
      onClick=function()
        service.sendEvent("BackSpace")
      end,
      background=background(funButnColor,funButnBorderColor)
    },
    {Button,
      text=icon("Return", "回车"),
      layout_height=funButnHeight,
      --layout_margin=-14,
      onClick=function()
        service.sendEvent("Return")
      end,
      background=background(funButnColor,funButnBorderColor)
    }
  }
  return layout
end

--生成符号列表
local function genContentList()
  table.clear(data)
  local tmp_sym=symbols[currSelect]
  if type(tmp_sym)=="string" then
    local temp={}
    for a in utf8.gmatch(tostring(tmp_sym),"%S")
      table.insert(temp,a)
    end
    tmp_sym=temp
  end
  for i in ipairs(tmp_sym)
    table.insert(data,{
      text={
        Text=tostring(tmp_sym[i]),
      },
    })
  end
end

--生成底部按键
local function getBottomKeys()
  local layout={HorizontalScrollView,
    {LinearLayout,
      Orientation=0,
      layout_padding=0
    }
  }
  for i in ipairs(symbol_icons)
    local butn={Button,
      id="tab"..tostring(i),
      text=tostring(symbol_icons[i]),
      layout_width="230px",
      background=background(botmButnColor, botmButnBorderColor),
      onClick=function()
        last_tab_id=curr_tab_id
        curr_tab_id="tab"..tostring(i)
        --print(curr_tab_id)
        currSelect=i
        genContentList()
        adp.notifyDataSetChanged()
        
        if curr_tab_id~="" then
          layout_ids[curr_tab_id].setBackground(background(cliedBotmButnColor,botmButnBorderColor))
          --print("clicked")
        end
        if last_tab_id~="" then
          layout_ids[last_tab_id].setBackground(background(botmButnColor,botmButnBorderColor))
        end
      layout_ids.list.smoothScrollToPosition(0)
      end
    }

    table.insert(layout[2], butn)
  end

  return layout
end

--主布局
local layout = {
  LinearLayout,
  id="main",
  orientation=1,
  layout_height=keyboard_height,
  layout_width=-1,
  BackgroundColor=0x000000,
  {LinearLayout,
    id="se",
    orientation=1,
    layout_height=keyboard_height-botmButmHeight,
    {LinearLayout,
      layout_width="match_parent",
      Orientation=0,
      {GridView,
        id="list",
        numColumns=4,
        layout_width="80%w"},
      getSideKeys()
    }
  },
  getBottomKeys()
}
layout=loadlayout(layout, layout_ids)

genContentList()

layout_ids.list.Adapter=adp

layout_ids.list.onItemClick=function(l,v,p,i)
  local s=data[p+1].text.Text
  service.commitText(s)
end

if curr_tab_id~="" then
  layout_ids[curr_tab_id].setBackground(background(cliedBotmButnColor,botmButnBorderColor))
  --print("clicked")
end

service.setKeyboard(layout)