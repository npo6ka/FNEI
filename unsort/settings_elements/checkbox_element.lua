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

return CheckBoxSett