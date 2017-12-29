local RecipeController = {
  classname = "FNRecipeController",
  name = "Recipe"
}

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

return RecipeController