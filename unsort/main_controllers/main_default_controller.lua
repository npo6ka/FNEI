local DefaultMainController = {
  classname = "FNDefaultMainController",
}

function DefaultMainController.open_craft_item(event)
  --Controller.open_event("recipe")
  out("DefaultMainController.open_craft_item")
end

function DefaultMainController.open_craft_fluid(event)
  --out(Tabs.get_cur_tab(tab_name))
  out("DefaultMainController.open_craft_fluid")
end

function DefaultMainController.open_usage_item(event)
  -- out("set new list")
  -- pages:set_page_list({"a", "b", "c", "d", "e"})
  -- out(pages:amount_page())
  -- out(pages:get_cur_page())

  -- local gui = Gui.get_gui(Gui.get_pos(), "cont-flow")
  -- pages:draw_forward_arrow( gui )
  -- pages:draw_back_arrow( gui )
  out("DefaultMainController.open_usage_item")
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