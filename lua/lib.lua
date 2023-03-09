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
