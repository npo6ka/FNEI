local DefaultMainController = {
  classname = "FNDefaultMainController",
}

local cont_gui

function DefaultMainController.init_event(gui_name, content_gui)
  cont_gui = content_gui
end

function DefaultMainController.open_craft_item(event)
  get_recipe_list()
  
  --Controller.open_event("recipe")
  out("DefaultMainController.open_craft_item")
end

function DefaultMainController.open_craft_fluid(event)
  out("DefaultMainController.open_craft_fluid")
end

function DefaultMainController.open_usage_item(event)
  out("DefaultMainController.open_usage_item")
end

function DefaultMainController.draw_content()
  cont_gui.set_choose_but_val()
end

function DefaultMainController.open_usage_fluid(event)
  out("DefaultMainController.open_usage_fluid")
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

return DefaultMainController