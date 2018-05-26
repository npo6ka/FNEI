local HotbarController = {
  classname = "FNHotbarController",
}

local HotbarGui = require "scripts/hotbar/gui"

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

function HotbarController.init_events()
  HotbarGui.init_events()
end

return HotbarController