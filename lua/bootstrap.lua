require('global')
charset_comment_filter = require("charset_comment_filter") --Unicode分区提示
tiger_core2022 = require("tiger_core2022_filter") --自定义字符集过滤（常用字集）
core092_filter = require('092core')
dz_ci = require("dz_ci_filter") --单字模式 这个别用，有问题的
number_translator = require("number")
lua_unicode_display_filter = require("unicode_display")  --Unicode编码提示
calculator_translator = require("calculator_translator")  --简易计算器
exe_processor = require("exe")  -- 网页启动器
shijian2_translator = require("shijian2") -- 高级时间
unicode_input_translator = require("unicode_input") -- Unicode输入
reselect_candidates_processor = require("reselect_candidates") -- Ctrl+Space撤销并重新选重
cancel_input_processor = require('cancel_input') -- 防止空码时把编码上屏
info_translator = require("info_translator") -- 显示信息
require("alphabet_mode") -- 字母模式 alphabet_mode_processor, alphabet_mode_translator, alphabet_mode_post_speller_processor
enter_clear_input_processor = require('enter_clear_input')
require('short_punct_pre_speller_processor') -- 使用引号键输入快符，自动上屏
sys_env_translator = require('sys_env')
help_translator = require('help')
preedit_candidate_filter = require('preedit_candidate_filter')
log_processor = require('log_processor')
filter_092chaifen = require('092chaifen')
