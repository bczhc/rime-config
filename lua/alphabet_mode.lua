local function translator(input, seg)
    if string.sub(input, 1, 1) ~= ";" then
        return
    end
    local content = string.sub(input, 2)
    if content ~= '' then
        yield(Candidate('', seg.start, seg._end, content, ''))
    end
end

return translator