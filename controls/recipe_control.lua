require "controls/gui"

-------------------- getters and setters ---------------------

function fnei.rc.get_player_data( player )
  local name = (player and player.name) or "nil"
  if name == "nil" then out("player_data == nil") end

  if not global.fnei.rc[name] then
    global.fnei.rc[name] = {}
  end
  return global.fnei.rc[name]
end

function fnei.rc.get_recipe_page( player )
  local data = fnei.rc.get_player_data(player)
  if not data.recipe_page then
    data.recipe_page = 1
  end
  return data.recipe_page
end

function fnei.rc.set_recipe_page( player, value )
  local max_page = #fnei.rc.get_recipe_list(player)
  if value < 1 then
    fnei.rc.get_player_data(player).recipe_page = max_page
  elseif value > max_page then
    fnei.rc.get_player_data(player).recipe_page = 1
  else
    fnei.rc.get_player_data(player).recipe_page = value
  end
  fnei.rc.set_cur_recipe_page(player)
end

function fnei.rc.get_search_stack( player )
  local data = fnei.rc.get_player_data(player)
  if not data.search_stack then
    data.search_stack = {}
  end
  return data.search_stack
end

function fnei.rc.get_recipe_list( player )
  local data = fnei.rc.get_player_data(player)
  if not data.recipe_list then
    data.recipe_list = {}
  end
  return data.recipe_list
end

function fnei.rc.set_recipe_list(player, list, page)
  if not list or #list == 0 then
    return false
  end
  fnei.rc.get_player_data(player).recipe_list = sort_enable_recipe_list(list)
  fnei.rc.set_recipe_page(player, page)
  return true
end

----------------------- Controls -----------------------------------

function fnei.rc.back_key(player)
  local stack_size = #fnei.rc.get_search_stack(player)
  if stack_size == 1 then
    fnei.gui.close_recipe(player)
    fnei.rc.delete_recipe_name(player)
    fnei.mc.set_new_list(player)
    fnei.mc.open_gui(player)
  elseif stack_size > 1 then
    fnei.rc.delete_recipe_name(player)
    fnei.rc.set_new_recipe_list(player)
  elseif stack_size == 0 then
    fnei.gui.close_recipe(player)
    fnei.mc.set_new_list(player)
    fnei.mc.open_gui(player)
  else
    player.print("fnei.rc.back_key: stack_size value = " .. stack_size)
  end
end

function fnei.rc.main_key(player)
  fnei.gui.exit_from_gui(player)
end

function fnei.rc.element_left_click(player, element)
  if fnei.rc.insert_recipe_name(player, element, "craft") then
    if fnei.gui.is_main_open(player) then
      fnei.gui.close_main(player)
    end

    fnei.rc.set_new_recipe_list(player)
  end
end

function fnei.rc.element_right_click(player, element)
  if fnei.rc.insert_recipe_name(player, element, "usage") then
    if fnei.gui.is_main_open(player) then
      fnei.gui.close_main(player)
    end
    fnei.rc.set_new_recipe_list(player)
  end
end

function fnei.rc.open_gui(player)
  local cur_page = fnei.rc.get_recipe_page(player)
  local recipe = fnei.rc.get_recipe_list(player)[cur_page]
  fnei.gui.open_recipe_gui(player, recipe, cur_page, #fnei.rc.get_recipe_list(player))
end

function fnei.rc.set_new_recipe_list(player)
  local elem_num = #fnei.rc.get_search_stack(player)
  if elem_num < 1 then
    return
  end
  local element = fnei.rc.get_search_stack(player)[elem_num]

  if (element.property == "craft" and not fnei.rc.set_recipe_list(player, get_craft_recipe_list(player, element), element.page)) or
     (element.property == "usage" and not fnei.rc.set_recipe_list(player, get_usage_recipe_list(player, element), element.page)) then
    return
  end
  fnei.rc.open_gui(player)
end


------------------------Name_List--------------------------
function fnei.rc.insert_recipe_name(player, element, element_property)
  if element_exist(element) then
    if (element_property == "craft" and #get_craft_recipe_list(player, element) > 0) or
       (element_property == "usage" and #get_usage_recipe_list(player, element) > 0) then
        local prev_elem = nil
        local src_stck = fnei.rc.get_search_stack(player)
        if #src_stck > 0 then
          prev_elem = src_stck[#src_stck]
        end
        if prev_elem == nil or prev_elem.name ~= element.name or prev_elem.property ~= element_property then 
        table.insert(src_stck, {name = element.name, type = element.type, property = element_property, page = 1})
        return true
      end
    end
  end
  return false
end

function fnei.rc.set_cur_recipe_page( player )
  local src_stck = fnei.rc.get_search_stack(player)
  local cur_recipe = src_stck[#src_stck]
  if cur_recipe then 
    cur_recipe.page = fnei.rc.get_recipe_page(player)
  end
end

function fnei.rc.delete_recipe_name(player)
  table.remove(fnei.rc.get_search_stack(player))
end

------------------------Page-------------------------
function fnei.rc.recipe_gui_next(player)
  fnei.rc.set_recipe_page(player, fnei.rc.get_recipe_page(player) + 1)
  fnei.rc.open_gui(player)
end

function fnei.rc.recipe_gui_prev(player)
  fnei.rc.set_recipe_page(player, fnei.rc.get_recipe_page(player) - 1)
  fnei.rc.open_gui(player)
end