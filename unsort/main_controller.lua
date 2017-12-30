local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"

function MainController.exit()
  out("Main exit")
end

function MainController.open()
  out("Main open")
end

function MainController.back_key()
  out("Main back")
  return true
end

function MainController.get_name()
  return MainGui.name
end

return MainController