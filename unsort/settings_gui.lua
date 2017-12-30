local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

function SettingsGui.open_window()
  local cur_gui = Player.get().gui.center
  cur_gui = Gui.addFlow(cur_gui, SettingsGui.name, "main-flow", "fnei_recipe_flow")
  cur_gui = Gui.addFrame(cur_gui, SettingsGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, SettingsGui.name, "main-table", "fnei_recipe_main_table", 1)  

  SettingsGui.add_header(cur_gui)
end

function SettingsGui.add_header(parent)
  parent = Gui.addFrame(parent, SettingsGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, SettingsGui.name, "header-table", "fnei_recipe_header_table", 5)  
  Gui.addLabel(parent, SettingsGui.name, "header-label", "fnei_option_label", {"fnei.options"})
  Gui.addSpriteButton(parent, SettingsGui.name, "back_key", "fnei_back_button_style", {"fnei.back-key"}, Controller.back_key_event)
  Gui.addSpriteButton(parent, SettingsGui.name, "exit_key", "fnei_exit_button_style", {"fnei.exit-key"}, Controller.main_key_event)
end

return SettingsGui