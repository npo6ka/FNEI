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

return MainController