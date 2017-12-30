local Settings = {
  classname = "FNSettings",
}

local settings_list = {
  { type = "checkbox", name = "option-1" },
}

function Settings.get_list()
  return settings_list
end

function Settings.get(sett_name)
  
end

function Settings.set(sett_name, val)
  
end

return Settings