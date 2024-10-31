local GlobCheckBoxSett = {
  classname = "FNGlobCheckBoxSett",
}

function GlobCheckBoxSett.get_val(setting)
  local storage_set = storage.fnei

  if storage_set[setting.name] == nil then
    storage_set[setting.name] = setting.def_val
  end

  return storage_set[setting.name]
end

function GlobCheckBoxSett.set_val(setting, val)
  storage.fnei[setting.name] = val
end

function GlobCheckBoxSett.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_settings_param-label", caption = {"fnei." .. sett.name} })
end

function GlobCheckBoxSett.add_content_func(parent, sett)
  Gui.add_checkbox(parent, { type = "checkbox", name = sett.name, state = Settings.get_val(sett.name) or false })
end

function GlobCheckBoxSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.state)
end

function GlobCheckBoxSett.event_init(sett)
  if sett.def_event ~= false then
    Events.add_custom_event(Controller.get_cont("settings").get_name(), "checkbox", sett.name, GlobCheckBoxSett.event)
  end
  if sett.event then
    Events.add_custom_event(Controller.get_cont("settings").get_name(), "checkbox", sett.name, sett.event)
  end
end

return GlobCheckBoxSett