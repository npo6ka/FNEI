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
  if not player then out("ERROR option_control:get_settings") end
  
  local name = (player and player.name) or "nil"
  if not global.fnei.settings[name] then
    global.fnei.settings[name] = {}
  end
  return global.fnei.settings[name]
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
    return false
  else
    return settings.close
  end
end

--par2
function fnei.oc.change_par2( player, value )
  local settings = fnei.oc.get_settings( player )
  settings.detail_chance = value
end

function fnei.oc.detail_chance( player )
  local settings = fnei.oc.get_settings( player )
  if settings.detail_chance == nil then
    return false
  else
    return settings.detail_chance
  end
end

--par3
function fnei.oc.change_par3( player, item_name, value )
  local settings = fnei.oc.get_settings( player )
  if settings.buildings == nil then
    settings.buildings = {}
  end
  settings.buildings[item_name] = value
  fnei.option_gui.change_buildings_state( player, item_name )
end

function fnei.oc.get_craft_state_for_building( player, item_name)
  local settings = fnei.oc.get_settings( player )
  if not settings.buildings or settings.buildings[item_name] == nil then
    return true
  else
    return settings.buildings[item_name]
  end
end

--par4
function fnei.oc.change_par4( player, value )
  local settings = fnei.oc.get_settings( player )
  settings.hidden_recipe = value
  if #fnei.mc.get_elem_list(player) > 0 then
    fnei.mc.set_new_list(player)
  end
end

function fnei.oc.show_hidden_item( player )
  local settings = fnei.oc.get_settings( player )
  if settings.hidden_recipe == nil then
    return false
  else
    return settings.hidden_recipe
  end
end

--par5
function fnei.oc.change_par5( player, value )
  local settings = fnei.oc.get_settings( player )
  settings.non_destination = value
end

function fnei.oc.show_non_destination( player )
  local settings = fnei.oc.get_settings( player )
  if settings.non_destination == nil then
    return false
  else
    return settings.non_destination
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