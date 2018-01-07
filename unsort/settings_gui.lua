local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

local general_gui_name = "main-flow"
local tab_flow_name = "tabs-flow"
local content_gui_name = "content_table"

function SettingsGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), general_gui_name)
  if next(val) and val.valid then
    return true
  else
    return false
  end
end

function SettingsGui.open_window()
  SettingsGui.close_window()

  local cur_gui = Gui.get_pos()
  local ret_gui = Gui.addFlow(cur_gui, SettingsGui.name, general_gui_name, "fnei_recipe_flow")
  cur_gui = Gui.addFrame(ret_gui, SettingsGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, SettingsGui.name, "main-table", "fnei_recipe_main_table", 1)

  SettingsGui.add_header(cur_gui)
  SettingsGui.drow_tabs(cur_gui)
  SettingsGui.add_settings_frame(cur_gui)

  return ret_gui
end

function SettingsGui.close_window()
  if SettingsGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), general_gui_name).destroy()
    Events.remove_gui_events(SettingsGui.name)
  end
end

function SettingsGui.add_header(parent)
  parent = Gui.addFrame(parent, SettingsGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, SettingsGui.name, "header-table", "fnei_recipe_header_table", 3)
  Gui.addLabel(parent, SettingsGui.name, "header-label", "fnei_option_label", {"fnei.options"})
  Gui.addSpriteButton(parent, { name = "back-key", style = "fnei_back_button_style", tooltip = {"fnei.back-key"} }, Controller.back_key_event)
  Gui.addSpriteButton(parent, { name = "exit-key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"} }, Controller.main_key_event)
end

function SettingsGui.drow_tabs(parent)
  local tabs_flow = parent[tab_flow_name]
  local contr = Controller.get_cur_con()

  if tabs_flow and tabs_flow.valid then
    tabs_flow.destroy()
  end
  tabs_flow = Gui.addFlow(parent, SettingsGui.name, tab_flow_name)  
  Gui.addSpriteButton(tabs_flow, { name = "main-settings", style = SettingsGui.get_tab_style(contr, "main-settings"), tooltip = "?main settings", caption = "?main settings" }, contr.set_new_tab_event)
  Gui.addSpriteButton(tabs_flow, { name = "crafting-category", style = SettingsGui.get_tab_style(contr, "crafting-category"), tooltip = "?crafting category", caption = "?crafting category" }, contr.set_new_tab_event)
  Gui.addSpriteButton(tabs_flow, { name = "admin-settings", style = SettingsGui.get_tab_style(contr, "admin-settings"), tooltip = "?admin settings", caption = "?admin settings" }, contr.set_new_tab_event)
end

function SettingsGui.get_tab_style( contr, tab_name )
  if contr.is_cur_tab(tab_name) then
    return "fnei_selected_tab_button_style"
  else
    return "fnei_empty_tab_button_style"
  end
end

function SettingsGui.add_settings_frame(parent)

  content = Gui.addFrame(parent, SettingsGui.name, "content-frame", "fnei_recipe_header_frame", "horizontal")
  Gui.addTable(content, SettingsGui.name, content_gui_name, nil, 2)

end

function SettingsGui.add_option_in_gui(sett)
  local gui = Gui.get_gui(Gui.get_pos(), content_gui_name)

  if not gui then
    out("Error in function SettingsGui.add_option_in_gui: gui == nil")
    return
  end

  sett.elem.add_label_func(gui, SettingsGui.name, sett)
  sett.elem.add_content_func(gui, SettingsGui.name, sett)

end

return SettingsGui