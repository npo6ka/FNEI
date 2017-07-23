--require "controls/auto_gui"

function set_width(gui, size)
  gui.style.minimal_width = size
  gui.style.maximal_width = size
end

function set_height(gui, size)
  gui.style.minimal_height = size
  gui.style.maximal_height = size
end

function fnei.recipe_gui.open_recipe_gui(player)
  fnei.recipe_gui.close_recipe_gui(player)

--7 space 10 pading --7/4

  local main_flow = get_gui(player, fnei.gui.location).add({type = "flow", name = "fnei_recipe_main_flow", style = "fnei_recipe_flow"})
    local main_frame = main_flow.add({type = "frame", name = "fnei_recipe_main_frame"})
      local main_table = main_frame.add({type = "table", name = "fnei_recipe_main_table", colspan = 1})
        local header = main_table.add({type = "frame", name = "fnei_recipe_header", direction = "horizontal"})
          header.add({type = "flow", name = "fnei_recipe_header_icon"})
          header.add({type = "label", name = "fnei_recipe_header_label", caption = "recipe_name"})
          header.add({type = "sprite-button", name = "fnei_recipe_back_key", style = "slot_button_style", tooltip = {"fnei.settings-key"}, sprite = "fnei_back_key"})
          header.add({type = "sprite-button", name = "fnei_recipe_settings_key", style = "slot_button_style", tooltip = {"fnei.back-key"}, sprite = "fnei_settings_key"})
          header.add({type = "sprite-button", name = "fnei_recipe_exit_key", style = "slot_button_style", tooltip = {"fnei.exit-key"}, sprite = "fnei_exit_key"})
        local paging = main_table.add({type = "frame", name = "fnei_label_recipe_frame", direction = "horizontal"})
          local arrow = paging.add({type = "flow", name = "fnei_recipe_left_arrow_flow", style = "fnei_arrow_flow"})
            arrow.add({type = "sprite-button", name = "fnei_recipe_left_key", style = "fnei_left_arrow_button_style", tooltip = {"fnei.previous-key"}, sprite = ""})
          paging.add({type = "label", name = "fnei_recipe_type_lable", caption = "something", style = "fnei_recipe_type"})
          paging.add({type = "flow", name = "fnei_recipe_item_icon"})
          paging.add({type = "label", name = "fnei_recipe_paging_label", caption = "page unknown", style = "fnei_recipe_paging"})
          arrow = paging.add({type = "flow", name = "fnei_recipe_right_arrow_flow", style = "fnei_arrow_flow"})
            arrow.add({type = "sprite-button", name = "fnei_recipe_right_key", style = "fnei_right_arrow_button_style", tooltip = {"fnei.next-key"}, sprite = ""})
        local prod_table = main_table.add({type = "table", name = "fnei_prod_table", colspan = 2})
          local label_ingridients = prod_table.add({type = "frame", direction = "horizontal"})
            label_ingridients.add({type = "label", caption = {"fnei.ingredients"}})
          local label_results = prod_table.add({type = "frame", direction = "horizontal"})
            label_results.add({type = "label", caption = {"fnei.results"}})
          local list_ingr_frame = prod_table.add({type = "frame", name = "fnei_list_ingr_frame"})
            local list_ingr_scroll = list_ingr_frame.add({type = "scroll-pane", name = "fnei_list_ingr_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
              list_ingr_scroll.add({type = "table", name = "fnei_list_ingr", colspan = 1, style = "fnei_list_elements"})
          local list_res_frame = prod_table.add({type = "frame", name = "fnei_list_res_frame"})
            local list_res_scroll = list_res_frame.add({type = "scroll-pane", name = "fnei_list_res_scroll", direction = "vertical", style = "fnei_scroll_recipe_style"})
              list_res_scroll.add({type = "table", name = "fnei_list_res", colspan = 1, style = "fnei_list_elements"})
        local madein_gui = main_table.add({type = "frame", name = "fnei_madein_frame", direction = "horizontal"})
          madein_gui.add({type = "label", caption = {"fnei.made-in"}, style = "fnei_recipe_madein"})
          madein_gui.add({type = "table", name = "fnei_madein_table", colspan = 5})
end

function fnei.recipe_gui.close_recipe_gui(player)
  if fnei.recipe_gui.is_recipe_gui_open(player) then
    get_gui(player, fnei.gui.location).fnei_recipe_main_flow.destroy()
  end
end

function fnei.recipe_gui.is_recipe_gui_open(player)
  if get_gui(player, fnei.gui.location).fnei_recipe_main_flow then
    return true
  else
    return false
  end
end

function fnei.recipe_gui.set_recipe_gui(player, recipe_name, time, ingr_list, prod_list, madein_list, tech, cur_page, cnt_page, enabled, localised_name, cur_elem)
  --header
  local recipe_label = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_header_label")
  recipe_label.style = get_recipe_style(enabled)
  recipe_label.caption = {"", localised_name}

  local recipe_icon = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_header_icon")
  recipe_icon.add(get_image(player.force.recipes[recipe_name], "recipe", "fnei_empty_button_style"))

  --current elem
  local type_lable = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_type_lable")
  local item_icon = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_item_icon")
  local paging_label = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_paging_label")

  if cur_elem.property == "usage" then
    type_lable.caption = {"fnei.usage-for"}
  elseif cur_elem.property == "craft" then
    type_lable.caption = {"fnei.recipe-for"}
  else
    type_lable.caption = "unknown "
  end

  item_icon.add(get_image(cur_elem.name, cur_elem.type .. "Name", "slot_button_style"))
  paging_label.caption = cur_page .. "/" .. cnt_page

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
    local tech_flow = fnei:get_gui(get_gui(player, fnei.gui.location), "fnei_recipe_main_table")
    local gui_tech = tech_flow.add({type = "frame", name = "fnei_tech_frame", direction = "horizontal"})
    gui_tech.add({type = "label", caption = {"fnei.technology"}, style = "fnei_recipe_technologies"})
    gui_tech.add(get_image(tech, "tech", get_tech_style(tech)))
  end
end