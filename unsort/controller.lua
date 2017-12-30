local Controller = {
  classname = "FNPlayer"
}

local controllers = {
  main = require "unsort/main_controller",
  recipe = require "unsort/recipe_controller",
  settings = require "unsort/settings_controller",
}
local prev_cont = nil
local cur_cont = nil

function Controller.exit_event()
  if cur_cont then
    cur_cont.exit()
    cur_cont = nil
    Player.get().opened = nil
  end
end

function Controller.open_event(controller)
  if cur_cont then
    prev_cont = cur_cont
    Controller.exit_event()
  end
  cur_cont = controller
  Player.get().opened = cur_cont.open()
end

function Controller.back_key_event()
  if cur_cont and cur_cont.back_key() then
    Controller.back_gui_event()
  end
end

function Controller.back_gui_event()
  Controller.exit_event()

  if prev_cont then
    Controller.open_event(prev_cont)
    prev_cont = nil
  end
end

function Controller.main_key_event()
  if cur_cont then
    Controller.exit_event()
    prev_cont = nil
  else
    Controller.open_event(Controller.get_cont("main"))
  end
end

function Controller.get_cont(name)
  out(name)
  if controllers[name] then
    return controllers[name]
  else
    out("controller name: ", name, " not found")
  end
  return nil
end

return Controller