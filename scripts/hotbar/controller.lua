local HotbarController = {
  classname = "FNHotbarController",
}

local HotbarGui = require "scripts/hotbar/gui"

function HotbarController.init_events()
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


----------------------------------- Settings evenet -----------------------------------

function HotbarController.change_recipe_visibility(event)
  local setting = "show-full-hotbar"
  local val = not Settings.get_val(setting)
  Settings.set_val(setting, val)

  HotbarController.open()
end

function HotbarController.change_hotbar_visibility(event)
  --Settings.set_val("show-hotbar", event.element.state)
  HotbarController.open()

  out("qwe")
end

return HotbarController