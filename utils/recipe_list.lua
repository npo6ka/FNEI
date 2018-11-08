if not RawTech then RawTech = require "utils/raw_technologies" end

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

  if not global.fnei.eqRecipe then
    global.fnei.eqRecipe = self:create_equals_recipe_list()
  end

  return global.fnei.eqRecipe
end

----------------------- secondary function --------------------------

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

function Recipe:create_attainable_recipes()
  local ret_tb = {}
  local recipe_list = Recipe:get_recipe_list()
  local rec_dep = RawTech:get_recipe_list_in_tech_dependencies()
  local a_tech = RawTech:get_aTech_list()

  for _,recipe in pairs(recipe_list) do
    if recipe.enabled then
      ret_tb[recipe.name] = recipe
    else
      local dep = rec_dep[recipe.name] or {}

      for _,tech in pairs(dep) do
        if a_tech[tech.name] then
          ret_tb[recipe.name] = recipe
          break
        end
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



do
	-- Create machine recipe support cache
	if not global.fnei_machine_recipe_cache then
		global.fnei_machine_recipe_cache = {}
	end

	local cache = global.fnei_machine_recipe_cache

	function Recipe:check_machine_support(machine, recipe)
		if not (game.entity_prototypes[machine] and game.recipe_prototypes[recipe]) then
			return false
		end

		-- Consult cache
		if not cache[machine] then
			cache[machine] = {}
		else
			local cached = cache[machine][recipe]

			if cached ~= nil then
				return cached
			end
		end

		-- Check if this recipe is supported by the given machine, by attempting to set it
		--  on a phantom empty surface we created just for this single purphose
		local surface = game.surfaces['FNEI_HiddenSurface']

		-- Construct surface
		if not surface then
			surface = game.create_surface('FNEI_HiddenSurface', {
				width  = 64,
				height = 64
			})

			for x = -1, 1 do
				for y = -1, 1 do
					-- Leave chunks unpopulated
					surface.set_chunk_generated_status({x, y}, defines.chunk_generated_status.entities)
				end
			end
		end

		-- Spawn target entity, and attempt to assign the given recipe
		local entity = surface.create_entity({
			name   = machine,
			recipe = recipe,

			position = {0, 0}
		})

		-- Cache results
		cache[machine][recipe] = entity.get_recipe() ~= nil

		-- Destroy entity, return answer
		entity.destroy()

		return cache[machine][recipe]
	end
end

return Recipe