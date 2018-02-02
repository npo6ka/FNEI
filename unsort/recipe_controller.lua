local RecipeController = {
  classname = "FNRecipeController"
}

local RecipeGui = require "unsort/recipe_gui"
local queue = Queue:new("recipe_queue")

function RecipeController.exit()
  out("Recipe exit")
  queue:clear()
  RecipeGui.close_window()
end

function RecipeController.open(args)
  out("Recipe open")

  if args == nil then

  else
    queue:clear()
    RecipeController.add_recipe_in_queue(args)
  end

  return RecipeGui.open_window()
end


function RecipeController.back_key()
  --RecipeController.remove_last_in_queue()
  if queue.is_empty() then
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

function RecipeController.add_recipe_in_queue(recipe)
  local last_elem = queue:get()

  if recipe ~= nil and last_elem ~= nil and (recipe.type ~= last_elem.type or recipe.name ~= last_elem.name) then
    queue:add(recipe)
  end
end

function RecipeController.add_prot_event(event, name)
  -- body
end

return RecipeController
