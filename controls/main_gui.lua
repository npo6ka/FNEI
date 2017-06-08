if not fnei.main_gui.search_text then fnei.main_gui.search_text = "" end

function fnei.main_gui.open_main_gui(player)
  fnei.main_gui.close_main_gui(player)

  local ui  = player.gui.left.add({type = "frame", name = "fnei_main_gui",direction = "vertical"})
  local search_line = ui.add({type = "frame", name = "fnei_search_line", direction = "horizontal"})
  ui.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})
  local buttons = ui.add({type = "flow", name = "fnei_page_line", direction = "horizontal"})

  search_line.add({type = "label", caption = "Search:"})
  search_line.add({type = "textfield", name = "fnei_search_field", text = fnei.main_gui.search_text})
  buttons.add({type = "button", name = "fnei_prev_elemen_page", caption = "<"})
  buttons.add({type = "label", name = "fnei_page_number", caption = "empty_main_page"})
  buttons.add({type = "button", name = "fnei_next_elemet_page", caption = ">"})
end

function fnei.main_gui.close_main_gui(player)
  if fnei.main_gui.is_main_gui_open(player) then
    local text = fnei:get_gui(player.gui.left, "fnei_search_field").text --problem
    if text ~= nil then fnei.main_gui.search_text = text end
    player.gui.left.fnei_main_gui.destroy()
  end
end

function fnei.main_gui.is_main_gui_open(player)
  if player.gui.left.fnei_main_gui then
    return true
  else
    return false
  end
end

function fnei.main_gui.set_main_gui(player, tb_width, elements, cnt_page, cur_page)
  local page_number = fnei:get_gui(player.gui.left, "fnei_page_number")
  page_number.caption = "page: " .. cur_page .. "/" .. cnt_page

  local elem_list = fnei:get_gui(player.gui.left, "fnei_element_list")
  if elem_list.fnei_table then
    elem_list.fnei_table.destroy()
  end
  tb = elem_list.add({type = "table", name = "fnei_table", colspan = tb_width})

  for _,element in pairs(elements) do
    tb.add(get_image(element.name, element.type))
  end
end