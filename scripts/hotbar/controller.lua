local HotbarController = {
  classname = "FNHotbarController",
}

local HotbarGui = require "scripts/hotbar/gui"
local favorite = "fav_arr"
local last_usage = "last_arr"

function HotbarController.init_events()
  favorite = Array:new(favorite)
  last_usage = Array:new(last_usage)

  HotbarGui.init_events()
  Events.add_custom_event(HotbarGui.name, "button", "hide-button", HotbarController.change_recipe_visibility)
end

function HotbarController.exit()
  out("hotbar exit")

  Controller.set_cur_con_name("hotbar")

  HotbarGui.close_window()
  
  Controller.remove_last_con_name()
end

function HotbarController.open()
  out("hotbar open")

  if Settings.get_val("show-hotbar") then
    Controller.set_cur_con_name("hotbar")

    local ret_gui = HotbarGui.open_window()
    HotbarGui.draw_hotbar_bar_extension(favorite)
    
    Controller.remove_last_con_name()

    return ret_gui
  else 
    HotbarController.exit()
  end
end

function HotbarController.back_key()
  return false
end

function HotbarController.can_open_gui()
  return true
end

function HotbarController.get_name()
  return HotbarGui.name
end

function HotbarController.get_favorite_recipe_state(recipe)
  return favorite:get_elem_pos(recipe) ~= nil
end

function HotbarController.change_favorite_recipe_state(recipe)
  if HotbarController.get_favorite_recipe_state(recipe) then
    favorite:remove(favorite:get_elem_pos(recipe))
    HotbarController.open()
  else
    local slot = favorite:get_first_free_slot( )

    if slot > Settings.get_val("hotbar-line-num") then
      Player.print({ "fnei.favorite_is_full" })
    else
      favorite:insert(recipe, slot)
      HotbarController.open()
    end
  end
end


----------------------------------- evenets -----------------------------------

function HotbarController.change_recipe_visibility(event)
  local setting = "show-extended-hotbar"
  local val = not Settings.get_val(setting)
  Settings.set_val(setting, val)

  HotbarController.open()
end

function HotbarController.change_hotbar_visibility(event)
  HotbarController.open()
end



return HotbarController