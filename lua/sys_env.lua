local function translator(input, seg)
    if input:match('^/env/.*$') then
        local name = string.sub(input, 6)
        if name ~= nil then
            local env = os.getenv(name)
            yield(Candidate('', seg.start, seg._end, env, ''))
        end
    end
end

return translator