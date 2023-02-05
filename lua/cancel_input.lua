local function log(text)
    os.execute('notify-send "' .. text .. '"')
end

local reprs = {
    'comma',
    'period',
    'bracketleft',
    'bracketright',
    'Shift+exclam',
    'Shift+at',
    'Shift+numbersign',
    'Shift+asciicircum',
    'Shift+ampersand',
    'Shift+asterisk',
    'Shift+parenleft',
    'Shift+parenright',
    'Shift+underscore',
    'Shift+plus',
    'Shift+colon',
    'Shift+quotedbl',
    'Shift+question',
}

local function processor(key, env)
    local repr = key:repr()
    local context = env.engine.context
    local has_menu = context:has_menu()

    for i = 1, #reprs do
        if not has_menu and repr == reprs[i] then
            context.input = ''
            break
        end
    end
end

return processor
