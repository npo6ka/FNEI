

function fnei.recipe_gui.open_recipe_gui(player)
  fnei.recipe_gui.close_recipe_gui(player)

  local test = get_gui(player, fnei.gui.location).add({type = "frame", name = "fnei_recipe_flow", direction = "vertical", style = "fnei_recipe_flow"})
  local ui = test.add({type = "frame", name = "fnei_recipe_gui", direction = "vertical"})
  
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

  local list_ingr_frame = prod_table.add({type = "frame", name = "fnei_list_ingr_frame"})
  local list_ingr_scroll = list_ingr_frame.add({type = "scroll-pane", name = "fnei_list_ingr_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
  list_ingr_scroll.add({type = "table", name = "fnei_list_ingr", colspan = 1, style = "fnei_list_elements"})


  local list_res_frame = prod_table.add({type = "frame", name = "fnei_list_res_frame"})
  local list_res_scroll = list_res_frame.add({type = "scroll-pane", name = "fnei_list_res_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
  list_res_scroll.add({type = "table", name = "fnei_list_res", colspan = 1, style = "fnei_list_elements"})

  local madein_gui = gui_table.add({type = "frame", name = "fnei_madein_frame", direction = "horizontal"})
  madein_gui.add({type = "label", caption = {"description.made-in"}})
  madein_gui.add({type = "table", name = "fnei_madein_table", colspan = 5})

  local tech_gui = gui_table.add({type = "flow", name = "fnei_tech_flow", direction = "horizontal"})
end

function fnei.recipe_gui.close_recipe_gui(player)
  if fnei.recipe_gui.is_recipe_gui_open(player) then
    get_gui(player, fnei.gui.location).fnei_recipe_flow.destroy()
  end
end

function fnei.recipe_gui.is_recipe_gui_open(player)
  if get_gui(player, fnei.gui.location).fnei_recipe_flow then
    return true
  else
    return false
  end
end

function fnei.recipe_gui.set_recipe_gui(player, recipe_name, time, ingr_list, prod_list, madein_list, tech, cur_page, cnt_page, enabled, localised_name)
  local recipe_label = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_label")
  recipe_label.style = get_recipe_style(enabled)
  recipe_label.caption = {"", localised_name}

  local gui_ingr_list = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_list_ingr")
  local gui_res_list = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_list_res")
  local list_diff = #ingr_list + 1 - #prod_list

--ingridient list
  local time_slot = gui_ingr_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
  time_slot.add({
    type = "sprite-button",
    name = "fnei_time",
    style = "slot_button_style",
    tooltip = {"", "time"},
    sprite = "fnei_time_icon"
  })
  time_slot.add(get_element_lable(time))

  for _,ingr in pairs(ingr_list) do
    local ing_str = gui_ingr_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
    ing_str.add(get_image(ingr.name, ingr.type .. "Name", "slot_button_style"))
    ing_str.add(get_element_lable(get_recipe_caption(ingr)))
  end
  if #ingr_list < 8 then
    local gui_ingr_scroll = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_list_ingr_scroll")
    gui_ingr_scroll.vertical_scroll_policy = "never"
  end
  for i=1, -list_diff do
    gui_ingr_list.add({type = "flow", style = "fnei_list_elements_flow"})
  end

--result list
  for _,res in pairs(prod_list) do
    local res_str = gui_res_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
    res_str.add(get_image(res.name, res.type  .. "Name", "slot_button_style"))
    res_str.add(get_element_lable(get_recipe_caption(res)))
  end
  if #prod_list < 9 then
    local gui_res_scroll = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_list_res_scroll")
    gui_res_scroll.vertical_scroll_policy = "never"
  end
  for i=1, list_diff do
    gui_res_list.add({type = "flow", style = "fnei_list_elements_flow"})
  end

--made in
  local gui_madein = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_madein_table")
  for _,item in pairs(madein_list) do
    gui_madein.add(get_image(item.name, item.type, "slot_button_style"))
  end
--tech
  if tech ~= nil then
    local tech_flow = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_tech_flow")
    local gui_tech = tech_flow.add({type = "frame", name = "fnei_tech_frame", direction = "horizontal"})
    gui_tech.add({type = "label", caption = {"gui-technology.title"}})
    gui_tech.add(get_image(tech, "tech", get_tech_style(tech)))
  end
--page
  local page_recipe_gui = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_pagenum")
  page_recipe_gui.add({type = "label", caption = "recipe: " .. cur_page .. "/" .. cnt_page})
end