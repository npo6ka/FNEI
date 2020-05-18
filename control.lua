if not fnei then fnei = {} end
if not global.fnei then global.fnei = {} end

-------------- include Class libs ----------------
require "core/Class"

-------------- include Debug libs ----------------
Debug = require "core/Debug"
function out(...)
  local arg = {...}
  Debug:debug("debug.info", unpack(arg))
end

-------------- include other libs ---------------
require "mod-gui"

-------------- include Default FNEI Libs ---------------
require "utils/data_wrapper"
require "utils/utils"
require "scripts/player"
require "utils/tabs/tabs"
require "utils/paging"
require "utils/list"
require "utils/array"
require "utils/open_tech_hook"
require "scripts/events"
require "scripts/remote"

require "scripts/controller"

require "scripts/gui"

require "scripts/settings/settings"

Settings.init()
Events:init()
Remote:init()