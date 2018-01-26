if not RawTech then RawTech = require "utils/fnei_raw_technologies" end

local Recipe = {
  classname = "FNRecipe"
}

local aRecipe

function Recipe:get_recipe_list()
  Debug:debug(Recipe.classname, "get_recipe_list( )")
  return Player.get().force.recipes or {}
end

function Recipe:get_aRecipe_list()
  Debug:debug(Recipe.classname, "get_aRecipe_list( )")
  if not aRecipe then aRecipe = self:create_attainable_recipes() end
  return aRecipe or {}
end

--return a list of technologies that can open this recipe_name or {}
function Recipe:get_technology_for_recipe(recipe_name)
  Debug:debug(Recipe.classname, "get_technology_for_recipe(", recipe_name, ")")
  return RawTech:get_recipe_list_in_tech_dependencies()[recipe_name] or {}
end

function Recipe:get_vRecipe_list(recipe_list)
  Debug:debug(Recipe.classname, "get_technology_for_recipe(", recipe_list and "recipe_list", item_list and "item_list", ")")
  return self:create_visible_recipes(recipe_list)
end

function Recipe:get_enRecipe_list(recipe_list)
  Debug:debug(Recipe.classname, "get_enRecipe_list(", recipe_list and "recipe_list", ")")
  return self:create_enable_recipes(recipe_list)
end

----------------------- secondary function --------------------------

function Recipe:create_attainable_recipes()
  local ret_tb = {}
  local recipe_list = Recipe:get_recipe_list()
  local rec_dep = RawTech:get_recipe_list_in_tech_dependencies()

  for _,recipe in pairs(recipe_list) do
    local dep = rec_dep[recipe.name]
    if dep and #dep > 0 then
      ret_tb[recipe.name] = recipe
    end
  end

  return ret_tb
end

function Recipe:create_visible_recipes(recipe_list)
  local ret_tb = {}

  for _,recipe in pairs(recipe_list) do
    if not recipe.hidden then
      ret_tb[recipe.name] = recipe
    end
  end

  return ret_tb
end

function Recipe:create_enable_recipes(recipe_list)
  local ret_tb = {}

  for _,recipe in pairs(recipe_list) do
    if recipe.enabled then
      ret_tb[recipe.name] = recipe
    end
  end

  return ret_tb
end

return Recipe