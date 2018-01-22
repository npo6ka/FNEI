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
require "utils.data_wrapper"
require "unsort.player"
require "unsort/tabs/tabs"
require "unsort/paging"
require "unsort/events"

require "unsort/controller"

require "unsort/gui"

require "unsort/settings"

Settings.init()
Events:init()