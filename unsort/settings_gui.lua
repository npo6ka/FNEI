local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

local general_gui_name = "main-flow"
local content_gui_name = "content_table"

function SettingsGui.is_gui_open()
  local val = Gui.get_gui(Player.get().gui.center, SettingsGui.name, general_gui_name)
  return next(val) ~= nil
end

function SettingsGui.open_window()
  SettingsGui.close_window()

  local cur_gui = Player.get().gui.center
  local ret_gui = Gui.addFlow(cur_gui, SettingsGui.name, general_gui_name, "fnei_recipe_flow")
  cur_gui = Gui.addFrame(ret_gui, SettingsGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, SettingsGui.name, "main-table", "fnei_recipe_main_table", 1)

  SettingsGui.add_header(cur_gui)
  SettingsGui.add_settings_frame(cur_gui)

  return ret_gui
end

function SettingsGui.close_window()
  if SettingsGui.is_gui_open() then
    Gui.get_gui(Player.get().gui.center, SettingsGui.name, general_gui_name).destroy()
    Events.remove_gui_events(SettingsGui.name)
  end
end

function SettingsGui.add_header(parent)
  parent = Gui.addFrame(parent, SettingsGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, SettingsGui.name, "header-table", "fnei_recipe_header_table", 5)  
  Gui.addLabel(parent, SettingsGui.name, "header-label", "fnei_option_label", {"fnei.options"})
  Gui.addSpriteButton(parent, SettingsGui.name, "back-key", "fnei_back_button_style", {"fnei.back-key"}, Controller.back_key_event)
  Gui.addSpriteButton(parent, SettingsGui.name, "exit-key", "fnei_exit_button_style", {"fnei.exit-key"}, Controller.main_key_event)
end

function SettingsGui.add_settings_frame(parent)
  local content = Gui.addFrame(parent, SettingsGui.name, "content-frame", "fnei_recipe_header_frame", "horizontal")
  Gui.addTable(content, SettingsGui.name, content_gui_name, nil, 2)
end

function SettingsGui.add_option_in_gui(sett)
  local gui = Gui.get_gui(Player.get().gui.center, SettingsGui.name, content_gui_name)

  if not gui then
    out("Error in function SettingsGui.add_option_in_gui: gui == nil")
    return
  end

  sett.elem.add_label_func(gui, SettingsGui.name, sett)
  sett.elem.add_content_func(gui, SettingsGui.name, sett)

end

return SettingsGui