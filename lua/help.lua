local help_msg = {
    { '/date和/datem', '日期输入' },
    { '/time', '时间输入' },
    { '/week', '星期输入' },
    { '/cal或/cal+日期', '日历与公历农历互转' },
    { '=+算式', '简易计算器' },
    { '/ts', 'UNIX时间戳' },
    { '/idt', '类ISO8601时间' },
    { '/cdt', '袖珍（纯数字）时间与日期yyyyMMdd或HHmmss的格式' },
    { '/num+数字', '数字转大写' },
    { '/uni+Unicode码点', '输入Unicode' },
    { '/em+name', '输入Emoji' },
    { '/hc+name', '输入HTML命名字符' },
    { '/lt+code', '输入拉丁' },
    { '/info', '显示软件有关信息' },
    { '/env/+name', '显示环境变量' },
    { '/ipa', '云龙国际音标输入' },
    { '/nipa', '输入命名的IPA符加符号' },
    { '/help', '显示帮助' },
    { 'Ctrl+`', '方案选择' },
    { 'Ctrl+O', '繁简转换' },
    { 'Ctrl+Y', '显示Unicode编码' },
    { 'Ctrl+U', '显示Unicode分区' },
    { 'Ctrl+P', '显示拼音' },
    { 'Ctrl+J', '显示拆分' },
    { 'Ctrl+H', '常用字与全字集切换' },
    { 'Ctrl+period', '全半角标点切换' },
    { 'Ctrl+E', 'Emoji开关' },
    { 'Ctrl+D', '单字模式' },
    { 'Ctrl+I', 'preedit为候选' },
    { 'Ctrl+S', '全角半角切换' },
}
return function(input, seg)
    if input == '/help' then
        for _, pair in ipairs(help_msg) do
            yield(Candidate('', seg.start, seg._end, pair[1], pair[2]))
        end
    end
end
