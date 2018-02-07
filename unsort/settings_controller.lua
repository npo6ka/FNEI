local SettingsController = {
  classname = "FNSettingsController",
}

local SettingsGui = require "unsort/settings_gui"
local tabs = "sett-tabs"

function SettingsController.exit()
  out("settings exit")
  SettingsGui.close_window()
end

function SettingsController.open()
  out("settings open")

  local ret_gui = SettingsGui.open_window()
  SettingsGui.draw_tabs(tabs)
  SettingsController.draw_settings()

  return ret_gui
end

function SettingsController.draw_settings()
  SettingsGui.add_option_list(Settings.get_sett_list(), tabs:get_cur_tab())
end

function SettingsController.back_key()
  return true
end

function SettingsController.can_open_gui()
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

function SettingsController.new_gui_location(event, sett_name)
  if not event.button then
    local index = event.element.selected_index
    Controller.close_event()
    Settings.set_val(sett_name, index)
    Controller.open_event("settings")
  end
end

function SettingsController.set_new_tab_event(event, gui_name)
  SettingsController.draw_settings(tabs:get_cur_tab())
end

function SettingsController.init_events()
  SettingsGui.init_events()
  Settings.init_events()
  tabs = Tabs:new(tabs, SettingsGui.name, {"main-settings", "crafting-category", "admin-settings"}, "fnei_settings_selected-tab", "fnei_settings_empty-tab", SettingsController.set_new_tab_event)
end

return SettingsController