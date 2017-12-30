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
  end
end

function Controller.open_event(controller_name)
  prev_cont = cur_cont
  cur_cont = controllers[controller_name]
  cur_cont.open()
end

function Controller.back_key_event()
  if cur_cont and cur_cont.back_key() then
    Controller.back_gui_event()
  end
end

function Controller.back_gui_event()
  Controller.exit_event()

  if prev_cont then
    Controller.open_event(prev_cont.name)
    prev_cont = nil
  end
end

function Controller.main_key_event()
  if cur_cont then
    Controller.exit_event()
    prev_cont = nil
  else
    Controller.open_event(controllers.settings.get_name())
  end
end

return Controller