local punct_db
local apostrophe_pressed = false
local long_press_used = false

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
    local repr = key:repr()
    if repr == 'apostrophe' then
        apostrophe_pressed = true
    elseif repr == 'Release+apostrophe' then
        apostrophe_pressed = false
    end

    if repr == 'Release+apostrophe' and long_press_used then
        context.input = ''
        long_press_used = false
        return kAccepted
    end

    if context.input == '\'' then
        -- 长按撇号时需拦截住
        if repr == 'apostrophe' then
            return kAccepted
        end

        if repr:match('^[a-z]$') then
            local punct = punct_db:lookup(key:repr())
            if punct == nil then
                return kNoop
            end
            env.engine:commit_text(punct)
            if apostrophe_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == 'space' then
            local history = get_commit_history(context, 0)
            if history ~= nil then
                env.engine:commit_text(history)
            end

            if apostrophe_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == 'Multi_key' then
            local history = get_commit_history(context, -1)
            if history ~= nil then
                env.engine:commit_text(history)
            end

            if apostrophe_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
    end
    return kNoop
end

_G.short_punct_pre_speller_processor = processor_pre_speller
_G.short_punct_pre_recognizer_processor = {
    init = function(_)
        punct_db = ReverseDb("build/short_punct.reverse.bin")
    end,
    func = processor_pre_recognizer
}
