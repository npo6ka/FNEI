local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"

function MainController.exit()
  out("Main exit")
  MainGui.close_window()
end

function MainController.open()
  out("Main open")
  return MainGui.open_window()
end

function MainController.back_key()
  return true
end

function MainController.get_name()
  return MainGui.name
end

function MainController.init_events()
  MainGui.init_events()
end

function MainController.open_craft_item(event)
  
end

function MainController.open_craft_fluid(event)
  
end

function MainController.open_usage_item(event)
  
end

function MainController.open_usage_fluid(event)
  
end

return MainController