require "controls/gui"

function fnei.oc.back_key(player)
  fnei.gui.close_option(player)
  fnei.oc.open_last_gui(player)
end

function fnei.oc.main_key(player)
  fnei.gui.close_option(player)
end

function close_all_gui( player )
  fnei.gui.close_main(player)
  fnei.gui.close_recipe(player)
  fnei.gui.close_option(player)
end

function fnei.oc.open_gui(player)
  fnei.oc.set_last_gui(player)
  close_all_gui(player)
  fnei.gui.open_option_gui(player)
end

function fnei.oc.open_last_gui(player)
  if fnei.oc.last_gui == "recipe" then
    fnei.rc.open_gui(player)
  elseif fnei.oc.last_gui == "main" then
    fnei.mc.open_gui(player)
  end
end

function fnei.oc.set_last_gui(player)
  fnei.oc.last_gui = nil
  if fnei.gui.is_recipe_open(player) then
    fnei.oc.last_gui = "recipe"
  elseif fnei.gui.is_main_open(player) then
    fnei.oc.last_gui = "main"
  end
end

function fnei.oc.get_settings( player )
  if not global.fnei.settings[player.name] then
    global.fnei.settings[player.name] = {}
  end
  return global.fnei.settings[player.name]
end

--par0
function fnei.oc.change_par0( player, index )
  local settings = fnei.oc.get_settings( player )
  close_all_gui( player )
  settings.gui_location = index
  fnei.gui.open_option_gui(player)
end

function fnei.oc.get_gui_position( player )
  local settings = fnei.oc.get_settings( player )
  if settings.gui_location == nil then
    return 1
  else
    return settings.gui_location
  end
end

--par1
function fnei.oc.change_par1( player, value )
  local settings = fnei.oc.get_settings( player )
  settings.close = value
end

function fnei.oc.need_to_close_gui( player )
  local settings = fnei.oc.get_settings( player )
  if settings.close == nil then
    return true
  else
    return settings.close
  end
end

--admin_par0
function fnei.oc.change_adm_par0( player, value )
  fnei.gui.close_option(player)
  global.fnei.settings.admin_function = value
  fnei.gui.open_option_gui(player)
end

function fnei.oc.get_admin_permission()
  if global.fnei.settings.admin_function then
    return true
  else
    return false
  end
end

--admin_par1
function fnei.oc.change_adm_par1( player, value )
  local settings = fnei.oc.get_settings( player )
  settings.can_tech = value
end

function fnei.oc.can_show_tech( player )
  local settings = fnei.oc.get_settings( player )
  if settings.can_tech then
    return true
  else
    return false
  end
end