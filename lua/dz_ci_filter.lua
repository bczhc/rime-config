--    https://github.com/rime/librime/issues/248#issuecomment-468924677
--    單字和字詞切換
local function filter(input, env)
    local enabled = env.engine.context:get_option("dz_ci")
    for cand in input:iter() do
        if (not enabled or utf8.len(cand.text) == 1 or cand.type == "custom" or cand.type == "date") then
            yield(cand)
        end
    end
end

return filter
