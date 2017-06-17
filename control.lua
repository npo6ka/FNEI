if not fnei then fnei = {} end
if not fnei.rc then fnei.rc = {} end
if not fnei.mc then fnei.mc = {} end
if not fnei.gui then fnei.gui = {} end
if not fnei.main_gui then fnei.main_gui = {} end
if not fnei.recipe_gui then fnei.recipe_gui = {} end

function out(string)
  game.players["npo6ka"].print(string)
end

require "controls/main_control"
require "controls/recipe_control"

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

script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  local element = event.element
  if element.name == "fnei_search_field" and event.button == defines.mouse_button_type.right then
    fnei.mc.clear_search_text(player)
  elseif element.name == "fnei_prev_main_page" then
    fnei.mc.main_gui_prev_page(player)
  elseif element.name == "fnei_next_main_page" then
    fnei.mc.main_gui_next_page(player)
  elseif element.name == "fnei_prev_recipe" then
    fnei.rc.recipe_gui_prev(player)
  elseif element.name == "fnei_next_recipe" then
    fnei.rc.recipe_gui_next(player)
  elseif element.name == "fnei_back_recipe" then
    fnei.rc.back_key(player)
  elseif element.type == "sprite-button" then
    if element.name ~= nil and string.match(element.name, "fnei%_") then
      local elem_name = string.sub(element.name, 6)
      if event.button == defines.mouse_button_type.left then
        fnei.rc.element_left_click(player, elem_name)
      elseif event.button == defines.mouse_button_type.right then
        fnei.rc.element_right_click(player, elem_name)
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
  fnei.rc.back_key(player)
end

function fnei.main_key(player)
  fnei.rc.main_key(player)
end