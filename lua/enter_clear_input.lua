local enter_to_commit_tags = {
    'punct',
    'unicode',
    'emoji',
    'html_chars',
    'latin_input',
    'ipa_input',
    'named_ipa_diacritics',
}

local function check_tag(context)
    local composition = context.composition
    if (composition:empty()) then
        return false
    end
    local segment = composition:back()
    for _, x in ipairs(enter_to_commit_tags) do
        if segment:has_tag(x) then
            return true
        end
    end
    return false
end

local function processor(key, env)
    local context = env.engine.context
    if key:repr() ~= 'Return' or not context:is_composing() or check_alphabet_mode(env) then
        return Noop
    end

    if check_tag(context) then
        if context:has_menu() then
            context:commit()
        else
            context:clear()
        end
        return Accepted
    end

    context:clear()
    return Accepted
end

return processor
