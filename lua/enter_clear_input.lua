local function processor(key, env)
    local context = env.engine.context
    if not _G.in_alphabet_mode and key:repr() == 'Return' and context:is_composing() then
        context:clear()
        return Accepted
    end
    return Noop
end

return processor