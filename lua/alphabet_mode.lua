local function translator(input, seg)
    if not input:match('^[;A-Z]') then
        return
    end
    local first = string.sub(input, 1, 1)
    local text = ''
    if first == ';' then
        text = string.sub(input, 2)
    else
        text = input
    end
    if text ~= '' then
        yield(Candidate('', seg.start, seg._end, text, ''))
    end
end

return translator