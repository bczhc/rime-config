_G.in_alphabet_mode = false

local function processor(key, env)
    local engine = env.engine
    local context = engine.context

    local repr = key:repr()

    -- pattern: ^[;A-Z]
    if not context:is_composing() and (repr == 'semicolon' or (string.match(repr, '^Shift.[A-Z]$') and string.sub(repr, 6, 6) == '+')) then
        in_alphabet_mode = true
        log.info('in alphabet mode: ' .. tostring(in_alphabet_mode))
        return Noop
    end

    if repr == 'space' and in_alphabet_mode then
        context.input = context.input .. ' '
        return Accepted
    end

    return Noop
end

local function post_processor(key, env)
    local context = env.engine.context

    if in_alphabet_mode and key:repr() == 'Return' then
        context:commit()
        in_alphabet_mode = false
        return Accepted
    end
    return Noop
end

local function translator(input, seg)
    if not input:match('^[;A-Z]') then
        return
    end
    local first = string.sub(input, 1, 1)
    local text = ''
    if first == ';' then
        text = string.sub(input, 2)
    else
        text = input
    end
    if text ~= '' then
        yield(Candidate('', seg.start, seg._end, text, ''))
    end
end

_G.alphabet_mode_processor = processor
_G.alphabet_mode_translator = translator
_G.alphabet_mode_post_speller_processor = post_processor
