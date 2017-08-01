if not fnei.mc.page then fnei.mc.page = 1 end
if not fnei.mc.elem_list then fnei.mc.elem_list = {} end
if not fnei.mc.width then fnei.mc.width = 10 end
if not fnei.mc.height then fnei.mc.height = 10 end

require "controls/gui"

function fnei.mc.back_key(player)
  if fnei.gui.is_main_open(player) then
    fnei.gui.exit_from_gui(player)
  end
end

function fnei.mc.main_key(player)
  if fnei.gui.is_main_open(player) then
    fnei.gui.exit_from_gui(player)
  else
    fnei.mc.set_new_list(player)
  end
end

function fnei.mc.search_text_cheged(player)
  local text = fnei:get_gui(get_gui_pos(player, fnei.gui.location), "fnei_search_field").text
  fnei.main_gui.search_text = text:gsub(" ", "-"):lower()
  fnei.mc.set_new_list(player)
end

function fnei.mc.open_gui(player)
  local amnt = #fnei.mc.elem_list
  local bgn_elem = (fnei.mc.page - 1) * fnei.mc.page_size() + 1
  local end_elem = bgn_elem + fnei.mc.page_size() - 1
  local other = 0
  if (amnt < end_elem) then
    other = end_elem - amnt
    end_elem = amnt
  end

  send_table = {}
  for i = bgn_elem, end_elem do
    fnei.mc.elem_list[i] = set_style(fnei.mc.elem_list[i])
    table.insert(send_table, fnei.mc.elem_list[i])
  end
  for i = 1, other do
    table.insert(send_table, {name = "", type = "empty"})
  end

  fnei.gui.open_main_gui(player, fnei.mc.width, send_table, fnei.mc.amount_page(), fnei.mc.page)
end

function fnei.mc.set_new_list(player)
  --local search_field = fnei:get_gui(get_gui_pos(player, fnei.gui.location), "fnei_search_field")
  local search_text = fnei.main_gui.search_text
  
  fnei.mc.get_new_list_elems(search_text)
  fnei.mc.open_gui(player)
end

function fnei.mc.clear_search_text(player)
  local search_field = fnei:get_gui(get_gui_pos(player, fnei.gui.location), "fnei_search_field")
  search_field.text = ""
  fnei.mc.search_text_cheged(player)
end

------------------------List-------------------------
function fnei.mc.get_new_list_elems(search_text)
  fnei.mc.set_elem_list(get_prototypes_list(search_text))
end

function fnei.mc.set_elem_list(list)
  clear_list(fnei.mc.elem_list)
  fnei.mc.elem_list = list
  fnei.mc.set_page(fnei.mc.page)
end
------------------------Page-------------------------
function fnei.mc.set_page(value)
  local max_page =  fnei.mc.amount_page()
  if value < 1 then 
    fnei.mc.page = max_page
    return
  end
  
  if value > max_page then
    fnei.mc.page = 1
    return
  end
  fnei.mc.page = value
end

function fnei.mc.reload_list_elems(player)
  if #fnei.mc.elem_list == 0 then
    local search_field = fnei:get_gui(get_gui_pos(player, fnei.gui.location), "fnei_search_field")
    if search_field then
      fnei.mc.get_new_list_elems(search_field.text)
    end
  end
end

function fnei.mc.main_gui_next_page(player)
  fnei.mc.reload_list_elems(player)
  fnei.mc.set_page(fnei.mc.page + 1)
  fnei.mc.open_gui(player)
end

function fnei.mc.main_gui_prev_page(player)
  fnei.mc.reload_list_elems(player)
  fnei.mc.set_page(fnei.mc.page - 1)
  fnei.mc.open_gui(player)
end

function fnei.mc.amount_page()
  return math.floor(#fnei.mc.elem_list / fnei.mc.page_size()) + 1
end

function fnei.mc.page_size()
  return fnei.mc.width * fnei.mc.height
end