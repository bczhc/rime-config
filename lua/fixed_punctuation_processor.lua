--- A workaround to https://github.com/rime/librime/issues/1049.
local function processor(key, env)
    local repr = key:repr()
    local engine = env.engine
    local context = engine.context

    if repr == "period" then
        context:commit()
        engine:commit_text("。")
        return kAccepted
    end
    if repr == "Shift+colon" then
        context:commit()
        engine:commit_text("：")
        return kAccepted
    end

    return kNoop
end

return processor