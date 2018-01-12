local CheckBoxSett = {
  classname = "FNCheckBoxSett",
}

function CheckBoxSett.get_val(setting)
  local global_set = Settings.get_global_sett()

  if global_set[setting.name] == nil then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function CheckBoxSett.set_val(setting, val)
  Settings.get_global_sett()[setting.name] = val
end

function CheckBoxSett.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_option_param_label", caption = {"fnei." .. sett.name}, tooltip = {"fnei." .. sett.name}})
end

function CheckBoxSett.add_content_func(parent, sett)
  Gui.add_checkbox(parent, { type = "checkbox", name = sett.name, state = Settings.get_val(sett.name) })
end

function CheckBoxSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.state)
end

function CheckBoxSett.event_init(sett)
  local event = sett.event or CheckBoxSett.event
  Events.add_custom_event(Controller.get_cont("settings").get_name(), sett.type, sett.name, event)
end

return CheckBoxSett