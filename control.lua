if not fnei then fnei = {} end
if not fnei.rc then fnei.rc = {} end
if not fnei.mc then fnei.mc = {} end
if not fnei.oc then fnei.oc = {} end
if not fnei.gui then fnei.gui = {} end
if not fnei.main_gui then fnei.main_gui = {} end
if not fnei.recipe_gui then fnei.recipe_gui = {} end
if not fnei.option_gui then fnei.option_gui = {} end
if not global.fnei then global.fnei = {} end
if not global.fnei.settings then 
  global.fnei.settings = {} 
end

function out(string)
  game.players["npo6ka"].print(string)
end

require "libs/utils"
require "libs/utils_style"
require "controls/main_control"
require "controls/recipe_control"
require "controls/option_control"

script.on_event(defines.events.on_tick, function(event)
  for _,player in pairs(game.players) do
    if player ~= nil and player.opened_gui_type ~= 0 and fnei.gui.is_gui_open(player) then
      fnei.gui.exit_from_gui(player)
      player.opened = nil
    end
  end
end)

script.on_event("pressed-fnei-gui-key", function(event)
  local player = game.players[event.player_index]
  fnei.main_key(player)
end)

script.on_event("pressed-fnei-back-key", function(event)
  local player = game.players[event.player_index]
  fnei.back_key(player)
end)

script.on_event("pressed-fnei-gui2-key", function(event)
  local player = game.players[event.player_index]  
  if not global.fnei then
    global.fnei = {}
  end
  if not global.fnei[player.name] then
    global.fnei[player.name] = {}
  end
  if not global.fnei[player.name].is_massage then
    player.print({"fnei.warning-message-1"})
    player.print({"fnei.warning-message-2"})
    global.fnei[player.name].is_massage = true
  end
end)

script.on_event(defines.events.on_gui_checked_state_changed, function(event)
  local player = game.players[event.player_index]
  local element = event.element
  if element.name == "fnei_option_admin_param_0" then
    if player.admin then
      if global.fnei.settings.admin_function == nil then
        player.print({"fnei.admin-option-warning"})
        element.state = false
        global.fnei.settings.admin_function = false
      else
        fnei.oc.change_adm_par0(player, element.state)
      end
    else
      player.print({"fnei.non-admin-permission"})
      element.state = global.fnei.settings.admin_function
    end
  elseif element.name == "fnei_option_admin_param_1" then
    fnei.oc.change_adm_par1(player, element.state)
  end
end)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
  local player = game.players[event.player_index]
  local element = event.element
  if element.name == "fnei_option_param_0" then
    fnei.oc.change_par0(player, element.selected_index)
  end
end)

script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  local element = event.element
  if element.name == "fnei_search_field" and event.button == defines.mouse_button_type.right then
    fnei.mc.clear_search_text(player)
  elseif element.name == "fnei_prev_main_page" then
    fnei.mc.main_gui_prev_page(player)
  elseif element.name == "fnei_next_main_page" then
    fnei.mc.main_gui_next_page(player)
  elseif element.name == "fnei_recipe_left_key" then
    fnei.rc.recipe_gui_prev(player)
  elseif element.name == "fnei_recipe_right_key" then
    fnei.rc.recipe_gui_next(player)
  elseif element.name == "fnei_recipe_back_key" then
    fnei.rc.back_key(player)
  elseif element.name == "fnei_recipe_exit_key" then
    fnei.rc.main_key(player)
  elseif element.name == "fnei_option_back_key" then
    fnei.oc.back_key(player)
  elseif element.name == "fnei_option_exit_key" then
    fnei.oc.main_key(player)
  elseif element.name == "fnei_recipe_settings_key" then
    fnei.oc.open_gui(player)
    --[[player.print("This function is not available in this version of the mod")
    player.print("The options window is under construction")]]
  elseif element.type == "sprite-button" then
    if element.name ~= nil then
      if string.match(element.name, "fnei%_item%_") or string.match(element.name, "fnei%_fluid%_") then
        local elem_name = ""
        if string.match(element.name, "fnei%_item%_") then 
          elem_name = {name = string.sub(element.name, 11), type = "item"}
        else
          elem_name = {name = string.sub(element.name, 12), type = "fluid"}
        end
        if event.button == defines.mouse_button_type.left then
          fnei.rc.element_left_click(player, elem_name)
        elseif event.button == defines.mouse_button_type.right then
          fnei.rc.element_right_click(player, elem_name)
        end
      elseif string.match(element.name, "fnei%_technology%_") then
        if fnei.oc.can_show_tech( player ) then
          show_tech(player, string.sub(element.name, 17))
        else
          player.print({"fnei.info-admin-command-warning"})
        end
      end
    end
  end
end)

script.on_event(defines.events.on_gui_text_changed, function(event)
  local player = game.players[event.player_index]
  local element = event.element
  if element.name == "fnei_search_field" then
    fnei.mc.search_text_cheged(player)
  end
end)

function fnei.back_key(player)
  if fnei.gui.is_recipe_open(player) then
    fnei.rc.back_key(player)
  elseif fnei.gui.is_main_open(player) then
    fnei.mc.back_key(player)
  elseif fnei.gui.is_option_open(player) then
    fnei.oc.back_key(player)
  end
end

function fnei.main_key(player)
  if fnei.gui.is_recipe_open(player) then
    fnei.rc.main_key(player)
  elseif fnei.gui.is_main_open(player) then
    fnei.mc.main_key(player)
  elseif fnei.gui.is_option_open(player) then
    fnei.oc.main_key(player)
  else
    fnei.mc.main_key(player)
  end
end