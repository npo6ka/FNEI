local CraftingBuildingsSett = {
  classname = "FNCraftingBuildingsSett",
}

function CraftingBuildingsSett.init(name, def_val)
  Settings.get_global_sett()[name] = def_val
end

function CraftingBuildingsSett.get_val(name)
  return Settings.get_global_sett()[name]
end

function CraftingBuildingsSett.set_val(name, val)
  Settings.get_global_sett()[name] = val
end

function CraftingBuildingsSett.add_label_func(parent, cont_name, sett)
  Gui.addLabel(parent, cont_name, sett.name .. "-label", "fnei_option_param_label", {"fnei." .. sett.name})
end

function CraftingBuildingsSett.add_content_func(parent, cont_name, sett)
  Gui.addCheckbox(parent, cont_name, sett.name, nil, sett.def_val, CraftingBuildingsSett.event)
end

function CraftingBuildingsSett.event(event, sett_name)
  Settings.set_val(sett_name, event.element.state)
end

return CraftingBuildingsSett



--par3
content_tab.add({type = "label", name = "fnei_option_label_3", caption = {"fnei.show-recipes"}, style = "fnei_option_param_label"})
local param3 = content_tab.add({type = "scroll-pane", name = "fnei_option_param_3_scroll", style = "fnei_option_param_3_scroll"})
param3.add({type = "table", name = "fnei_param_3_table", colspan = 5})