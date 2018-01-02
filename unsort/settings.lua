local Settings = {
  classname = "FNSettings",
}


local settings_list = {}
settings_list["need-show"] =     { type = "checkbox", def_val = true}
settings_list["option-2"] =      { type = "checkbox", def_val = false}
settings_list["option-3"] =      { type = "checkbox", def_val = true}
settings_list["position"] =      { type = "drop-down", def_val = 1, items = {{"fnei.left"}, {"fnei.top"}, {"fnei.center"}}, event = Controller.get_cont("settings").new_gui_location}
settings_list["show-recipes"] =  { type = "crafting_buildings", def_val = true}


local element_list = {}
element_list["checkbox"] =            require "unsort/settings_elements/checkbox_element"
element_list["crafting_buildings"] =  require "unsort/settings_elements/crafting_buildings_element"
element_list["drop-down"] =           require "unsort/settings_elements/drop_down_element"

for name, sett in pairs(settings_list) do
  sett.elem = element_list[sett.type]
  sett.name = name
end

function Settings.get_sett_list()
  return settings_list
end

function Settings.get_val(sett_name)
  if sett_name then
    return settings_list[sett_name].elem.get_val(sett_name)
  else
    Debug:error("Error in fanction Settings.get_val: sett_name == nil")
  end
end

function Settings.set_val(sett_name, val)
  settings_list[sett_name].elem.set_val(sett_name, val)
end

function Settings.get_global_sett()
  local pl_name = Player.get().name
  if not global.fnei then global.fnei = {} end
  if not global.fnei[pl_name] then global.fnei[pl_name] = {} end
  if not global.fnei[pl_name].settings then global.fnei[pl_name].settings = {} end
  return global.fnei[pl_name].settings
end

function Settings.init()
  for name, sett in pairs(Settings.get_sett_list()) do
    sett.elem.init(name, sett.def_val)
  end
end

return Settings