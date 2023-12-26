local punct_db
local short_punct_key_pressed = false
local long_press_used = false

local short_punct_key = 'z'
local short_punct_key_release = 'Release+' .. short_punct_key
local repeat_key = 'space'
local repeat2_key = 'm'
local undo_input_key = 'r'

local undo_input = require('undo_input')

local function processor_pre_speller(key, env)
    local repr = key:repr()
    local context = env.engine.context
    local has_menu = context:has_menu()
    local composing = context:is_composing()
    if repr == short_punct_key and composing and not has_menu then
        context.input = ''
        return kNoop
    end
    if repr == short_punct_key and composing and has_menu then
        context:commit()
    end
    return kNoop
end

local function processor_pre_recognizer(key, env)
    local context = env.engine.context
    local repr = key:repr()

    if repr == 'Release+' .. undo_input_key and undo_input.prepare_undo then
        undo_input.prepare_undo = false
        undo_input.func()
    end

    if repr == short_punct_key then
        short_punct_key_pressed = true
    elseif repr == short_punct_key_release then
        short_punct_key_pressed = false
    end

    if (repr == short_punct_key_release) and long_press_used then
        context.input = ''
        long_press_used = false
        return kAccepted
    end

    if context.input == short_punct_key then
        -- 长按short_punct_key时需拦截住
        if repr == short_punct_key then
            return kAccepted
        end

        if repr ~= repeat_key and repr ~= repeat2_key and repr ~= undo_input_key and repr:match('^[a-z]$') then
            local punct = punct_db:lookup(key:repr())
            if punct == nil then
                return kNoop
            end
            env.engine:commit_text(punct)
            my_log_on_commit(punct)
            if short_punct_key_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == repeat_key then
            local history = get_commit_history(context, 0)
            if history ~= nil then
                env.engine:commit_text(history)
                my_log_on_commit(history)
            end

            if short_punct_key_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == repeat2_key then
            local history = get_commit_history(context, -1)
            if history ~= nil then
                env.engine:commit_text(history)
                my_log_on_commit(history)
            end

            if short_punct_key_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == 'semicolon' then
            i_semicolon = '；'
            env.engine:commit_text(i_semicolon)
            my_log_on_commit(i_semicolon)

            if short_punct_key_pressed then
                long_press_used = true
            else
                context.input = ''
            end
            return kAccepted
        end
        if repr == undo_input_key then
            undo_input.prepare_undo = true
            context.input = ''
            return kAccepted
        end
    end
    return kNoop
end

_G.short_punct_pre_speller_processor = processor_pre_speller
_G.short_punct_pre_recognizer_processor = {
    init = function(env)
        punct_db = ReverseDb("build/short_punct.reverse.bin")
        undo_input.init(env)
    end,
    func = processor_pre_recognizer,
    fini = undo_input.fini,
}
