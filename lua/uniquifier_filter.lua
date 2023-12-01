local function filter(input, env)
    local hash = {}
    for c in input:iter() do
        local text = c.text
        if (not hash[text]) then
            yield(c)
            hash[text] = true
        end
    end
end

return filter
