Settings = {
  classname = "FNSettings",
}

local settings_list = {}
local element_list = {}


function Settings.init()
  settings_list["need-show"] =                    { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["use-only-attainable-recipes"] =  { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["show-hidden-recipes"] =          { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["show-disable-recipes"] =         { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["show-hidden-items"] =            { type = "checkbox", tab = "main-settings", def_val = false }
  settings_list["fnei-line-count"] =              { type = "numeric-up-down", tab = "main-settings", def_val = 10, min_val = 5, max_val = 12 }
  settings_list["detail-chance"] =                { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["focus-search"] =                 { type = "checkbox", tab = "main-settings", def_val = false }
  settings_list["close-gui-when-tech-open"] =     { type = "checkbox", tab = "main-settings", def_val = false }
  settings_list["show-craft-time-label"] =        { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["show-the-same-recipes"] =        { type = "checkbox", tab = "main-settings", def_val = false }
  settings_list["show-hotbar"] =                  { type = "checkbox", tab = "main-settings", def_val = true, event = Controller.get_cont("hotbar").change_hotbar_visibility }
  settings_list["show-temperature-of-fluids"] =   { type = "checkbox", tab = "main-settings", def_val = true }
  settings_list["hotbar-last-line-num"] =         { type = "numeric-up-down", tab = "main-settings", def_val = 3, min_val = 0, max_val = 20, event = Controller.get_cont("hotbar").change_hotbar_visibility }
  settings_list["hotbar-fav-line-num"] =          { type = "numeric-up-down", tab = "main-settings", def_val = 5, min_val = 0, max_val = 20, event = Controller.get_cont("hotbar").change_hotbar_visibility }


  settings_list["show-recipes"] =                 { type = "crafting-buildings", tab = "crafting-category", def_val = true }
  
  settings_list["admin"] =                        { type = "global-checkbox", tab = "admin-settings", def_val = nil, def_event = false, event = Controller.get_cont("settings").check_admin_settings_event }
--  settings_list["open-techs"] =                   { type = "checkbox", tab = "admin-settings", def_val = false }
  settings_list["open-unavailable-techs"] =       { type = "checkbox", tab = "admin-settings", def_val = false }

  settings_list["item-auto-craft"] =              { type = "checkbox", tab = "default-settings", def_val = false }
  settings_list["item-auto-usage"] =              { type = "checkbox", tab = "default-settings", def_val = false }
  settings_list["fluid-auto-craft"] =             { type = "checkbox", tab = "default-settings", def_val = false }
  settings_list["fluid-auto-usage"] =             { type = "checkbox", tab = "default-settings", def_val = false }
  settings_list["show-extended-hotbar"] =         { type = "checkbox", tab = "default-settings", def_val = false }

  element_list["checkbox"] =                require "scripts/settings/elements/checkbox"
  element_list["global-checkbox"] =         require "scripts/settings/elements/global_checkbox"
  element_list["crafting-buildings"] =      require "scripts/settings/elements/crafting_buildings"
  element_list["drop-down"] =               require "scripts/settings/elements/drop_down"
  element_list["numeric-up-down"] =         require "scripts/settings/elements/numeric_up_down"
  element_list["global-numeric-up-down"] =  require "scripts/settings/elements/global_numeric_up_down"

  for name, sett in pairs(settings_list) do
    sett.elem = element_list[sett.type]
    sett.name = name
  end
end

function Settings.get_sett_list()
  return settings_list
end

function Settings.get_val(sett_name, arg1, arg2)
  local sett = sett_name and settings_list[sett_name]
  if sett then
    return sett.elem.get_val(sett, arg1, arg2)
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