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
        { type = "textfield", name = "search-field", event = contr.search_event },
      }},
      { type = "flow", name = "paging-flow", direction = "horizontal", children = {
        { type = "flow", name = "back-tab-flow" },
        { type = "label", name = "page-label", caption = "unknown-page" },
        { type = "flow", name = "forward-tab-flow" },
      }},
      { type = "table", name = "data-table", column_count = 10 }
    }}
  }
end

function FneiMainGui.init_events(gui_name, contr)
  FneiMainGui.init_template(contr)
  Events.init_temp_events(gui_name, fnei_search_tab)
end

function FneiMainGui.draw_template(parent)
  Gui.add_gui_template(parent, fnei_search_tab)
end

function FneiMainGui.set_search_field(search_text)
  local textfield = Gui.get_gui(Gui.get_pos(), "search-field")

  if textfield then
    textfield.text = search_text
  end
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

function FneiMainGui.draw_item_list(data_list)
  local gui_tabel = Gui.get_gui(Gui.get_pos(), "data-table")

  clear_gui(gui_tabel)

  local contr = Controller.get_cont("main").get_cur_contr_tab()

  for _,prot in pairs(data_list) do
    if string.match(prot, "item%_") then
      Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = prot, elem_type = "item", elem_value = string.sub(prot, 6), locked = true })
    elseif string.match(prot, "fluid%_") then
      Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = prot, elem_type = "fluid", elem_value = string.sub(prot, 7), locked = true })
    end
  end
end


return FneiMainGui