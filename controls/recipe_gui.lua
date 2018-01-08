function fnei.recipe_gui.get_recipe_caption(element, player)
  if not element then
    return "unknown name"
  end
  if element.amount then
    return {"fnei.recipe-amnt", element.amount, get_localised_name(element)}
  else
    local min = element.amount_min or 0
    local max = element.amount_max or 0
    local prob = element.probability or 0
    local ret_val

    if not fnei.oc.detail_chance( player ) then
      ret_val = (min + max) / 2 * prob
      return {"fnei.recipe-amnt", round(ret_val, 3), get_localised_name(element)}
    end

    if min ~= max then
      ret_val = {"fnei.recipe-amnt-range", min, max}
    else
      ret_val = max
    end
    if prob == 1 then
      return {"fnei.recipe-amnt", ret_val, get_localised_name(element)}
    else
      return {"fnei.recipe-amnt-prob", {"fnei.recipe-amnt", ret_val, round(prob, 3)}, get_localised_name(element)}
    end
  end
end

function fnei.recipe_gui.get_tech_style(tech)
  if not tech then 
    return "fnei_empty_slot_button_style" 
  end
  if tech.researched then
    return "fnei_green_tech_button_style"
  else
    local preq = tech.prerequisites
    for _,tec in pairs(preq) do
      if tec and not tec.researched then
        return "fnei_red_tech_button_style"
      end
    end
    return "fnei_yellow_tech_button_style"
  end
end

function fnei.recipe_gui.get_element_lable(caption)
  return {
    type = "label", 
    caption = caption, 
    style = "fnei_recipe_element"
  }
end

function fnei.recipe_gui.get_recipe_style(enabled)
  if enabled then 
    return "fnei_recipe_title_label"
  else
    return"fnei_red_recipe_title_label"
  end
end

function fnei.recipe_gui.open_recipe_gui(player)
  fnei.recipe_gui.close_recipe_gui(player)

--7 space 10 pading --7/4

  local main_flow = get_gui_pos(player).add({type = "flow", name = "fnei_recipe_main_flow", style = "fnei_recipe_flow"})
    local main_frame = main_flow.add({type = "frame", name = "fnei_recipe_main_frame", style = "fnei_recipe_main_frame"})
      local main_table = main_frame.add({type = "table", name = "fnei_recipe_main_table", column_count = 1, style = "fnei_recipe_main_table"})
        local header = main_table.add({type = "frame", name = "fnei_recipe_header_frame", direction = "horizontal", style = "fnei_recipe_header_frame"})
          local header_tab = header.add({type = "table", name = "fnei_recipe_header_table", column_count = 5, style = "fnei_recipe_header_table"})
            header_tab.add({type = "flow", name = "fnei_recipe_header_icon"})
            header_tab.add({type = "label", name = "fnei_recipe_header_label", caption = "recipe_name"})
            header_tab.add({type = "sprite-button", name = "fnei_recipe_back_key", style = "fnei_back_button_style", tooltip = {"fnei.back-key"}})
            header_tab.add({type = "sprite-button", name = "fnei_recipe_settings_key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"}})
            header_tab.add({type = "sprite-button", name = "fnei_recipe_exit_key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"}})
        local paging = main_table.add({type = "frame", name = "fnei_recipe_paging_frame", style = "fnei_recipe_paging_frame"})
          local paging_tab = paging.add({type = "table", name = "fnei_recipe_paging_table", column_count = 5, style = "fnei_recipe_paging_table"})
            local arrow = paging_tab.add({type = "flow", name = "fnei_recipe_left_arrow_flow", style = "fnei_arrow_flow"})
              arrow.add({type = "sprite-button", name = "fnei_recipe_left_key", style = "fnei_left_arrow_button_style", tooltip = {"fnei.previous-key"}, sprite = ""})
            paging_tab.add({type = "label", name = "fnei_recipe_type_lable", caption = "something", style = "fnei_recipe_type_lable"})
            paging_tab.add({type = "flow", name = "fnei_recipe_item_icon"})
            paging_tab.add({type = "label", name = "fnei_recipe_paging_label", caption = "page unknown", style = "fnei_recipe_paging_label"})
            arrow = paging_tab.add({type = "flow", name = "fnei_recipe_right_arrow_flow", style = "fnei_arrow_flow"})
              arrow.add({type = "sprite-button", name = "fnei_recipe_right_key", style = "fnei_right_arrow_button_style", tooltip = {"fnei.next-key"}, sprite = ""})
        local prod_table = main_table.add({type = "table", name = "fnei_prod_table", column_count = 2, style = "fnei_prod_table"})
          local label_ingridients = prod_table.add({type = "frame", name = "fnei_recipe_ingr_frame", style = "fnei_recipe_ingr_frame"})
            label_ingridients.add({type = "label", caption = {"fnei.ingredients"}})
          local label_results = prod_table.add({type = "frame", name = "fnei_recipe_res_frame", style = "fnei_recipe_res_frame"})
            label_results.add({type = "label", caption = {"fnei.results"}})
          local list_ingr_frame = prod_table.add({type = "frame", name = "fnei_recipe_list_ingr_frame", style = "fnei_recipe_list_ingr_frame"})
            local list_ingr_scroll = list_ingr_frame.add({type = "scroll-pane", name = "fnei_list_ingr_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
              list_ingr_scroll.add({type = "table", name = "fnei_list_ingr", column_count = 1, style = "fnei_recipe_list_elements"})
          local list_res_frame = prod_table.add({type = "frame", name = "fnei_recipe_list_res_frame", style = "fnei_recipe_list_res_frame"})
            local list_res_scroll = list_res_frame.add({type = "scroll-pane", name = "fnei_list_res_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
              list_res_scroll.add({type = "table", name = "fnei_list_res", column_count = 1, style = "fnei_recipe_list_elements"})
        local madein_gui = main_table.add({type = "frame", name = "fnei_madein_frame", direction = "horizontal"})
          madein_gui.add({type = "label", caption = {"fnei.made-in"}, style = "fnei_recipe_madein"})
          madein_gui.add({type = "table", name = "fnei_madein_table", column_count = 5})
end

function fnei.recipe_gui.close_recipe_gui(player)
  if fnei.recipe_gui.is_recipe_gui_open(player) then
    get_gui_pos(player).fnei_recipe_main_flow.destroy()
  end
end

function fnei.recipe_gui.is_recipe_gui_open(player)
  if get_gui_pos(player).fnei_recipe_main_flow then
    return true
  else
    return false
  end
end

function fnei.recipe_gui.set_recipe_gui(player, recipe_name, time, ingr_list, prod_list, madein_list, tech, cur_page, cnt_page, enabled, localised_name, cur_elem)
  --header
  local recipe_label = fnei:get_gui(get_gui_pos(player), "fnei_recipe_header_label")
  recipe_label.style = fnei.recipe_gui.get_recipe_style(enabled)
  recipe_label.caption = {"", localised_name}

  local recipe_icon = fnei:get_gui(get_gui_pos(player), "fnei_recipe_header_icon")
  recipe_icon.add(get_image(player.force.recipes[recipe_name], "recipe", "fnei_empty_button_style"))

  --current elem
  local type_lable = fnei:get_gui(get_gui_pos(player), "fnei_recipe_type_lable")
  local item_icon = fnei:get_gui(get_gui_pos(player), "fnei_recipe_item_icon")
  local paging_label = fnei:get_gui(get_gui_pos(player), "fnei_recipe_paging_label")

  if cur_elem.property == "usage" then
    type_lable.caption = {"fnei.usage-for"}
  elseif cur_elem.property == "craft" then
    type_lable.caption = {"fnei.recipe-for"}
  else
    type_lable.caption = "unknown "
  end

  item_icon.add(get_image(cur_elem.name, cur_elem.type .. "Name", "slot_button"))
  paging_label.caption = cur_page .. "/" .. cnt_page

  local gui_ingr_list = fnei:get_gui(get_gui_pos(player), "fnei_list_ingr")
  local gui_res_list = fnei:get_gui(get_gui_pos(player), "fnei_list_res")
  local list_diff = #ingr_list + 1 - #prod_list


--ingridient list
  local time_slot = gui_ingr_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
  time_slot.add({
    type = "sprite-button",
    name = "fnei_time",
    style = "slot_button",
    tooltip = {"", "time"},
    sprite = "fnei_time_icon"
  })
  time_slot.add(fnei.recipe_gui.get_element_lable(time))

  for _,ingr in pairs(ingr_list) do
    local ing_str = gui_ingr_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
    ing_str.add(get_image(ingr.name, ingr.type .. "Name", "slot_button"))
    ing_str.add(fnei.recipe_gui.get_element_lable(fnei.recipe_gui.get_recipe_caption(ingr, player)))
  end
  if #ingr_list < 8 then
    local gui_ingr_scroll = fnei:get_gui(get_gui_pos(player), "fnei_list_ingr_scroll")
    --gui_ingr_scroll.vertically_squashable = false
  end
  for i=1, -list_diff do
    gui_ingr_list.add({type = "flow", style = "fnei_list_elements_flow"})
  end

--result list
  for _,res in pairs(prod_list) do
    local res_str = gui_res_list.add({type = "flow", direction = "horizontal", style = "fnei_list_elements_flow"})
    res_str.add(get_image(res.name, res.type  .. "Name", "slot_button"))
    res_str.add(fnei.recipe_gui.get_element_lable(fnei.recipe_gui.get_recipe_caption(res, player)))
  end
  if #prod_list < 9 then
    local gui_res_scroll = fnei:get_gui(get_gui_pos(player), "fnei_list_res_scroll")
    --gui_res_scroll.vertically_squashable = false
  end
  for i=1, list_diff do
    gui_res_list.add({type = "flow", style = "fnei_list_elements_flow"})
  end

--made in
  local gui_madein = fnei:get_gui(get_gui_pos(player), "fnei_madein_table")
  for _,item in pairs(madein_list) do
    gui_madein.add(get_image(item.name, item.type, "slot_button"))
  end
--tech
  if tech ~= nil then
    local tech_flow = fnei:get_gui(get_gui_pos(player), "fnei_recipe_main_table")
    local gui_tech = tech_flow.add({type = "frame", name = "fnei_tech_frame", direction = "horizontal"})
    gui_tech.add({type = "label", caption = {"fnei.technology"}, style = "fnei_recipe_technologies"})
    gui_tech.add(get_image(tech, "tech", fnei.recipe_gui.get_tech_style(tech)))
  end
end