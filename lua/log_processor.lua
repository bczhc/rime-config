local init_flag = false

local function processor(key, _)
    my_log(
            'Key(code=' .. tostring(key.keycode) .. ', ctrl=' .. tostring(key:ctrl())
                    .. ', shift=' .. tostring(key:shift()) .. ', alt=' .. tostring(key:alt())
                    .. ', caps=' .. tostring(key:caps()) .. ', super=' .. tostring(key:super())
                    .. ', release=' .. tostring(key:release()) .. ', repr=' .. key:repr() .. ')'
    )
    return kNoop
end

return {
    func = processor,
    init = function(env)
        if not init_flag then
            init_flag = true
            env.engine.context.commit_notifier:connect(function(ctx)
                local commit_text = ctx:get_commit_text()
                my_log_on_commit(commit_text)
            end)
        end
    end
}
