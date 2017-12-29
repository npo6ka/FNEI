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
--[[Force = require "utils/fnei_force"
RawTech = require "utils/fnei_raw_technologies"
Recipe = require "utils/fnei_recipe_list"
Item = require "utils/fnei_items"
CraftCategoty = require "utils/fnei_crafting_category_list"]]

Events = require "unsort/events"

Events:init()