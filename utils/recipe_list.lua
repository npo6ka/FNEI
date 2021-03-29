if not RawTech then RawTech = require "utils/raw_technologies" end

local Recipe = {
  classname = "FNRecipe"
}

function Recipe:get_recipe_list()
  Debug:debug(Recipe.classname, "get_recipe_list( )")

  local proto   = Player.get().force.recipes or {}
  local recipes = {}

  for name, recipe in pairs(proto) do
    recipes[name] = recipe
  end

  Recipe:append_implicit_recipes(recipes)
  return recipes
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

  if not global.fnei.eqRecipe then
    global.fnei.eqRecipe = self:create_equals_recipe_list()
  end

  return global.fnei.eqRecipe
end

----------------------- secondary function --------------------------

function Recipe:append_implicit_recipes(into)

  -- Utility to remove the duplicated impostor recipe baseline
  local function add_impostor(name)
    local recipe = {
      name = name,

      enabled  = true,
      hidden   = false,
      impostor = true,

      ingredients = {},
      products    = {},

      energy = 1
    }

    into[name] = recipe

    return recipe
  end

  for _, proto in pairs(game.entity_prototypes) do

    -- Create impostor recipes for items 'mined' from entities
    if proto.mineable_properties and proto.resource_category then
      local recipe = add_impostor('impostor-minable:' .. proto.name)

      recipe.localised_name = get_localised_name(proto)
      recipe.category = "mine" .. proto.resource_category

      recipe.ingredients = {{ type = 'entity', name = proto.name, amount = 1 }}
      recipe.products    = proto.mineable_properties.products or {}

      -- Required for crafting time estimates
      recipe.mining_time     = proto.mineable_properties.mining_time

      if proto.mineable_properties.required_fluid then
        table.insert(recipe.ingredients, {
            type   = 'fluid',
            name   = proto.mineable_properties.required_fluid,
            amount = proto.mineable_properties.fluid_amount
        })
      end
    end

    -- Create impostor recipes for entities that produce a certain fluid/item unconditionally
    if proto.fluid then
      local recipe = add_impostor('impostor-pumped:' .. proto.name)

      recipe.localised_name = get_localised_name(proto)
      recipe.category = "pump" .. proto.name

      recipe.products = {{ type = 'fluid', name = proto.fluid.name, amount = 1 }}
    end
  end

  -- Impostor recipes are added to the parameter table
  return
end

function Recipe:create_equals_recipe_list()
  local recipes = game.recipe_prototypes
  local ret_buf = {}
  local raw_tech = game.technology_prototypes

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

local tech_dep

function Recipe:compare(recipe, s_recipe)
  if recipe.energy == s_recipe.energy and recipe.category == s_recipe.category then
    if Recipe:compare_recipe_prot(recipe.ingredients, s_recipe.ingredients) and 
       Recipe:compare_recipe_prot(recipe.products, s_recipe.products) 
    then
      if not tech_dep then
        tech_dep = RawTech:create_tech_dependencies(game.technology_prototypes)
      end
      return Recipe:compare_tech_prot(tech_dep[recipe.name], tech_dep[s_recipe.name])
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