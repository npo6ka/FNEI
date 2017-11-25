---
-- Description of the module.
-- @module Force
--
local Force = {
  -- single-line comment
  classname = "FNForce"
}

-------------------------------------------------------------------------------
-- check Force exists
--
-- @function [parent=#Force] check
--
-- @param #LuaPlayer
--
-- @return #boolean value
--
function Force.check(player)
  Debug:debug(Force.classname, "Force.check(", player, ")")
  if not player then
    Debug:error(Force.classname, "nil player")
    return false
  end
  if not player.force then
    Debug:error(Force.classname, "nil force")
    return false
  end
  return true
end

-------------------------------------------------------------------------------
-- get LuaForce from LuaPlayer
--
-- @function [parent=#Force] get
--
-- @param #LuaPlayer
--
-- @return #LuaForce or nil
--
function Force.get(player)
  Debug:debug(Force.classname, "Force.get(", player, ")")
  return Force.check(player) and player.force or nil
end

return Force