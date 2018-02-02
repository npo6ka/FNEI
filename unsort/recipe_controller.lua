local RecipeController = {
  classname = "FNRecipeController"
}

local RecipeGui = require "unsort/recipe_gui"

function RecipeController.exit()
  out("Recipe exit")
  RecipeController.remove_recipe_queue()
  RecipeGui.close_window()
end

function RecipeController.open(args)
  out("Recipe open")
  RecipeController.add_recipe_in_queue(args)
  return RecipeGui.open_window()
end

function RecipeController.back_key()
  RecipeController.remove_last_in_queue()
  if RecipeController.queue_is_empty() then
    return true
  else
    return false
  end
end

function RecipeController.get_name()
  return RecipeGui.name
end

function RecipeController.init_events()
  RecipeGui.init_events()
end


------------------- recipe queue ---------------------

function RecipeController.get_recipe_queue()
  local gl = Player.get_global()
  if not gl.recipe_queue then gl.recipe_queue = {} end
  return gl.recipe_queue or {}
end

function RecipeController.add_recipe_in_queue(recipe)
  local queue = RecipeController.get_recipe_queue()
  local last_elem = RecipeController.get_recipe()
  if recipe.type ~= last_elem.type or recipe.name ~= last_elem.name then
    table.insert(queue, recipe)
  end
end

function RecipeController.remove_recipe_queue()
  local queue = RecipeController.get_recipe_queue()
  queue = {}
end

function RecipeController.remove_last_in_queue()
  local queue = RecipeController.get_recipe_queue()
  table.remove(queue, #queue)
end

function RecipeController.get_recipe()
  local queue = RecipeController.get_recipe_queue()
  if #queue > 0 then
   return queue[#queue]
 end
 return {}
end

function RecipeController.queue_is_empty()
  return #RecipeController.get_recipe_queue() == 0
end

return RecipeController
