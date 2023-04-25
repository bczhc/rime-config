local function translator(input, seg, env)
    if not env.engine.context:get_option('extended_char') then
        return
    end

    local query = _092full_chars_db:lookup(input)
    if query ~= '' then
        for w in query:gmatch("%S+") do
            yield(Candidate('', seg.start, seg._end, w, '[U]'))
        end
    end
end

return {
    init = function(_)
        _G._092full_chars_db = ReverseDb("build/092wubi_U.reverse.bin")
    end,
    func = translator
}
