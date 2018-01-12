Controller = {
  classname = "FNPlayer"
}

local controllers = {
  main = require "unsort/main_controller",
  recipe = require "unsort/recipe_controller",
  settings = require "unsort/settings_controller",
}

function Controller.init_events()
  controllers.main.init_events()
  controllers.recipe.init_events()
  controllers.settings.init_events()
end

function Controller.get_cont(name)
  if name and controllers[name] then
    return controllers[name]
  else
    out("controller name: ", name, " not found")
  end
end

function Controller.get_cur_con()
  local con_name = Controller.get_cur_con_name()
  if con_name then
    return Controller.get_cont(con_name)
  end
  return nil
end

function Controller.get_cur_con_name()
  return Player.get_global().cur_cont
end

function Controller.set_cur_cont(cont)
  if cont then
    Player.get_global().cur_cont = cont.get_name()
  else 
    Player.get_global().cur_cont = nil
  end
end

function Controller.get_con_queue()
  local pl_global = Player.get_global()

  if not pl_global.con_queue then pl_global.con_queue = {} end
  return pl_global.con_queue
end

function Controller.get_first_con_name_in_queue()
  return Controller.get_con_queue()[1]
end

function Controller.add_con_in_queue(cont)
  if cont then
    table.insert(Controller.get_con_queue(), cont.get_name())
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

function Controller.open_event(cont_name, args)
  local cur_cont = Controller.get_cur_con()

  if cur_cont then
    Controller.add_con_in_queue(cur_cont)
    Controller.exit_event()
  end
  local controller = Controller.get_cont(cont_name)
  if controller then
    Controller.set_cur_cont(controller)
    Player.get().opened = controller.open(args)
  else
    Debug:error("Error in function Controller.open_event: cont_name ", cont_name, "not found")
  end
end

function Controller.back_key_event()
  local cur_cont = Controller.get_cur_con()

  if cur_cont and cur_cont.back_key() then
    Controller.back_gui_event()
  end
end

function Controller.back_gui_event()
  local prev_cont = Controller.get_first_con_name_in_queue()
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
    Controller.open_event("main")
  end
end