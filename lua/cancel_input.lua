local Rejected, Accepted, Noop = 0, 1, 2

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
    'semicolon',
}

local function processor(key, env)
    local repr = key:repr()
    local context = env.engine.context
    local has_menu = context:has_menu()
    local composing = context:is_composing()
    local in_key = false

    for i = 1, #reprs do
        if repr == reprs[i] then
            in_key = true
            break
        end
    end

    if in_key and composing and not has_menu then
        context.input = ''
    end
    return Noop
end

return processor
