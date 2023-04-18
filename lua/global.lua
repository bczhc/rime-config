_G.Rejected, _G.Accepted, _G.Noop = 0, 1, 2
_G.kRejected, _G.kAccepted, _G.kNoop = 0, 1, 2
require('lib')

ENABLE_MY_LOG = true

function table_to_iter(table)
    local i = 0
    return function()
        i = i + 1
        return table[i]
    end
end

function unicode_chars(text)
    local table = {}
    for _, cp in utf8.codes(text) do
        local c = utf8.char(cp)
        table[#table + 1] = c
    end
    return table_to_iter(table)
end
