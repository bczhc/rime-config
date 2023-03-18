local function filter(input, env)
    local b = env.engine.context:get_option("preedit_is_candidate")
    for cand in input:iter() do
        if b then
            cand.preedit = cand.text
        end
        yield(cand)
    end
end

return filter
