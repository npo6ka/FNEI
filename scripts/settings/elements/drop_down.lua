local DropDownSett = {
  classname = "FNDropDownSett",
}

function DropDownSett.get_val(setting)
  local global_set = Settings.get_global_sett()

  if global_set[setting.name] == nil then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function DropDownSett.set_val(setting, val)
  local sets = Settings.get_global_sett()
  sets[setting.name] = val
end

function DropDownSett.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_settings_param-label", caption = {"fnei." .. sett.name} })
end

function DropDownSett.add_content_func(parent, sett)
  Gui.add_drop_down(parent, { type = "drop-down", name = sett.name, items = sett.items, selected_index = Settings.get_val(sett.name) })
end

function DropDownSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.selected_index)
end

function DropDownSett.event_init(sett)
  if sett.def_event ~= false then
    Events.add_custom_event(Controller.get_cont("settings").get_name(), sett.type, sett.name, DropDownSett.event)
  end
  if sett.event then
    Events.add_custom_event(Controller.get_cont("settings").get_name(), sett.type, sett.name, sett.event)
  end
end

return DropDownSett