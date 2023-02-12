--[[
说明:
unicode display filter
字符转Unicode码滤镜

2022年11月9日 Shitlime

使用步骤：
0. 在rime.lua添加如下一行：
lua_unicode_display_filter = require("unicode_display")  -- unicode显示滤镜

1. 在方案“filters: #过滤器”中添加如下一行:
    - lua_filter@lua_unicode_display_filter #lua unicode显示滤镜

2. 在方案“switches: #开关”中添加名为udpf_switch的开关,对本滤镜进行控制:
例:
  - name: udpf_switch
      reset: 1
      states: [ 無, U]
其中,reset指定是否默认开启,1是默认开启,0默认关闭,若常用可以默认开启
]]--

--TEST
--[[
    local path1 = debug.getinfo(1, "S").source:sub(2):sub(0, -9)--获取本lua插件根目录
    --sm(path1)--DEBUG
    local function sm(data)--save DEBUG message
        local f = io.open(path1.."DEBUGmsg.txt", "a+")
        io.output(f)
        io.write(data.."\n")
        io.close(f)
    end
]]

local function C2U(char)
    local unicode_d = utf8.codepoint(char)
    local unicode_h = string.format('%04X', unicode_d)
    --DEBUG
    --    sm("C2U char="..char)
    --    sm("C2U d="..unicode_d)
    --    sm("C2U h="..unicode_h)
    return unicode_h
end

local function unicode_display_filter(input, env)
    local context = env.engine.context
    local input_text = context.input
    local udpf_switch = context:get_option("udpf_switch")

    for cand in input:iter() do
        if udpf_switch then
            local text = cand.text
            local codepoints = {}
            for _, c in utf8.codes(text) do
                local char = utf8.char(c)
                codepoints[#codepoints + 1] = 'U+' .. C2U(char)
            end
            local comment = '[' .. table.concat(codepoints, ' ') .. ']'
            cand:get_genuine().comment = comment
        end
        yield(cand)
    end  --for
end

return unicode_display_filter