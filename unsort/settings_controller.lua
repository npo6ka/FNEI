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
  return ret_gui
end

function SettingsController.back_key()
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

return SettingsController