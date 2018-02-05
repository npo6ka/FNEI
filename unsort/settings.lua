Settings = {
  classname = "FNSettings",
}

local settings_list = {}
local element_list = {}


function Settings.init()
  settings_list["need-show"] =     { type = "checkbox", tab = "main-settings", def_val = true}
  settings_list["use-only-attainable-recipes"] =      { type = "checkbox", tab = "main-settings", def_val = true}
  settings_list["show-hidden-recipes"] =      { type = "checkbox", tab = "main-settings", def_val = false}
  settings_list["show-disable-recipes"] =      { type = "checkbox", tab = "main-settings", def_val = true}
  settings_list["show-hidden-items"] =      { type = "checkbox", tab = "main-settings", def_val = false}
  settings_list["position"] =      { type = "drop-down", tab = "main-settings", def_val = 1, items = {{"fnei.left"}, {"fnei.top"}, {"fnei.center"}}, event = Controller.get_cont("settings").new_gui_location}
  settings_list["fnei-line-count"] = { type = "numeric-up-down", tab = "main-settings", def_val = 10, min_val = 5, max_val = 30}
  settings_list["detail-chance"] =      { type = "checkbox", tab = "main-settings", def_val = false}
  settings_list["show-recipes"] =  { type = "crafting-buildings", tab = "crafting-category", def_val = true}
  settings_list["admin-settings"] = { type = "checkbox", tab = "admin-settings", def_val = false}

  element_list["checkbox"] =            require "unsort/settings_elements/checkbox_element"
  element_list["crafting-buildings"] =  require "unsort/settings_elements/crafting_buildings_element"
  element_list["drop-down"] =           require "unsort/settings_elements/drop_down_element"
  element_list["numeric-up-down"] =     require "unsort/settings_elements/numeric_up_down_element"


  for name, sett in pairs(settings_list) do
    sett.elem = element_list[sett.type]
    sett.name = name
  end
end

function Settings.get_sett_list()
  return settings_list
end

function Settings.get_val(sett_name)
  local sett = sett_name and settings_list[sett_name]
  if sett then
    return sett.elem.get_val(sett)
  else
    Debug:error("Error in fanction Settings.get_val: sett_name ", sett_name, " not found")
  end
end

function Settings.set_val(sett_name, val)
  local sett = sett_name and settings_list[sett_name]
  if sett then
    settings_list[sett_name].elem.set_val(settings_list[sett_name], val)
  end
end

function Settings.get_global_sett()
  local pl_global = Player.get_global()
  if not pl_global.settings then pl_global.settings = {} end
  return pl_global.settings
end

function Settings.init_events()
  for name,sett in pairs(settings_list) do
    element_list[sett.type].event_init(sett)
  end
end