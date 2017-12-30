if not fnei then fnei = {} end

-------------- include Class libs ----------------
require "core/Class"
-------------- include Debug libs ----------------
require "core/Debug"
function out(...)
  local arg = {...}
  Debug:info("debug.info", unpack(arg))
end

-------------- include DefaultLibs ---------------

Player = require "unsort.player"
Gui = require "unsort/gui"
Controller = require "unsort/controller"
Events = require "unsort/events"

Events:init()