local SettingsController = {
  classname = "FNSettingsController",
}

local SettingsGui = require "unsort/settings_gui"

local tab_name = {}
tab_name["main-settings"] = 1
tab_name["crafting-category"] = 2
tab_name["admin-settings"] = 3

function SettingsController.exit()
  out("settings exit")
  SettingsGui.close_window()
end

function SettingsController.open()
  out("settings open")

  local ret_gui = SettingsGui.open_window()
  SettingsController.draw_settings(1)

  return ret_gui
end

function SettingsController.draw_settings(tab_index)
  SettingsGui.add_option_list(Settings.get_sett_list(), tab_index)
end

function SettingsController.back_key()
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

function SettingsController.new_gui_location(event, sett_name)
  if not event.button then
    local index = event.element.selected_index
    Controller.exit_event()
    Settings.set_val(sett_name, index)
    Controller.open_event("settings")
  end
end

function SettingsController.set_new_tab_event(event, gui_name)
  if gui_name and tab_name[gui_name] ~= nil then
    local cur_tab = tab_name[gui_name]
    SettingsGui.change_cur_tab(cur_tab)
    SettingsController.draw_settings(cur_tab)
  end
end

function SettingsController.init_events()
  SettingsGui.init_events()
  Settings.init_events()
end

return SettingsController