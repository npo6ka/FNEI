RawTech = require "utils/raw_technologies"
Recipe = require "utils/recipe_list"
Item = require "utils/items"
Fluid = require "utils/fluids"
Entity = require "utils/entity"
CraftCategoty = require "utils/crafting_category_list"

function hard_load()
  if not storage.fnei.eqRecipe then
    Recipe:get_equals_recipe_list()
  end
end

------------- Actiion category -------------

function get_crafting_categories_list()
  return CraftCategoty:get_crafting_category_list()
end

------------------ Item -------------------

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

------------------ Fluid ------------------

function get_full_fluid_list()
  return Fluid:get_fluid_list()
end

function get_fluid_list()
  if Settings.get_val("show-hidden-fluids") then
    return Fluid:get_fluid_list()
  else
    return Fluid:get_vFluid_list(Fluid:get_fluid_list())
  end
end

------------------ Tech -------------------

function get_tech_list()
  return RawTech:get_tech_list()
end

function get_technologies_for_recipe(recipe_name)
  return Recipe:get_technologies_for_recipe(recipe_name)
end

------------------ Entity -----------------

function get_entity_list()
  return Entity:get_entity_list()
end

function get_mineable_entity_list()
  return Entity:get_mineable_entity_list()
end

function get_not_convert_entity_list()
  return Entity:get_nConvert_entity_list()
end

------------------ Recipe -----------------

function get_all_recipes()
  return Recipe:get_recipe_list()
end

function get_recipe_list()
  local rec_list = Recipe:get_recipe_list()

  if not Settings.get_val("show-hidden-recipes") then
    rec_list = Recipe:get_vRecipe_list(rec_list)
  end

  if not Settings.get_val("show-disable-recipes") then
    rec_list = Recipe:get_enRecipe_list(rec_list)
  end

  return rec_list
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
        local add_flag = false

        if cat.type == "player" then
          add_flag = true
        elseif cat.type == "resource-miner" then
          add_flag = true
        elseif cat.ingredient_count then
          local ing_cnt = 0

          for _,prot in pairs(recipe.ingredients) do
            if prot.type == "item" then
              ing_cnt = ing_cnt + 1
            end
          end

          if cat.ingredient_count >= ing_cnt then
            add_flag = true
          end
        end

        if add_flag then
          if cat.val and Settings.get_val("show-recipes", "buildings", cat.val.name) then
            ret_list[rec_name] = recipe
          end
        end
      end
    end
  end

  return ret_list
end