local DropDownSett = {
  classname = "FNDropDownSett",
}

function DropDownSett.init(name, def_val)
  Settings.get_global_sett()[name] = def_val
end

function DropDownSett.get_val(name)
  return Settings.get_global_sett()[name]
end

function DropDownSett.set_val(name, val)
  Settings.get_global_sett()[name] = val
end

function DropDownSett.add_label_func(parent, cont_name, sett)
  Gui.addLabel(parent, cont_name, sett.name .. "-label", "fnei_option_param_label", {"fnei." .. sett.name})
end

function DropDownSett.add_content_func(parent, cont_name, sett)
  local event = sett.event or DropDownSett.event
  Gui.addDropDown(parent, cont_name, sett.name, nil, sett.items, Settings.get_val(sett.name), event)
end

function DropDownSett.event(event, sett_name)
  DropDownSett.set_val(sett_name, event.element.selected_index)
end

return DropDownSett