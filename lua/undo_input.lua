local length_stack = create_fixed_length_stack(20)

local function execute_backspace(n)
    if type(n) == "number" and n > 0 then
        local command = string.format("xdotool key --repeat %d BackSpace", n)
        os.execute(command)
    else
        print("Invalid input. Please provide a positive number.")
    end
end

local function undo()
    local length = length_stack:pop()
    if length ~= nil then
        my_dbg("Undo length: " .. tostring(length))
        execute_backspace(length)
    else
        my_log('Empty undo stack')
    end
end

return {
    init = function (env)
        local ctx = env.engine.context
        ctx.commit_notifier:connect(function(c)
            local commit_text = c:get_commit_text()
            local length = utf8.len(commit_text)
            length_stack:push(length)
            my_dbg("Undo stack: " .. length_stack:format_debug())
        end)
    end,
    func = undo,
    prepare_undo = false,
}
