local function processor(key, env)
    local context = env.engine.context
    if key:repr() == 'Return' and context:is_composing() and not check_alphabet_mode(env) then
        context:clear()
        return Accepted
    end
    return Noop
end

return processor