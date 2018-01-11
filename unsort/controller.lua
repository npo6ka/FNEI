local Controller = {
  classname = "FNPlayer"
}

local controllers = {
  main = require "unsort/main_controller",
  recipe = require "unsort/recipe_controller",
  settings = require "unsort/settings_controller",
}

function Controller.get_cont(name)
  if controllers[name] then
    return controllers[name]
  else
    out("controller name: ", name, " not found")
  end
end

function Controller.get_cur_con()
  local pl_global = Player.get_global()

  return pl_global.cur_cont
end

function Controller.get_cur_con_name()
  local cont = Controller.get_cur_con()

  if cont then
    return  cont.get_name()
  end
  return nil
end

function Controller.set_cur_cont(cont)
  Player.get_global().cur_cont = cont
end

function Controller.get_con_queue()
  local pl_global = Player.get_global()

  if not pl_global.con_queue then pl_global.con_queue = {} end
  return pl_global.con_queue
end

function Controller.get_first_con_in_queue()
  return Controller.get_con_queue()[1]
end

function Controller.add_con_in_queue(cont)
  if cont then
    table.insert(Controller.get_con_queue(), cont)
  end
end

function Controller.remove_first_con_in_queue()
  table.remove(Controller.get_con_queue(), 1)
end

function Controller.remove_all_con_in_queue()
  local queue = Controller.get_con_queue()
  queue = {}
end




function Controller.exit_event()
  local cur_cont = Controller.get_cur_con()

  if cur_cont then
    cur_cont.exit()
    Controller.set_cur_cont(nil)
    Player.get().opened = nil
  end
end

function Controller.open_event(controller, args)
  local cur_cont = Controller.get_cur_con()

  if cur_cont then
    Controller.add_con_in_queue(cur_cont)
    Controller.exit_event()
  end
  Controller.set_cur_cont(controller)
  Player.get().opened = controller.open(args)
end

function Controller.back_key_event()
  local cur_cont = Controller.get_cur_con()

  if cur_cont and cur_cont.back_key() then
    Controller.back_gui_event()
  end
end

function Controller.back_gui_event()
  local prev_cont = Controller.get_first_con_in_queue()
  Controller.exit_event()

  if prev_cont then
    Controller.open_event(prev_cont)
    Controller.remove_first_con_in_queue()
  end
end

function Controller.main_key_event()
  local cur_cont = Controller.get_cur_con()

  if cur_cont then
    Controller.exit_event()
    Controller.remove_all_con_in_queue()
  else
    Controller.open_event(Controller.get_cont("main"))
  end
end

return Controller