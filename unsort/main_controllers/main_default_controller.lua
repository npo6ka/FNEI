local DefaultMainController = {
  classname = "FNDefaultMainController",
}

local cont_gui

function DefaultMainController.init_event(gui_name, content_gui)
  cont_gui = content_gui
end

function DefaultMainController.draw_content()
  cont_gui.set_choose_but_val()
  DefaultMainController.set_checkbox_val()
end

function DefaultMainController.set_item(event, name)
  if not event.button then
    Player.get_global().main_choose_button_item = event.element.elem_value

    if Settings.get_val("item-auto-craft") then
      DefaultMainController.open_craft_item(event)
    elseif Settings.get_val("item-auto-usage") then
      DefaultMainController.open_usage_item(event)
    end
  end
end

function DefaultMainController.set_fluid(event, name)
  if not event.button then
    Player.get_global().main_choose_button_fluid = event.element.elem_value

    if Settings.get_val("fluid-auto-craft") then
      DefaultMainController.open_craft_fluid(event)
    elseif Settings.get_val("fluid-auto-usage") then
      DefaultMainController.open_craft_fluid(event)
    end
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
  local contr = Controller.get_cont("recipe")

  if choose_but and choose_but.elem_value then
    contr.add_element_in_new_queue("craft", "item", choose_but.elem_value)
    Controller.open_event("recipe")
  end
end

function DefaultMainController.open_usage_item(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-item")
  local contr = Controller.get_cont("recipe")

  if choose_but and choose_but.elem_value then
    contr.add_element_in_new_queue("usage", "item", choose_but.elem_value)
    Controller.open_event("recipe")
  end
end

function DefaultMainController.open_craft_fluid(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-fluid")
  local contr = Controller.get_cont("recipe")
  
  if choose_but and choose_but.elem_value then
    contr.add_element_in_new_queue("craft", "fluid", choose_but.elem_value)
    Controller.open_event("recipe")
  end
end

function DefaultMainController.open_usage_fluid(event)
  local choose_but = Gui.get_gui(Gui.get_pos(), "choose-fluid")
  local contr = Controller.get_cont("recipe")
  
  if choose_but and choose_but.elem_value then
    contr.add_element_in_new_queue("usage", "fluid", choose_but.elem_value)
    Controller.open_event("recipe")
  end
end

function DefaultMainController.set_checkbox_val()
  cont_gui.set_checkbox_val(  Settings.get_val("item-auto-craft"),
                              Settings.get_val("item-auto-usage"),
                              Settings.get_val("fluid-auto-craft"),
                              Settings.get_val("fluid-auto-usage"))
end

function DefaultMainController.item_craft_checkbox_event(event)
  DefaultMainController.set_action("item-auto-craft", "item-auto-usage", event and event.element.state)
  DefaultMainController.set_checkbox_val()
end

function DefaultMainController.item_usage_checkbox_event(event)
  DefaultMainController.set_action("item-auto-usage", "item-auto-craft", event and event.element.state)
  DefaultMainController.set_checkbox_val()
end

function DefaultMainController.fluid_craft_checkbox_event(event)
  DefaultMainController.set_action("fluid-auto-craft", "fluid-auto-usage", event and event.element.state)
  DefaultMainController.set_checkbox_val()
end

function DefaultMainController.fluid_usage_checkbox_event(event)
  DefaultMainController.set_action("fluid-auto-usage", "fluid-auto-craft", event and event.element.state)
  DefaultMainController.set_checkbox_val()
end

function DefaultMainController.set_action(src_set_name, sup_set_name, elem_val)
  local sup_val = Settings.get_val(sup_set_name)

  if elem_val and sup_val then
    Settings.set_val(sup_set_name, false)
  end

  Settings.set_val(src_set_name, elem_val)
end

return DefaultMainController