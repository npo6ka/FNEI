function get_force_data(force)
  local name = (force and force.name) or "nil"
  if name == "nil" then out("force_data == nil") end

  if not fnei.force[name] then
    fnei.force[name] = {}
  end
  return fnei.force[name]
end

require "utils/fnei_technologies_list"

--return a list of attainable recipies or empty list
function get_recipe_list(player)
  if player.force then
    return get_attainable_recipes(player.force)
  end
  player.print("nil force in get_recipe_list")
  return {}
end

--return a list of technologies that can open this pecipe_name or nil
function get_technology_for_recipe(player, pecipe_name)
  if player.force then
    return get_tech_dependencies(player.force)[pecipe_name]
  end
  player.print("nil force in get_technology_for_recipe")
  return {}
end

----------------------- supported function --------------------------

function get_attainable_recipes(force)
  local data = get_force_data(force)
  if not data.recipes then
    data.recipes = create_attainable_recipes(force)
  end
  return data.recipes
end

function create_attainable_recipes(force)
  local ret_tb = {}
  local rec_dep = get_tech_dependencies(force)

  for _,recipe in pairs(force.recipes) do
    local dep = rec_dep[recipe.name]
    if recipe.enabled or (dep and #dep > 0) then
      ret_tb[recipe.name] = recipe
    end
  end

  return ret_tb
end

function get_tech_dependencies(force)
  local data = get_force_data(force)

  if not data.rec_dep then
    data.rec_dep = create_tech_dependencies(force)
  end
  return data.rec_dep
end

function create_tech_dependencies(force)
  local techs = get_attainable_tech(force)
  local ret_tb = {}
  for _,tech in pairs(techs) do
    for _,modifier in pairs(tech.effects) do
      if modifier.type == "unlock-recipe" then
        if not ret_tb[modifier.recipe] then
          ret_tb[modifier.recipe] = {}
        end
        table.insert(ret_tb[modifier.recipe], tech)
      end
    end
  end
  return ret_tb
end