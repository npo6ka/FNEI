local HotbarController = {
  classname = "FNHotbarController",
}

local HotbarGui = require "scripts/hotbar/gui"
local favorite = "fav_arr"
local last_usage = "last_arr"
local last_tmp = "last_usage_tmp"
local last_usage_size = 21

function HotbarController.init_events()
  favorite = Array:new(favorite)
  last_usage = Array:new(last_usage)
  last_tmp = Array:new(last_tmp)

  HotbarGui.init_events()
  Events.add_custom_event(HotbarGui.name, "button", "hide-button", HotbarController.change_recipe_visibility)
  Events.add_custom_event(HotbarGui.name, "sprite-button", "favorite", HotbarController.favorite_empty_button_click_event)
  Events.add_custom_event(HotbarGui.name, "sprite-button", "last-usage", HotbarController.last_empty_button_click_event)
  Events.add_custom_event(HotbarGui.name, "sprite-button", "rfavorite", HotbarController.favorite_recipe_click_event)
  Events.add_custom_event(HotbarGui.name, "sprite-button", "rlast-usage", HotbarController.last_recipe_click_event)
  Events.add_custom_event(HotbarGui.name, "choose-elem-button", "rfavorite", HotbarController.favorite_recipe_click_event)
  Events.add_custom_event(HotbarGui.name, "choose-elem-button", "rlast-usage", HotbarController.last_recipe_click_event)
end

function HotbarController.exit()
  out("hotbar exit")

  Controller.set_cur_con_name("hotbar")

  HotbarGui.close_window()
  
  Controller.remove_last_con_name()
end

function HotbarController.open()
  out("hotbar open")

  if Settings.get_val("show-hotbar") then
    Controller.set_cur_con_name("hotbar")

    local ret_gui = HotbarGui.open_window()
    HotbarGui.draw_hotbar_bar_extension(HotbarController.get_last_usage_list(), favorite)
    
    Controller.remove_last_con_name()

    return ret_gui
  else 
    HotbarController.exit()
  end
end

function HotbarController.back_key()
  return false
end

function HotbarController.can_open_gui()
  return true
end

function HotbarController.get_name()
  return HotbarGui.name
end

function HotbarController.is_gui_open()
  return HotbarGui.is_gui_open()
end

function HotbarController.on_configuration_change()
  HotbarController.update_recipes(favorite)
  HotbarController.update_recipes(last_usage)
  HotbarController.open()
end

---------------------------- api -----------------------------

function HotbarController.get_favorite_recipe_state(recipe)
  return favorite:get_elem_pos(recipe) ~= nil
end

function HotbarController.change_favorite_recipe_state(recipe)
  if HotbarController.get_favorite_recipe_state(recipe) then
    favorite:remove(favorite:get_elem_pos(recipe))
    HotbarController.open()
    Controller.get_cont("recipe").draw_favorite_button()
  else
    local slot = favorite:get_first_free_slot( )

    if slot > Settings.get_val("hotbar-fav-line-num") * 2 then
      Player.print({ "fnei.favorite-is-full" })
    else
      HotbarController.add_last_elem(recipe)

      favorite:insert(recipe, slot)
      HotbarController.open()
    end
  end
end

function HotbarController.update_recipes(check_array)
  local recipe = get_all_recipes()

  local indx = 1
  while check_array:size() >= indx do
    local elem = check_array:get(indx)

    if recipe[elem.recipe_name] == nil then
      check_array:remove(indx)
    else
      indx = indx + 1
    end
  end
end

function HotbarController.get_last_usage_list()
  local array = last_usage:get_array( )
  last_tmp:clear()

  for i,j in pairs(array) do
    if last_tmp:get_elem_pos(j) == nil then
      last_tmp:insert_tail(j)
    end
  end

  return last_tmp
end

function HotbarController.remove_same_recipe_without_first(in_array)
  local array = in_array:get_array( )
  last_tmp:clear()
  local first = true

  for i,j in pairs(array) do
    if first then
      first = false
    else
      if last_tmp:get_elem_pos(j) == nil then
        last_tmp:insert_tail(j)
      else
      end
    end
  end
  last_tmp:insert_head(array[1])

  in_array:clear()

  array = last_tmp:get_array()
  for i,j in pairs(array) do
    in_array:insert_tail(j)
  end
end

function HotbarController.add_last_elem(recipe)
  last_usage:insert_head(recipe)

  if last_usage_size < last_usage:size() then
    last_usage:remove(last_usage_size + 1)
  end

  HotbarController.remove_same_recipe_without_first(last_usage)
  HotbarController.open()
end

function HotbarController.replace_last_elem(recipe)
  if last_usage:get(1) then
    last_usage:remove(1)
  end

  HotbarController.add_last_elem(recipe)
end

----------------------------------- evenets -----------------------------------

function HotbarController.change_recipe_visibility(event)
  local setting = "show-extended-hotbar"
  local val = not Settings.get_val(setting)
  Settings.set_val(setting, val)

  HotbarController.open()
end

function HotbarController.change_hotbar_visibility(event)
  HotbarController.open()
end

function HotbarController.favorite_recipe_click_event(event, arg, args)
  if event.alt == true then
    local rec_con = Controller.get_cont("recipe")
    local page = rec_con.get_page_name_for_recipe(args[4], args[5], args[6], args[7])
    local recipe = rec_con.get_recipe_stucture(args[5], args[6], args[4], page.name)

    HotbarController.change_favorite_recipe_state(recipe)
  else
    Controller.get_cont("recipe").add_element_in_recipe_list(args[4], args[5], args[6], args[7])
    Controller.open_event("recipe")
  end
end

function HotbarController.last_recipe_click_event(event, arg, args)
  Controller.get_cont("recipe").add_element_in_recipe_list(args[4], args[5], args[6], args[7])
  Controller.open_event("recipe")
end

function HotbarController.favorite_empty_button_click_event(event)
  if Controller.get_cur_con() == nil then 
    Controller.open_event("main")
  end
end

function HotbarController.last_empty_button_click_event(event)
  if Controller.get_cur_con() == nil then 
    Controller.open_event("main")
  end
end

return HotbarController