RawTech = require "utils/raw_technologies"
Recipe = require "utils/recipe_list"
Item = require "utils/items"
CraftCategoty = require "utils/crafting_category_list"

function get_tech_list()
  return RawTech:get_tech_list()
end

function get_recipe_list()
  local rec_list

  if Settings.get_val("use-only-attainable-recipes") then
    rec_list = Recipe:get_aRecipe_list()
  else
    rec_list = Recipe:get_recipe_list()
  end

  if not Settings.get_val("show-hidden-recipes") then
    rec_list = Recipe:get_vRecipe_list(rec_list)
  end

  if not Settings.get_val("show-disable-recipes") then
    rec_list = Recipe:get_enRecipe_list(rec_list)
  end
  return ret_list
end

function get_fluid_list()
  return game.fluid_prototypes
end

function get_item_list()
  if Settings.get_val("show-hidden-items") then
    return Item:get_item_list()
  else
    return Item:get_vItem_list(Item:get_item_list())
  end
end

function get_crafting_categories_list()
  return CraftCategoty:get_crafting_category_list()
end

function get_crafting_category(cat_name, amount_items)
  return CraftCategoty:get_craft_cat_whis_slot_amount(cat_name, amount_items)
end