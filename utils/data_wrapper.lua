Force = require "utils/force"
RawTech = require "utils/raw_technologies"
Recipe = require "utils/recipe_list"
Item = require "utils/items"
CraftCategoty = require "utils/crafting_category_list"

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

--[[function get_crafting_buildings()
  local ret_tb = {}
  local craft_cat = CraftCategoty:get_crafting_category_list(Item:get_item_list())

  for cat, items in pairs(craft_cat) do
    for _, item in pairs(items) do
      ret_tb[item.name] = item
    end
  end

  return ret_tb
end]]

--??????? Need test
local cr_cat

function get_crafting_category()
  if not cr_cat then out("gen"); cr_cat = CraftCategoty:get_crafting_category_list(Item:get_item_list()) end
  return cr_cat
end