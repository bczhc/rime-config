local function filter(input, env)
    local context = env.engine.context
    local switch = context:get_option("chaifen")

    for cand in input:iter() do
        if switch then
            local text = cand.text
            for char in iter(unicode_chars(text)) do
                local chaifen_lookup = _G._092chaifen_db:lookup(char)
                local code_lookup = _G._092reverse_db:lookup(char)
                local comment = '[' .. chaifen_lookup .. '·' .. code_lookup .. ']'
                cand:get_genuine().comment = cand.comment .. ' ' .. comment
            end
        end
        yield(cand)
    end
end

return {
    init = function(_)
        _G._092chaifen_db = ReverseDb("build/092chaifen.reverse.bin")
        _G._092reverse_db = ReverseDb("build/092wubi.reverse.bin")
    end,
    func = filter
}


