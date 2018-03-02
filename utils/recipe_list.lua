if not RawTech then RawTech = require "utils/fnei_raw_technologies" end

local Recipe = {
  classname = "FNRecipe"
}

local aRecipe
local eqRecipe

function Recipe:get_recipe_list()
  Debug:debug(Recipe.classname, "get_recipe_list( )")
  return Player.get().force.recipes or {}
end

function Recipe:get_aRecipe_list()
  Debug:debug(Recipe.classname, "get_aRecipe_list( )")

  if not aRecipe then
    aRecipe = self:create_attainable_recipes()
  end

  return aRecipe
end

--return a list of technologies that can open this recipe_name or {}
function Recipe:get_technologies_for_recipe(recipe_name)
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

function Recipe:get_equals_recipe_list()
  Debug:debug(Recipe.classname, "get_equals_recipe_list()")

  if not eqRecipe then
    eqRecipe = self:create_equals_recipe_list()
  end

  return eqRecipe
end

----------------------- secondary function --------------------------

function Recipe:create_equals_recipe_list()
  local recipes = Recipe:get_recipe_list()
  local ret_buf = {}
  local raw_tech = RawTech:get_tech_list()

  for _, tech in pairs(raw_tech) do
    local n_recipes = {}
    local s_recipes = {}

    for _,effect in pairs(tech.effects) do
      if effect.type == "unlock-recipe" then
        local recipe = recipes[effect.recipe]
        n_recipes[recipe.name] = recipe
      end
    end

    for name,recipe in pairs(n_recipes) do
      for s_name, s_recipe in pairs(s_recipes) do
        if Recipe:compare(recipe, s_recipe) then
          if not ret_buf[name] then ret_buf[name] = {} end
          table.insert(ret_buf[name], s_recipe)
          if not ret_buf[s_name] then ret_buf[s_name] = {} end
          table.insert(ret_buf[s_name], recipe)
        end
      end
      s_recipes[name] = recipe
    end
  end

  return ret_buf
end

function Recipe:compare(recipe, s_recipe)
  if recipe.energy == s_recipe.energy and recipe.category == s_recipe.category then
    if Recipe:compare_recipe_prot(recipe.ingredients, s_recipe.ingredients) and 
       Recipe:compare_recipe_prot(recipe.products, s_recipe.products) 
    then
      local techs = RawTech:get_recipe_list_in_tech_dependencies()
      return Recipe:compare_tech_prot(techs[recipe.name], techs[s_recipe.name])
    end
  end
  return false
end

function Recipe:compare_recipe_prot(list1, list2)
  if #list1 ~= #list2 then return false end

  for _,prot1 in pairs(list1) do
    local flag = false

    for _,prot2 in pairs(list2) do
      local flag2 = true

      for name, val in pairs(prot1) do
        flag2 = flag2 and (prot2[name] == val)
      end
      if flag2 then flag = true end
    end
    if not flag then return false end
  end

  return true
end

function Recipe:compare_tech_prot(list1, list2)
  if #list1 ~= #list2 then return false end

  for _,prot1 in pairs(list1) do
    local flag = false

    for _,prot2 in pairs(list2) do
      if prot1.name == prot2.name then
        flag = true
      end
    end

    if not flag then return false end
  end

  return true
end

function Recipe:create_attainable_recipes()
  local ret_tb = {}
  local recipe_list = Recipe:get_recipe_list()
  local rec_dep = RawTech:get_recipe_list_in_tech_dependencies()
  local a_tech = RawTech:get_aTech_list()

  for _,recipe in pairs(recipe_list) do
    local dep = rec_dep[recipe.name] or {}
    if recipe.enabled then
      ret_tb[recipe.name] = recipe
    else
      local flag = false
      for _,tech in pairs(dep) do
        if a_tech[tech.name] then
          flag = true
        end
      end

      if flag then
        ret_tb[recipe.name] = recipe
      end
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