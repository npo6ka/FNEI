Remote = {
    classname = "FNRemote"
}

local version = 1

-- Returns the current version so other mods can focus on one specific version of the API
-- Usage example: remote.call("fnei", "version")
function Remote.version()
    return version
end

-- Explanation of the parameters used:
--   action_type: the kind of recipes that should be shown ("craft" or "usage")
--   prot_type: the type-property of the item prototype ("item" or "fluid")
--   prot_name: the name of the prototype for which a list of recipes is shown
--   cur_page: the name of the recipe prototype out of the list that should be shown
 
-- A 1-to-1 translation of the internal method of displaying an item
-- Usage example: remote.call("fnei", "show_item", "craft", "item", "iron-plate")
function Remote.show_item(action_type, prot_type, prot_name)
    Controller.get_cont("recipe").add_element_in_recipe_list(action_type, prot_type, prot_name)
    Controller.open_event("recipe")
end

-- This will show a list with all the recipes for the given item (like show_item would), but select/show
-- the recipe given by cur_page from that list. It will always use action_type "craft", because the
-- desired recipe won't be shown otherwise.
-- Usage example: remote.call("fnei", "show_recipe", "basic-oil-processing", "fluid", "light-oil")
function Remote.show_recipe(cur_page, prot_type, prot_name)
    Controller.get_cont("recipe").add_element_in_recipe_list("craft", prot_type, prot_name, cur_page)
    Controller.open_event("recipe")
end

function Remote:init()
    remote.add_interface("fnei", 
        {
            version = self.version,
            show_item = self.show_item,
            show_recipe = self.show_recipe
        }
    )
end