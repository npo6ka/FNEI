local RecipeGui  = {
  classname = "FNRecipeGui",
  name = "recipe",
}

local general_gui_name = "main-flow"

function RecipeGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), RecipeGui.name, general_gui_name)
  return next(val) ~= nil
end

function RecipeGui.open_window()
  RecipeGui.close_window()

  local cur_gui = Gui.get_pos()
  local ret_gui = Gui.addFlow(cur_gui, RecipeGui.name, general_gui_name, "fnei_recipe_flow")
  cur_gui = Gui.addFrame(ret_gui, RecipeGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, RecipeGui.name, "main-table", "fnei_recipe_main_table", 1)  

  RecipeGui.add_header(cur_gui)

  return ret_gui
end

function RecipeGui.close_window()
  if RecipeGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), RecipeGui.name, general_gui_name).destroy()
    Events.remove_gui_events(RecipeGui.name)
  end
end

function RecipeGui.add_header(parent)
  parent = Gui.addFrame(parent, RecipeGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, RecipeGui.name, "header-table", "fnei_recipe_header_table", 5)
  Gui.addFrame(parent, RecipeGui.name, "header-frame")
  Gui.addLabel(parent, RecipeGui.name, "header-label", "fnei_recipe_title_label", "recipe_name")
  Gui.addSpriteButton(parent, RecipeGui.name, "back-key", "fnei_back_button_style", {"fnei.back-key"}, Controller.back_key_event)
  Gui.addSpriteButton(parent, RecipeGui.name, "settings-key", "fnei_settings_button_style", {"fnei.settings-key"}, RecipeGui.settings_key_event)
  Gui.addSpriteButton(parent, RecipeGui.name, "exit-key", "fnei_exit_button_style", {"fnei.exit-key"}, Controller.main_key_event)
end

function RecipeGui.settings_key_event(event)
  Controller.open_event(Controller.get_cont("settings"))
end

return RecipeGui