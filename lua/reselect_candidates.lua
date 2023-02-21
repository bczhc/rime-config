local Rejected, Accepted, Noop = 0, 1, 2

local input = {}
local commit_notifier_init = false
local last_commit_text = ''
local last_commit_code = ''
local delete = false

local function process(key, env)
    local context = env.engine.context

    if not commit_notifier_init then
        -- initial connection
        commit_notifier_init = true
        context.commit_notifier:connect(function(ctx)
            last_commit_text = ctx:get_commit_text()
            last_commit_code = ctx.input
        end)
    end

    if key:ctrl() and not key:release() and key:repr() == 'Control+space' then
        delete = true
    end
    if key:repr() == 'Control+Release+Control_L' and delete then
        context:clear()

        local t = {}
        last_commit_code:gsub(".", function(c)
            table.insert(t, c)
        end)

        -- TODO: this is a very bad workaround
        --  since I haven't found any rime-lua "backspace" APIs
        local keys = string.rep('BackSpace ', utf8.len(last_commit_text)) .. table.concat(t, ' ')
        local _ = io.popen('xdotool key ' .. keys)
        --context.input = last_commit_code
        delete = false
    end
    return Noop
end

return process