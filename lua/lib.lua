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
