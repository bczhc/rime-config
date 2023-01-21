--[[中文输入法 （同文无障碍版）

【今日黄历_修复版】

作者：Air 
日期：2022年01月11日
版本：1.0

调用方式：
将本lua放进以下目录/storage/emulated/0/Android/rime/script

trime.yaml加入：

preset_keys:
  _Keyboard_Color: {label: 黄历, send: function, command: '今日黄历_修复版.lua'}

也可以使用脚本启动器调用
]]


-- 查找函数
local function get_info(f_key, e_key, src_text, START_POS)
    START_POS = START_POS or 1 -- 若没有指定查找起始点,则默认从字符串的第一个字符开始(若f_key为空,则代表直接使用这里的START_POS值)
    local END_POS = #src_text -- 默认的结尾是字符串尾部(用于e_key 参数为空时)

    local is_success = true

    if f_key and f_key ~= "" then
        -- 是否匹配成功
        START_POS = string.find(src_text, f_key, START_POS)
        if START_POS then
            START_POS = START_POS + #f_key
        else
            is_success = false
        end
    end

    if e_key and e_key ~= "" then
        END_POS = string.find(src_text, e_key, START_POS)
        -- 是否匹配成功
        if END_POS then
            END_POS = END_POS - 1
        else
            is_success = false
        end
    end

    if not is_success then
        return nil, nil
    end

    local Res_Text = string.sub(src_text, START_POS, END_POS)
    Res_Text = string.gsub(Res_Text, "&nbsp;", " ")
    -- Res_Text = string.gsub(Res_Text, "<br>", "\n")
    -- Res_Text = string.gsub(Res_Text, "<.->", "")
    -- Res_Text = string.gsub(Res_Text, "&ldquo;", '"')
    -- Res_Text = string.gsub(Res_Text, "&rdquo;", '"')

    return Res_Text, START_POS
end

local URL = "https://www.199ge.com/index.html"

local Res_Text = ""
Http.get(
    URL,
    nil,
    "utf-8",
    nil,
    function(a, b)
        if a == 200 then
            local Text_Table = {}
            local key_word = ""
            local START_POS = 1
            local END_POS = 1
            local Res_Text = ""

            Res_Text, START_POS = get_info('class="weekdays w100 fl">', "</h1>", b)
            Res_Text, _ = get_info("<h1>", "", Res_Text)
            Res_Text = string.gsub(Res_Text, " ", "")
            Res_Text = string.gsub(Res_Text, "\t", "")
            Res_Text = string.gsub(Res_Text, "\n", " ")

            Text_Table["日期"] = Res_Text
            --Res_Text = "▂▂▂▂▂▂▂▂\n今日黄历\n🗓日期: " .. Res_Text

            local key_word = ""
            local table_key_list = {
                "农历",
                "岁次",
                "五行",
                "彭祖百忌",
                "黄道黑道",
                "十二值",
                "元旦已过",
                "今年还剩",
                "宜",
                "忌",
                "冲",
                "胎神占方",
                "回历",
                "五行2",
                "吉神宜趋",
                "凶神宜忌",
                "月相",
                "日月黄经",
                "孟仲季月",
                "九星",
                "禾刀"
            }
            for i, v in pairs(table_key_list) do
                if v == "彭祖百忌" or v == "宜" or v == "禾刀" then
                    key_word = '<font class="should_m">'
                else
                    key_word = "<font>"
                end
                Res_Text, START_POS = get_info(key_word, "</font>", b, START_POS)
                Text_Table[v] = Res_Text
            end

            local should_text = Text_Table["宜"]
            local res_text = ""
            START_POS = 0
            while (true) do
                Res_Text, START_POS = get_info("<a href", "</a>", should_text, START_POS)
                if not Res_Text then
                    break
                end
                Res_Text, _ = get_info(">", "", Res_Text, 0)
                res_text = res_text .. Res_Text .. " "
            end
            Text_Table["宜"] = res_text

            -- 指定要输出的数据\顺序
            local output_key_list = {
                "日期",
                "农历",
                "岁次",
                "五行",
                "宜",
                "忌",
                "今年还剩",
                "元旦已过",
                "彭祖百忌",
                "黄道黑道",
                "十二值",
                "冲",
                "胎神占方",
                "回历",
                "五行2",
                "吉神宜趋",
                "凶神宜忌",
                "月相",
                "日月黄经",
                "孟仲季月",
                "九星",
                "禾刀",
            }

            local output_text = ''
            for i, v in pairs(output_key_list) do
                output_text = string.format("%s\n%d.%s: %s", output_text, i, v, Text_Table[v])
                -- print(i, v)
            end


            task(
                100,
                function()
                    service.addCompositions({output_text})
                end
            )
        else
            print("对不起,你的网络似乎出现了点问题")
        end
    end
)
