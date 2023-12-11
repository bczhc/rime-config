local function processor(key, env)
    local repr = key:repr()
    local context = env.engine.context

    if not context:has_menu() then
        return kNoop
    end

    if repr == 'Left' or repr == 'Right' then
        return kAccepted
    end
    return kNoop
end

return processor
