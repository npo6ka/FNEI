local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"

function MainController.exit()
  out(MainGui)
  MainGui.close_window()
end

function MainController.open()
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

return MainController