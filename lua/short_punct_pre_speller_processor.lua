local punct_db

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

local function processor_pre_recognizer(key, env)
    local context = env.engine.context
    if context.input == '\'' and key:repr():match('^[a-z]$') then
        local punct = punct_db:lookup(key:repr())
        if punct == nil then
            return kNoop
        end
        env.engine:commit_text(punct)
        context.input = ''
        return kAccepted
    end
    return kNoop
end

_G.short_punct_pre_speller_processor = processor_pre_speller
_G.short_punct_pre_recognizer_processor = {
    init = function(env)
        punct_db = ReverseDb("build/short_punct.reverse.bin")
    end,
    func = processor_pre_recognizer
}
