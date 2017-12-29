local SettingsController = {
  classname = "FNSettingsController",
  name = "Settings"
}

function SettingsController.exit()
  out("settings exit")
end

function SettingsController.open()
  out("settings open")
end

function SettingsController.back_key()
  out("settings back")
  return true
end

return SettingsController