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

local test = Tabs:new("main", {"maintab1", "maintab2"})

function MainController.open_craft_item(event)
  Controller.open_event("recipe")
end

function MainController.open_craft_fluid(event)
  out(test:get_cur_tab())
  
end

function MainController.open_usage_item(event)
  test:set_cur_tab("maintab1")
end

function MainController.open_usage_fluid(event)
  test:set_cur_tab("maintab2")
end

return MainController