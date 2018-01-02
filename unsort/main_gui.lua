local MainGui = {
  classname = "FNMainGui",
  name = "main",
}

local general_gui_name = "main-flow"

function MainGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), MainGui.name, general_gui_name)
  return next(val) ~= nil
end

function MainGui.open_window()
  MainGui.close_window()

  local cur_gui = Gui.get_pos()
  local ret_gui = Gui.addFlow(cur_gui, MainGui.name, general_gui_name, "fnei_recipe_flow")
  cur_gui = Gui.addFrame(ret_gui, MainGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, MainGui.name, "main-table", "fnei_recipe_main_table", 1)  

  MainGui.add_header(cur_gui)

  return ret_gui
end

function MainGui.close_window()
  if MainGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), MainGui.name, general_gui_name).destroy()
    Events.remove_gui_events(MainGui.name)
  end
end

function MainGui.add_header(parent)
  parent = Gui.addFrame(parent, MainGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, MainGui.name, "header-table", "fnei_recipe_header_table", 4)

  Gui.addLabel(parent, MainGui.name, "header-label", nil, "Search:")
  Gui.addTextfield(parent, MainGui.name, "search-field", nil, nil, MainGui.search_event)

  Gui.addSpriteButton(parent, MainGui.name, "settings-key", "fnei_settings_button_style", {"fnei.settings-key"}, MainGui.settings_key_event)
  Gui.addSpriteButton(parent, MainGui.name, "exit-key", "fnei_exit_button_style", {"fnei.exit-key"}, Controller.main_key_event)
end

function MainGui.settings_key_event(event)
  Controller.open_event(Controller.get_cont("settings"))
end

function MainGui.search_event(event)
  out(event)
end

return MainGui

-- local buttons = ui.add({type = "flow", name = "fnei_page_line", direction = "horizontal"})

--   buttons.add({type = "sprite-button", name = "fnei_prev_main_page", style = "fnei_left_arrow_button_style"})
--   buttons.add({type = "label", name = "fnei_page_number", caption = "empty_main_page"})
--   buttons.add({type = "sprite-button", name = "fnei_next_main_page", style = "fnei_right_arrow_button_style"})
-- ui.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})