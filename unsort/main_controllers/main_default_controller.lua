local DefaultMainController = {
  classname = "FNDefaultMainController",
}

local cont_gui

function DefaultMainController.init_event(gui_name, content_gui)
  cont_gui = content_gui
end

function DefaultMainController.draw_content()
  cont_gui.set_choose_but_val()
end

function DefaultMainController.set_item(event, name)
  if not event.button then
    Player.get_global().main_choose_button_item = event.element.elem_value
  end
end

function DefaultMainController.set_fluid(event, name)
  if not event.button then
    Player.get_global().main_choose_button_fluid = event.element.elem_value
  end
end

function DefaultMainController.get_item()
  return Player.get_global().main_choose_button_item
end

function DefaultMainController.get_fluid()
  return Player.get_global().main_choose_button_fluid
end

function DefaultMainController.open_craft_item(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-item")

  if choose_but and choose_but.elem_value then
    Controller.open_event("recipe", { type = "craft", name = choose_but.elem_value})
  end
end

function DefaultMainController.open_usage_item(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-item")
  
  if choose_but and choose_but.elem_value then
    Controller.open_event("recipe", { type = "usage", name = choose_but.elem_value})
  end
end

function DefaultMainController.open_craft_fluid(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-fluid")
  
  if choose_but and choose_but.elem_value then
    Controller.open_event("recipe", { type = "craft", name = choose_but.elem_value})
  end
end

function DefaultMainController.open_usage_fluid(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-fluid")
  
  if choose_but and choose_but.elem_value then
    Controller.open_event("recipe", { type = "usage", name = choose_but.elem_value})
  end
end

return DefaultMainController