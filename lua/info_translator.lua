local function translator(input, seg)
    local yield_candidate = function(value, comment)
        comment = comment == nil and '' or comment
        yield(Candidate('', seg.start, seg._end, value, comment))
    end

    if input == '/info' then
        yield_candidate(rime_api.get_rime_version(), '[librime version]')
        --yield_candidate(tostring(version()), '[librime-lua version]')
        yield_candidate(_VERSION, '[lua version]')
        yield_candidate(rime_api.get_user_data_dir(), '[user data dir]')
        yield_candidate(rime_api.get_distribution_name(), '[distribution name]')
        yield_candidate(rime_api.get_distribution_code_name(), '[distribution code name]')
        yield_candidate(rime_api.get_distribution_version(), '[distribution version]')
    end
end

return translator