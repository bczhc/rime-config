local function processor_pre_speller(key, env)
    local repr = key:repr()
    local context = env.engine.context
    local has_menu = context:has_menu()
    local composing = context:is_composing()
    if repr == 'apostrophe' and composing and not has_menu then
        context.input = ''
        return kNoop
    end
    if repr == 'apostrophe' and composing and has_menu then
        context:commit()
    end
    return kNoop
end

local function processor_post_speller(key, env)
    local context = env.engine.context
    if context.input:match('^\'[a-z]$') then
        context:commit()
        return kAccepted
    end
    return kNoop
end

_G.short_punct_pre_speller_processor = processor_pre_speller
_G.short_punct_post_speller_processor = processor_post_speller