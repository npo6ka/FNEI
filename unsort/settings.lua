local Settings = {
  classname = "FNSettings",
}

local settings_list = {}
settings_list["option-1"] = { type = "checkbox", def_val = true}
settings_list["option-2"] = { type = "checkbox", def_val = false}
settings_list["option-3"] = { type = "checkbox", def_val = true}


local element_list = {
  checkbox = require "unsort/settings_elements/checkbox_element"
}

function Settings.get_sett_list()
  return settings_list
end

function Settings.get_val(sett_name)
  settings_list[sett_name].elem.get_val(sett_name)
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
    sett.elem = element_list[sett.type]
    sett.elem.init(name, sett.def_val)
  end
end

return Settings