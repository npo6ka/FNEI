local DropDownSett = {
  classname = "FNDropDownSett",
}

function DropDownSett.get_val(setting)
    local global_set = Settings.get_global_sett()

  if not global_set[setting.name] then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function DropDownSett.set_val(setting, val)
  Settings.get_global_sett()[setting.name] = val
end

function DropDownSett.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_option_param_label", caption = {"fnei." .. sett.name}, tooltip = {"fnei." .. sett.name}})
end

function DropDownSett.add_content_func(parent, sett)
  Gui.add_drop_down(parent, { type = "drop-down", name = sett.name, items = sett.items, selected_index = Settings.get_val(sett.name) })
end

function DropDownSett.event(event, sett_name)
  DropDownSett.set_val(sett_name, event.element.selected_index)
end

return DropDownSett