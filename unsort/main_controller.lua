local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"
local tab_name = "main-tabs"

function MainController.exit()
  out("Main exit")
  MainGui.close_window()
end

function MainController.open()
  out("Main open")

  local gui = MainGui.open_window()
  MainGui.draw_tabs(tab_name)

  return gui
end

function MainController.back_key()
  return true
end

function MainController.get_name()
  return MainGui.name
end

function MainController.init_events()
  Tabs.new(tab_name, MainGui.name, {"default-search", "fnei-search", "category-search"}, "fnei_settings_selected-tab", "fnei_settings_empty-tab", MainController.change_tab)
  MainGui.init_events()
end



function MainController.open_craft_item(event)
  Controller.open_event("recipe")
end

function MainController.open_craft_fluid(event)
  out(Tabs.get_cur_tab(tab_name))
  
end

function MainController.open_usage_item(event)

end

function MainController.open_usage_fluid(event)

end

function MainController.change_tab(event, name)
  Tabs.set_cur_tab(tab_name, Tabs.get_tab_name(tab_name, name))
  MainGui.draw_tabs(tab_name)
  out(name)
end

return MainController