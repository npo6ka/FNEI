function get_localised_name( element )
  return element and (element.localised_name or element.name)
end

function get_recipe_categories(recipe)
  if not recipe then
    return {}
  end

  if recipe.categories then
    return recipe.categories
  end

  if recipe.category then
    return { recipe.category }
  end

  return {}
end

function same_recipe_categories(categories1, categories2)
  if #categories1 ~= #categories2 then
    return false
  end

  local lookup = {}

  for _, category in pairs(categories1) do
    lookup[category] = true
  end

  for _, category in pairs(categories2) do
    if not lookup[category] then
      return false
    end
  end

  return true
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function round_to_str(num, idp)
  local val = 0
  if (num > 1000000 or (num < 0.001 and num > 0)) then
    val = string.format("%1.1e", num)
  else
    val = round(num, idp)
  end
  return val
end

function clear_gui(parent)
  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end
end