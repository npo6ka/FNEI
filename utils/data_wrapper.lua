RawTech = require "utils/raw_technologies"
Recipe = require "utils/recipe_list"
Item = require "utils/items"
CraftCategoty = require "utils/crafting_category_list"

function get_tech_list()
  return RawTech:get_tech_list()
end

function get_recipe_list()
  local rec_list = {}

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

  return rec_list
end

function get_fluid_list()
  return game.fluid_prototypes
end

function get_full_item_list()
  return Item:get_item_list()
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

function get_technologies_for_recipe(recipe_name)
  return Recipe:get_technologies_for_recipe(recipe_name)
end

function is_attainable_tech(tech)
  return RawTech:is_attainable_tech(tech)
end

function get_equals_recipe_list()
  return Recipe:get_equals_recipe_list()
end

function get_filtred_recipe_list(recipe_list)
  local ret_list = {}
  local craft_cat_list = get_crafting_categories_list()

  for rec_name, recipe in pairs(recipe_list) do
    if Settings.get_val("show-recipes", "categories", recipe.category) then
      local cat_list = craft_cat_list[recipe.category] or {}

      for _, cat in pairs(cat_list) do
        if cat.type == "player" or (cat.ingredient_count and cat.ingredient_count >= #recipe.ingredients) then
          if cat.val and Settings.get_val("show-recipes", "buildings", cat.val.name) then
            ret_list[rec_name] = recipe
          end
        end
      end
    end
  end

  return ret_list
end