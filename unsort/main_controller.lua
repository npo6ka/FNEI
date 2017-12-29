local MainController = {
  classname = "FNMainController",
  name = "Main"
}

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

return MainController