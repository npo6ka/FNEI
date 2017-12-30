local SettingsController = {
  classname = "FNSettingsController",
  name = "settings"
}

local SettingsGui = require "unsort/settings_gui"

function SettingsController.exit()
  out("settings exit")
end

function SettingsController.open()
  SettingsGui.open_window()
  out("settings open")
end

function SettingsController.back_key()
  out("settings back")
  return true
end

function SettingsController.get_name()
  return SettingsGui.name
end

return SettingsController