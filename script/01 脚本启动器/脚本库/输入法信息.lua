--[[中文输入法（同文无障碍版）

脚本名称：输入法信息
功能：上屏输入法相关信息
版本：1.6
作者：风之漫舞 bj19490007@163.com(不一定及时看到)
改写：星乂尘 1416165041@qq.com

2020.12.05
]]
require "import"
import "android.os.Build"
import "yaml"
import "com.osfans.trime.Rime"
import "com.osfans.trime.Config"

local function app()
  local pm,pkg=service.getPackageManager(),service.getPackageName()
  local Info=pm.getPackageInfo(pkg,0)
  local info=pm.getApplicationInfo(pkg,0)
  return {
    --pkg=pkg,
    name=info.loadLabel(pm),
    --icon=info.loadIcon(pm),
    update=os.date("%y-%m-%d %H:%M",Info.lastUpdateTime//1000),
    ver=Info.versionName}
end
app=app()

local file=Config.get().getTheme()
local theme=yaml.load(io.readall(service.getLuaExtPath("",file..".yaml")))
local 当前主题=theme["name"] or file
local 主题作者=theme["author"] or file

local 速度=service.getSpeed()
速度=速度>0 and 速度 or "暂无统计信息"

local t={"▂▂▂▂▂▂▂▂",
  "\n📟输入法：",app.name,
  "\n🖍版本名：",app.ver,
  "\n📌最近更新：",app.update,
  "\n🖊方案ID：",Rime.getSchemaId(),
  "\n🖋方案名：",Rime.getSchemaName(),
  "\n🎦当前主题：",当前主题,
  "\n🎨主题作者：",主题作者,
  "\n📠打字速度：",速度,
  --"\n✒RIME版本：",Rime.get_librime_version(),
  "\n✒RIME版本：",Rime.get_version(),
  "\n⌨OpenCC版本：",Rime.get_opencc_version(),
  "\n📄Trime版本：",Rime.get_trime_version(),
  "\n📱设备型号：",Build.MODEL,
  "\n🚪SDK版本：",Build.VERSION.SDK,
  "\n🎴系统版本：",Build.VERSION.RELEASE
}

task(120,function()
  service.addCompositions({table.concat(t)})
end)
