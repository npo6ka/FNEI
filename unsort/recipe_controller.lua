local RecipeController = {
  classname = "FNRecipeController"
}

local RecipeGui = require "unsort/recipe_gui"

function RecipeController.exit()
  out("Recipe exit")
  RecipeGui.close_window()
end

function RecipeController.open()
  out("Recipe open")
  RecipeGui.open_window()
end

function RecipeController.back_key()
  return true
end

function RecipeController.get_name()
  return RecipeGui.name
end

return RecipeController