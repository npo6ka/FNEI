local GlobCheckBoxSett = {
  classname = "FNGlobCheckBoxSett",
}

function GlobCheckBoxSett.get_val(setting)
  local global_set = global.fnei

  if global_set[setting.name] == nil then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function GlobCheckBoxSett.set_val(setting, val)
  global.fnei[setting.name] = val
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
  local event = sett.event or GlobCheckBoxSett.event
  Events.add_custom_event(Controller.get_cont("settings").get_name(), "checkbox", sett.name, event)
end

return GlobCheckBoxSett