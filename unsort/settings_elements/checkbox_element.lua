local CheckBoxSett = {
  classname = "FNCheckBoxSett",
}

function CheckBoxSett.get_val(setting)
  local global_set = Settings.get_global_sett()

  if not global_set[setting.name] then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function CheckBoxSett.set_val(setting, val)
  Settings.get_global_sett()[setting.name] = val
end

function CheckBoxSett.add_label_func(parent, cont_name, sett)
  Gui.addLabel(parent, cont_name, sett.name .. "-label", "fnei_option_param_label", {"fnei." .. sett.name})
end

function CheckBoxSett.add_content_func(parent, cont_name, sett)
  Gui.addCheckbox(parent, cont_name, sett.name, nil, Settings.get_val(sett.name), CheckBoxSett.event)
end

function CheckBoxSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.state)
end

return CheckBoxSett