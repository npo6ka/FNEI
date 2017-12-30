local SettingsController = {
  classname = "FNSettingsController",
  name = "settings"
}

local SettingsGui = require "unsort/settings_gui"

function SettingsController.exit()
  out("settings exit")
  SettingsGui.close_window()
end

function SettingsController.open()
  out("settings open")
  SettingsGui.open_window()
end

function SettingsController.back_key()
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

return SettingsController