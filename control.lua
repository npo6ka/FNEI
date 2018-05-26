if not fnei then fnei = {} end
if not global.fnei then global.fnei = {} end

-------------- include Class libs ----------------
require "core/Class"
-------------- include Debug libs ----------------
require "core/Debug"
function out(...)
  local arg = {...}
  Debug:info("debug.info", unpack(arg))
end

-------------- include DefaultLibs ---------------
require "utils/data_wrapper"
require "utils/utils"
require "scripts/player"
require "utils/tabs/tabs"
require "utils/paging"
require "utils/queue"
require "utils/open_tech_hook"
require "scripts/events"

require "scripts/controller"

require "scripts/gui"

require "scripts/settings/settings"

Settings.init()
Events:init()