function buildArray(...)
    local arr = {}
    for v in ... do
        arr[#arr + 1] = v
    end
    return arr
end

--- `pos` is like: 0, -1, -2, to refer to the items from back to front
function get_commit_history(context, pos)
    local commit_history = context.commit_history:to_table()
    local history = commit_history[#commit_history + pos]
    if history == nil then
        return nil
    end
    return history.text
end

MY_LOG_TAG = '[bczhc log]'

function my_log(msg)
    if ENABLE_MY_LOG then
        log.info(MY_LOG_TAG .. ' ' .. msg)
    end
end

function my_log_on_commit(text)
    my_log('Commit(text=' .. text .. ')')
end

function iter(table)
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
    return table
end

function unique(table)
    local hash = {}
    local res = {}

    for _, v in ipairs(table) do
        if (not hash[v]) then
            res[#res + 1] = v
            hash[v] = true
        end
    end
    return res
end

function iter_to_table(iter)
    local table = {}
    for x in iter do
        table[#table + 1] = x
    end
    return table
end
