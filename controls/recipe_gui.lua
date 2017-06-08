function fnei.recipe_gui.open_recipe_gui(player)
  fnei.recipe_gui.close_recipe_gui(player)

  local ui = player.gui.left.add({type = "frame", name = "fnei_recipe_gui", direction = "vertical"})
  
  local gui_table = ui.add({type = "table", name = "fnei_main_table", colspan = 1})
  local label_recipe = gui_table.add({type = "frame", name = "fnei_label_recipe_frame", direction = "horizontal"})
  label_recipe.add({type = "label", name = "fnei_recipe_label", caption = "recipe_name"})

  local paging = gui_table.add({type = "flow", name = "fnei_recipe_paging", direction = "horizontal"})
  paging.add({type = "button", name = "fnei_back_recipe", caption = "<<"})
  paging.add({type = "button", name = "fnei_prev_recipe", caption = "<"})
  paging.add({type = "frame", name = "fnei_recipe_pagenum", direction = "horizontal"})
  paging.add({type = "button", name = "fnei_next_recipe", caption = ">"})
  local prod_table = gui_table.add({type = "table", name = "fnei_prod_table", colspan = 2})
  local label_ingridients = prod_table.add({type = "frame", direction = "horizontal"})
  label_ingridients.add({type = "label", caption = "ingredients:"})
  local label_results = prod_table.add({type = "frame", direction = "horizontal"})
  label_results.add({type = "label", caption = "results:"})

  local list_ingr_frame = prod_table.add({type = "frame", name = "fnei_list_ingr_frame", direction = "vertical"})
  local list_res_frame = prod_table.add({type = "frame", name = "fnei_list_res_frame", direction = "vertical"})
  list_ingr_frame.add({type = "table", name = "fnei_list_ingr", colspan = 1})
  list_res_frame.add({type = "table", name = "fnei_list_res", colspan = 1})

  local madein_gui = gui_table.add({type = "frame", name = "fnei_madein_frame", direction = "horizontal"})
  madein_gui.add({type = "label", caption = "made in: "})
  madein_gui.add({type = "table", name = "fnei_madein_table", colspan = 5})

  local tech_gui = gui_table.add({type = "flow", name = "fnei_tech_flow", direction = "horizontal"})
end

function fnei.recipe_gui.close_recipe_gui(player)
  if fnei.recipe_gui.is_recipe_gui_open(player) then
    player.gui.left.fnei_recipe_gui.destroy()
  end
end

function fnei.recipe_gui.is_recipe_gui_open(player)
  if player.gui.left.fnei_recipe_gui then
    return true
  else
    return false
  end
end

function fnei.recipe_gui.set_recipe_gui(player, recipe_name, time, ingr_list, prod_list, madein_list, tech, cur_page, cnt_page)
  local recipe_label = fnei:get_gui(player.gui.left, "fnei_recipe_label")
  recipe_label.caption = recipe_name

  local gui_ingr_list = fnei:get_gui(player.gui.left, "fnei_list_ingr")

  local time_slot = gui_ingr_list.add({type = "flow", direction = "horizontal"})
  time_slot.add({type = "label", caption = "time: "})
  time_slot.add({type = "label", caption = time})

  for _,ingr in pairs(ingr_list) do
    local ing_str = gui_ingr_list.add({type = "flow", direction = "horizontal"})
    ing_str.add(get_image(ingr.name, ingr.type .. "Name"))
    ing_str.add({type = "label", caption = ingr.amount .. " * " .. ingr.name})
  end

  local gui_res_list = fnei:get_gui(player.gui.left, "fnei_list_res")
  for _,res in pairs(prod_list) do
    local res_str = gui_res_list.add({type = "flow", direction = "horizontal"})
    res_str.add(get_image(res.name, res.type  .. "Name"))
    local amt = res.amount
    if amt == nil then amt = 0 end
    res_str.add({type = "label", caption = amt .. " * " .. res.name})
  end

  local gui_madein = fnei:get_gui(player.gui.left, "fnei_madein_table")
  for _,item in pairs(madein_list) do
    gui_madein.add(get_image(item.name, item.type))
  end

  if tech ~= nil then
    local tech_flow = fnei:get_gui(player.gui.left, "fnei_tech_flow")
    local gui_tech = tech_flow.add({type = "frame", name = "fnei_tech_frame", direction = "horizontal"})
    gui_tech.add({type = "label", caption = "technologies: "})
    gui_tech.add(get_image(tech, "tech"))
  end

  local page_recipe_gui = fnei:get_gui(player.gui.left, "fnei_recipe_pagenum")
  page_recipe_gui.add({type = "label", caption = "recipe: " .. cur_page .. "/" .. cnt_page})
end