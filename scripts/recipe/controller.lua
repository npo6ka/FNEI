local RecipeController = {
  classname = "FNRecipeController"
}

local RecipeGui = require "scripts/recipe/gui"
local r_list = List:new("recipe_queue")
local pages = "recipe-pages"

function RecipeController.init_events()
  pages = Page:new(pages, RecipeController.get_name(), 1, RecipeController.change_page_event, RecipeController.change_page_event)
  RecipeGui.init_events()

  Events.add_custom_event(RecipeGui.name, "choose-elem-button", "fluid", RecipeController.open_fluid_recipe_event)
  Events.add_custom_event(RecipeGui.name, "choose-elem-button", "item", RecipeController.open_item_recipe_event)
  Events.add_custom_event(RecipeGui.name, "sprite-button", "tech", RecipeController.open_tech_event)
end

function RecipeController.exit()
  out("Recipe exit")
  Player.get_global()["gui_loc"] = RecipeGui.close_window()
end

function RecipeController.open()
  out("Recipe open")

  local gui = RecipeGui.open_window(Player.get_global()["gui_loc"])
  RecipeController.open_new_recipes()

  return gui
end

function RecipeController.back_key()
  r_list:remove()

  if RecipeController.can_open_gui() then
    RecipeController.open_new_recipes()
  end

  return r_list:is_empty()
end

function RecipeController.can_open_gui()
  return not r_list:is_empty()
end

function RecipeController.get_name()
  return RecipeGui.name
end

function RecipeController.is_gui_open()
  return RecipeGui.is_gui_open()
end

----------------------------------- gui ---------------------------------------

function RecipeController.open_new_recipes()  
  RecipeController.set_page_list()

  if pages:amount_page() == 0 then
    if RecipeController.can_open_gui() then
      r_list:remove()
      RecipeController.open_new_recipes()
    else
      Controller.back_key_event()
    end
    return
  end

  RecipeController.change_page_event()
end

function RecipeController.draw_recipe()
  local recipe = pages:get_list_for_tab(pages:get_cur_page())

  if recipe and recipe[1] then
    recipe = recipe[1]
  else
    return
  end

  RecipeGui.set_recipe_name(recipe)
  RecipeGui.set_recipe_icon(recipe)

  local prot_dif = #recipe.ingredients + 1 - #recipe.products
  RecipeGui.set_ingredients(recipe.ingredients, -prot_dif)
  RecipeGui.set_products(recipe.products, prot_dif)

  RecipeGui.set_recipe_time(recipe.energy)
  RecipeGui.set_made_in_list(recipe)
  RecipeGui.set_techs(recipe)
end

function RecipeController.draw_paging()
  RecipeGui.draw_paging(pages)
end

function RecipeController.set_crafting_type()
  local cur_prot = r_list.get() or {}
  RecipeGui.set_crafting_type(cur_prot.action_type)
end

function RecipeController.draw_cur_prot()
  local cur_prot = r_list.get() or {}
  RecipeGui.draw_cur_prot(cur_prot.type, cur_prot.name)
end

function RecipeController.get_recipe_stucture(prot_type, prot_name, action_type, saved_recipe_name)
  return  {
    type = prot_type,
    name = prot_name,
    action_type = action_type,
    recipe_name = saved_recipe_name
  }
end

function RecipeController.draw_favorite_button()
  local elem = r_list:get()

  local recipe = {}

  if elem then
    recipe = RecipeController.get_recipe_stucture(elem.type, elem.name, elem.action_type, elem.page.name)
  end

  local state = Controller.get_cont("hotbar").get_favorite_recipe_state(recipe) 
  RecipeGui.draw_favorite_state(state)
end

----------------------------------- recipe list  ---------------------------------------

function RecipeController.add_element_in_recipe_list(action_type, prot_type, prot_name, cur_page)
  local cur_gui = Controller.get_cur_con()

  if cur_gui and (cur_gui.get_name() == RecipeGui.name or cur_gui.get_name() == "settings") then
    RecipeController.add_element(action_type, prot_type, prot_name, cur_page)
  else
    RecipeController.add_element_in_new_recipe_list(action_type, prot_type, prot_name, cur_page)
  end
end

function RecipeController.add_element_in_new_recipe_list(action_type, prot_type, prot_name, cur_page)
  r_list:clear()
  local state = RecipeController.add_element(action_type, prot_type, prot_name, cur_page)
  if state then
    Controller.get_cont("hotbar").add_last_elem({ })
  end
end

function RecipeController.add_element(action_type, prot_type, prot_name, cur_page)
  local last_elem = r_list:get()

  if last_elem == nil or (prot_name ~= last_elem.name or prot_type ~= last_elem.type or action_type ~= last_elem.action_type) then
    local recipe_list = RecipeController.get_recipe_list(action_type, prot_type, prot_name)

    if recipe_list and #recipe_list > 0 then
      local page = RecipeController.get_page_name_for_recipe(action_type, prot_type, prot_name, cur_page)
      r_list:add({ type = prot_type, name = prot_name, action_type = action_type, page = page })
      return true
    end
  else
    last_elem.page = RecipeController.get_page_name_for_recipe(action_type, prot_type, prot_name, cur_page)
  end
end

function RecipeController.get_page_name_for_recipe(action_type, prot_type, prot_name, cur_page)
  if cur_page then
    local recipe = get_recipe_list()[cur_page]

    if recipe then
      return recipe
    end
  end

  local global = Player.get_global()

  if not global.recipe_page then global.recipe_page = {} end

  if action_type and prot_type and prot_name then
    local name = action_type .. prot_type .. prot_name

    return global.recipe_page[name]
  else
    Debug:error("Error in function RecipeController.get_page_name_for_recipe: nil value")
  end
end

function RecipeController.set_page_name_for_recipe(action_type, prot_type, prot_name, val)
  local global = Player.get_global()

  if not global.recipe_page then global.recipe_page = {} end

  if action_type and prot_type and prot_name then
    local name = action_type .. prot_type .. prot_name

    global.recipe_page[name] = val
  else
    Debug:error("Error in function RecipeController.set_page_name_for_recipe: nil value")
  end
end

function RecipeController.save_page()
  local val = r_list:get()

  if val then
    local list = pages:get_list_for_tab(pages:get_cur_page())

    if list and list[1] then
      RecipeController.set_page_name_for_recipe(val.action_type, val.type, val.name, list[1])
      val.page = list[1]
    end
  end
end

function RecipeController.change_last_opened_recipe()
  local elem = r_list:get()
  local recipe = {}

  if elem then
    recipe = RecipeController.get_recipe_stucture(elem.type, elem.name, elem.action_type, elem.page.name)
  end

  Controller.get_cont("hotbar").replace_last_elem( recipe )
end

----------------------------------- paging ---------------------------------------

function RecipeController.set_page_list()
  local last_prot = r_list.get()

  if last_prot then
    pages:set_page_list(RecipeController.get_recipe_list(last_prot.action_type, last_prot.type, last_prot.name))
  end

  RecipeController.set_cur_page()
end

function RecipeController.set_cur_page()
  local val = r_list.get()

  if val and val.page then
    local end_val = pages:amount_page()
    
    for i = 1,end_val do
      local recipe = pages:get_list_for_tab(i)
      if recipe and recipe[1] == val.page then
        pages:set_cur_page(i)
        return
      end
    end
  end

  pages:set_cur_page(1)
end

-------------------------------- events ----------------------------------------

function RecipeController.open_item_recipe_event(event, elem_name)
  if elem_name == "item" then
    local _,pos = string.find(event.element.name, "item%_")

    if pos then
      elem_name = string.sub(event.element.name, pos + 1)
    end

    if event.button == defines.mouse_button_type.right then
      RecipeController.add_element("usage", "item", elem_name)
      RecipeController.open_new_recipes()
    else
      RecipeController.add_element("craft", "item", elem_name)
      RecipeController.open_new_recipes()
    end
  end
end

function RecipeController.open_fluid_recipe_event(event, elem_name)
  if elem_name == "fluid" then
    local _,pos =  string.find(event.element.name, "fluid%_")

    if pos then
      elem_name = string.sub(event.element.name, pos + 1)
    end

    if event.button == defines.mouse_button_type.right then
      RecipeController.add_element("usage", "fluid", elem_name)
      RecipeController.open_new_recipes()
    else
      RecipeController.add_element("craft", "fluid", elem_name)
      RecipeController.open_new_recipes()
    end
  end
end

function RecipeController.open_tech_event(event, elem_name, split_names)
  local tech_name = split_names[4]
  local el_num = 5

  -- if tech contains '_' in name, need add this part here
  while split_names[el_num] ~= nil do
    tech_name = tech_name .. "_" .. split_names[el_num]
    el_num = el_num + 1
  end 

  if is_attainable_tech(get_tech_list()[tech_name]) or Settings.get_val("open-unavailable-techs") then
    TechHook.save_cur_fnei_state()
    Player.get().open_technology_gui(tech_name)
  end
end

function RecipeController.change_page_event()
  RecipeController.draw_paging()
  RecipeController.draw_recipe()
  RecipeController.set_crafting_type()
  RecipeController.draw_cur_prot()
  RecipeController.save_page()
  RecipeController.draw_favorite_button()
  RecipeController.change_last_opened_recipe()
end

function RecipeController.settings_key_event(event)
  Controller.open_event("settings")
end

function RecipeController.back_key_event(event)
  if event.control or event.shift then
    r_list:clear()
  end

  Controller.back_key_event()
end

local state = true

function RecipeController.favorite_key_event(event)
  local elem = r_list:get()
  local recipe = {}

  if elem then
    recipe = RecipeController.get_recipe_stucture(elem.type, elem.name, elem.action_type, elem.page.name)
  end

  Controller.get_cont("hotbar").change_favorite_recipe_state( recipe )
  RecipeController.draw_favorite_button()
end

-------------------------------- recipe list ----------------------------------------

function RecipeController.get_recipe_list(action_type, type, prot)
  local recipe_list = {}
  if action_type == "craft" then
    recipe_list = RecipeController.get_caraft_recipe_list(prot, type)
  elseif action_type == "usage" then
    recipe_list = RecipeController.get_usage_recipe_list(prot, type)
  else
    Debug:error("Error in function RecipeController.get_recipe_list: unknown craft type: ", action_type, "")
  end

  local rec_list = get_filtred_recipe_list(recipe_list)
  rec_list = RecipeController.delete_equals_recipe(rec_list)

  return RecipeController.sort_recipe_list(rec_list)
end

function RecipeController.delete_equals_recipe(list)
  if not Settings.get_val("show-the-same-recipes") then
    local ret_tb = {}
    local eq_rec = get_equals_recipe_list()

    for name, recipe in pairs(list) do
      if eq_rec[name] then
        local flag = true

        for _, s_recipe in pairs(eq_rec[name]) do
          if s_recipe.valid and ret_tb[s_recipe.name] then
            flag = false
            break
          end
        end

        if flag then 
          ret_tb[name] = recipe
        end
      else
        ret_tb[name] = recipe
      end
    end

    return ret_tb
  end
  return list
end

function RecipeController.sort_recipe_list(recipe_list)
  local en_list = {}
  local dis_list = {}
  local hid_list = {}

  for _,recipe in pairs(recipe_list) do
    if recipe.hidden then
      table.insert(hid_list, recipe)
    elseif recipe.enabled then
      table.insert(en_list, recipe)
    else
      table.insert(dis_list, recipe)
    end
  end

  local ret_tb = {}

  for _,recipe in pairs(en_list) do
    table.insert(ret_tb, recipe)
  end
  for _,recipe in pairs(dis_list) do
    table.insert(ret_tb, recipe)
  end
  for _,recipe in pairs(hid_list) do
    table.insert(ret_tb, recipe)
  end

  return ret_tb
end

function RecipeController.get_caraft_recipe_list(element, el_type)
  local recipes = get_recipe_list()
  local ret_tb = {}

  for _,recipe in pairs(recipes) do
    for _,product in pairs(recipe.products) do
      if product.name == element and product.type == el_type then
        ret_tb[recipe.name] = recipe
      end
    end
  end

  return ret_tb
end

function RecipeController.get_usage_recipe_list(element, el_type)
  local recipes = get_recipe_list()
  local ret_tb = {}

  for _,recipe in pairs(recipes) do
    for _,ingredient in pairs(recipe.ingredients) do
      if ingredient.name == element and ingredient.type == el_type then
        ret_tb[recipe.name] = recipe
      end
    end
  end

  return ret_tb
end

--------------------------------------------------------------------------------------

return RecipeController
