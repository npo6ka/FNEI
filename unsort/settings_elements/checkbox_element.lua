local CheckBoxSett = {
  classname = "FNCheckBoxSett",
}

function CheckBoxSett.init(name, def_val)
  Settings.get_global_sett()[name] = def_val
end

function CheckBoxSett.get_val(name)
  return Settings.get_global_sett()[name]
end

function CheckBoxSett.set_val(name, val)
  Settings.get_global_sett()[name] = val
end

function CheckBoxSett.add_label_func(parent, cont_name, sett)
  Gui.addLabel(parent, cont_name, sett.name .. "-label", "fnei_option_param_label", {"fnei." .. sett.name})
end

function CheckBoxSett.add_content_func(parent, cont_name, sett)
  Gui.addCheckbox(parent, cont_name, sett.name, nil, sett.def_val, CheckBoxSett.event)
end

function CheckBoxSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.state)
end

return CheckBoxSett