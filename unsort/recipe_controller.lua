local RecipeController = {
  classname = "FNRecipeController",
}

local RecipeGui = require "unsort/recipe_gui"

function RecipeController.exit()
  out("Recipe exit")
end

function RecipeController.open()
  out("Recipe open")
end

function RecipeController.back_key()
  out("Recipe back")
  return true
end

function RecipeController.get_name()
  return RecipeGui.name
end

return RecipeController