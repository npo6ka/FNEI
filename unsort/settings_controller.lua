local SettingsController = {
  classname = "FNSettingsController",
}

local SettingsGui = require "unsort/settings_gui"

function SettingsController.exit()
  out("settings exit")
  SettingsGui.close_window()
end

function SettingsController.open()
  out("settings open")
  local ret_gui = SettingsGui.open_window()
  local list = Settings.get_sett_list()

  for name, sett in pairs(list) do
    SettingsGui.add_option_in_gui(sett)
  end

  return ret_gui
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
    Controller.open_event(Controller.get_cont("settings"))
  end
end

return SettingsController