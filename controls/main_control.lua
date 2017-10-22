if not fnei.mc.width then fnei.mc.width = 10 end
if not fnei.mc.height then fnei.mc.height = 10 end

require "controls/gui"

-------------------- getters and setters ---------------------

function fnei.mc.get_player_data( player )
  local name = (player and player.name) or "nil"
  if name == "nil" then out("player_data == nil") end

  if not fnei.mc[name] then
    fnei.mc[name] = {}
  end
  return fnei.mc[name]
end

function fnei.mc.get_elem_list( player )
  local data = fnei.mc.get_player_data(player)
  if not data.elem_list then
    data.elem_list = {}
  end
  return data.elem_list
end

function fnei.mc.set_elem_list( player, list )
  clear_list(fnei.mc.get_elem_list(player))
  fnei.mc.get_player_data(player).elem_list = list
  fnei.mc.set_page(player, fnei.mc.get_page(player))
end

function fnei.mc.get_page( player )
  local data = fnei.mc.get_player_data(player)
  if not data.page then
    data.page = 1
  end
  return data.page
end

function fnei.mc.set_page( player, value )
  local max_page =  fnei.mc.amount_page(player)
  if value < 1 then 
    fnei.mc.get_player_data(player).page = max_page
    return
  end
  
  if value > max_page then
    fnei.mc.get_player_data(player).page = 1
    return
  end
  fnei.mc.get_player_data(player).page = value
end

function fnei.mc.get_search_text( player )
  local data = fnei.mc.get_player_data(player)
  if not data.search_text then
    data.search_text = ""
  end
  return data.search_text
end

function fnei.mc.set_search_text( player, text )
  fnei.mc.get_player_data(player).search_text = text
end

------------------------- Controls ---------------------------

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
    fnei.mc.open_gui(player)
  end
end

function fnei.mc.search_text_cheged(player, text)
  fnei.mc.set_search_text(player, text)
  fnei.mc.set_new_list(player)
  fnei.mc.open_gui(player)
end

function fnei.mc.open_gui(player)
  local amnt = #fnei.mc.get_elem_list(player)
  local bgn_elem = (fnei.mc.get_page(player) - 1) * fnei.mc.page_size() + 1
  local end_elem = bgn_elem + fnei.mc.page_size() - 1
  local other = 0
  if (amnt < end_elem) then
    other = end_elem - amnt
    end_elem = amnt
  end

  send_table = {}
  local elem_list = fnei.mc.get_elem_list(player);
  for i = bgn_elem, end_elem do
    elem_list[i] = set_style(elem_list[i])
    table.insert(send_table, elem_list[i])
  end
  for i = 1, other do
    table.insert(send_table, {name = "", type = "empty"})
  end

  fnei.gui.open_main_gui(player, fnei.mc.width, send_table, fnei.mc.amount_page(player), fnei.mc.get_page(player))
end

function fnei.mc.set_new_list(player)
  local search_text = fnei.mc.get_search_text(player)
  
  fnei.mc.set_new_list_elems(player, search_text)
end

function fnei.mc.clear_search_text(player)
  local search_field = fnei:get_gui(get_gui_pos(player), "fnei_search_field")
  search_field.text = ""
  fnei.mc.search_text_cheged(player, "")
end

------------------------List-------------------------
function fnei.mc.set_new_list_elems(player, search_text)
  fnei.mc.set_elem_list(player, get_prototypes_list(player, search_text))
end

function fnei.mc.reload_list_elems(player)
  if #fnei.mc.get_elem_list(player) == 0 then
    local search_field = fnei:get_gui(get_gui_pos(player), "fnei_search_field")
    if search_field then
      fnei.mc.set_new_list_elems(player, search_field.text)
    end
  end
end

------------------------Page-------------------------

function fnei.mc.main_gui_next_page(player)
  fnei.mc.reload_list_elems(player)
  fnei.mc.set_page(player, fnei.mc.get_page(player) + 1)
  fnei.mc.open_gui(player)
end

function fnei.mc.main_gui_prev_page(player)
  fnei.mc.reload_list_elems(player)
  fnei.mc.set_page(player, fnei.mc.get_page(player) - 1)
  fnei.mc.open_gui(player)
end

function fnei.mc.amount_page( player )
  return math.floor(#fnei.mc.get_elem_list(player) / fnei.mc.page_size()) + 1
end

function fnei.mc.page_size()
  return fnei.mc.width * fnei.mc.height
end