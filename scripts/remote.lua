Remote = {
    classname = "FNRemote"
}

local version = 2

-- Returns the current version so other mods can focus on one specific version of the API
-- Usage example: remote.call("fnei", "version")
function Remote.version()
    return version
end

-- Explanation of the parameters used:
--   action_type: the kind of recipes that should be shown ("craft" or "usage")
--   prot_type: the type-property of the prototype ("item" or "fluid")
--   prot_name: the name of the prototype for which a list of recipes is shown
--   cur_page: the name of the recipe prototype out of the list that should be shown

-- A 1-to-1 translation of the internal method of displaying an prototype
-- Usage example: remote.call("fnei", "show_recipe_for_prot", "craft", "item", "iron-plate")
function Remote.show_recipe_for_prot(action_type, prot_type, prot_name)
    Controller.get_cont("recipe").add_element_in_recipe_list(action_type, prot_type, prot_name)
    Controller.open_event("recipe")
end

-- This will show the recipes for the given recipe_name.
-- Since fnei always works with a list of recipes for prototypes, this list is formed as follows.
-- As a prototype for displaying a list of recipes, the first prototype from the list of products of the specified
-- recipe or from the list of ingredients will be used (if the list of products is empty).
-- Optionally, you can specify a prototype for which this reipe list should be displayed.

-- Usage example: remote.call("fnei", "show_recipe", "basic-oil-processing")
-- or             remote.call("fnei", "show_recipe", "basic-oil-processing", "light-oil")
function Remote.show_recipe(recipe_name, prot_name)
    local function find_prot(list)
        for _,prot in pairs(list) do
            if prot.name == prot_name then
                return prot
            end
        end
    end

    local recipe = game.recipe_prototypes[recipe_name]

    if recipe then
        local prot
        if prot_name then
            prot = find_prot(recipe.products) or find_prot(recipe.ingredients)

            if prot == nil then
                Debug:error(Remote.classname, "FNEI remote error: unknown prot_name: \"", prot_name, "\" for recipe:", recipe_name)
                return
            end
        elseif recipe.products and #recipe.products > 0 then
            prot = recipe.products[1]
        elseif recipe.ingredients and #recipe.ingredients > 0 then
            prot = recipe.ingredients[1]
        else
            Debug:error(Remote.classname, "FNEI remote error: recipe don't contaains ingridient and products:", recipe_name)
            return
        end

        Controller.get_cont("recipe").add_element_in_recipe_list("craft", prot.type, prot.name, recipe.name)
        Controller.open_event("recipe")
    else
        Debug:error(Remote.classname, "FNEI remote error: unknown recipe_name:", recipe_name)
    end
end

function Remote:init()
    remote.add_interface("fnei",
        {
            version = self.version,
            show_recipe_for_prot = self.show_recipe_for_prot,
            show_recipe = self.show_recipe
        }
    )
end