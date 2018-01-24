local FneiMainGui = {
  classname = "FNFneiMainGui",
}

local fnei_search_tab

function FneiMainGui.init_template(contr)
  --local contr = Controller.get_cont("main")

  fnei_search_tab = {
    { type = "frame", name = "content-frame", direction = "vertical", children = {
      { type = "label", name = "description-label", caption = {"gui.fnei-tab-description"} },
      { type = "flow", name = "search-flow", direction = "horizontal", children = {
        { type = "label", name = "header-label", caption = {"gui-browse-mods.search"} },
        { type = "textfield", name = "search-field", event = nil },
      }},
      { type = "flow", name = "paging-flow", direction = "horizontal", children = {
        { type = "flow", name = "back-tab-flow" },
        { type = "label", name = "page-label", caption = "unknown-page" },
        { type = "flow", name = "forward-tab-flow" },
      }},
      { type = "table", name = "item-table", column_count = 10 }
    }}
  }




--     local ui  = get_gui_pos(player).add({type = "frame", name = "fnei_main_gui",direction = "vertical"})
--   local search_line = ui.add({type = "frame", name = "fnei_search_line", direction = "horizontal"})
--   local buttons = ui.add({type = "flow", name = "fnei_page_line", direction = "horizontal"})
--   ui.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})

--     search_line.add({type = "label", caption = "Search:"})
--     search_line.add({type = "textfield", name = "fnei_search_field", text = fnei.mc.get_search_text(player)})
--     search_line.add({type = "sprite-button", name = "fnei_main_settings_key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"}})
--     search_line.add({type = "sprite-button", name = "fnei_main_exit_key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"}})
--   buttons.add({type = "sprite-button", name = "fnei_prev_main_page", style = "fnei_left_arrow_button_style"})
--   buttons.add({type = "label", name = "fnei_page_number", caption = "empty_main_page"})
--   buttons.add({type = "sprite-button", name = "fnei_next_main_page", style = "fnei_right_arrow_button_style"})

end

function FneiMainGui.init_events(gui_name, contr)
  FneiMainGui.init_template(contr)
  Events.init_temp_events(gui_name, fnei_search_tab)
end

function FneiMainGui.draw_template(parent)
  Gui.add_gui_template(parent, fnei_search_tab)
end

function FneiMainGui.draw_page_label(page)
  local cur_tab = Gui.get_gui(Gui.get_pos(), "content-frame")

  page:draw_forward_arrow( Gui.get_gui(cur_tab, "forward-tab-flow") )
  page:draw_back_arrow( Gui.get_gui(cur_tab, "back-tab-flow") )

  local label = Gui.get_gui(cur_tab, "page-label")
  local amnt = page:amount_page()
  if amnt == 0 then amnt = 1 end
  label.caption = {"", {"fnei.page"}, ": " .. page:get_cur_page() .. "/".. amnt}
end

function FneiMainGui.draw_item_list(item_list)
  local gui_tabel = Gui.get_gui(Gui.get_pos(), "item-table")

  for _, gui in pairs(gui_tabel.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  for _,item in pairs(item_list) do
    Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = "item-" .. item, elem_type = "item", elem_value = item, locked = true, event = nil })
  end
end


return FneiMainGui