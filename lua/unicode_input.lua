local function translator(input, seg)
    if string.sub(input, 1, 4) ~= "/uni" then
        return
    end

    local unicode = string.sub(input, 5)
    if unicode == '' then
        return
    end

    local codepoint = tonumber(unicode, 16)
    if codepoint == nil or not (codepoint >= 0 and codepoint <= 0x10FFFF) then
        return
    end
    local char = utf8.char(codepoint)
    yield(Candidate('', seg.start, seg._end, char, '字符'))
end

return translator