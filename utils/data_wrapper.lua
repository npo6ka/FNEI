Force = require "utils/fnei_force"
RawTech = require "utils/fnei_raw_technologies"
Recipe = require "utils/fnei_recipe_list"
Item = require "utils/fnei_items"
CraftCategoty = require "utils/fnei_crafting_category_list"

function get_recipe_list(player)
  return Recipe:get_recipe_list_p(player)
end

function get_tech_list(player)
  
end

function get_fluid_list(player)
  return game.fluid_prototypes
end

function get_item_list(player)
  return Item:get_item_list()
end

function get_gui_pos(player)
  local index = fnei.oc.get_gui_position( player )
  if index == 1 then
    return player.gui.left
  elseif index == 2 then
    return player.gui.top
  elseif index == 3 then
    return player.gui.center
  else
    player.print("utils: get_gui: invalid direction: " .. index)
  end
end