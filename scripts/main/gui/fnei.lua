local FneiMainGui = {
  classname = "FNFneiMainGui",
}

local fnei_search_tab
local search_field_name = "search-field"

function FneiMainGui.init_template(contr)
  --local contr = Controller.get_cont("main")

  fnei_search_tab = {
    { type = "frame", name = "content-frame", style = "fnei_main_content-frame", direction = "vertical", children = {
      { type = "label", name = "description-label", style = "fnei_main_tab-description-label", caption = {"fnei.fnei-tab-description"} },
      { type = "flow", name = "search-flow", style = "fnei_main_content_flow", direction = "horizontal", children = {
        { type = "label", name = "header-label", style = "fnei_main_default_search_label", caption = {"", {"gui.search"}, " :"} },
        { type = "textfield", name = search_field_name, style = "fnei_main_search_field", event = contr.search_event },
      }},
      { type = "flow", name = "paging-flow", style = "fnei_main_content_flow", direction = "horizontal", children = {
        { type = "flow", name = "back-tab-flow", style = "fnei_main_content_flow" },
        { type = "label", name = "page-label", style = "fnei_main_page_label", caption = "" },
        { type = "flow", name = "forward-tab-flow", style = "fnei_main_content_flow" },
      }},
      { type = "table", name = "data-table", style = "fnei_main_fnei_content_table", column_count = 12 }
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

function FneiMainGui.focus_on_search(parent)
  local cur_tab = Gui.get_gui(Gui.get_pos(), search_field_name)

  if cur_tab and cur_tab.valid then
    cur_tab.focus()
  end
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
  local items = get_full_item_list()
  local fluids = get_full_fluid_list()

  for _,prot in pairs(data_list) do
    local style = "fnei_main_grey_slot_button"

    if string.match(prot, "item\t") then
      local item_name = string.sub(prot, 6)
      if items and items[item_name] and items[item_name].has_flag("hidden") then
        style = "fnei_main_red_slot_button"
      end

      Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = prot, elem_type = "item", style = style, elem_value = item_name, locked = true })
    elseif string.match(prot, "fluid\t") then
      local fluid_name = string.sub(prot, 7)
      if fluids and fluids[fluid_name] and fluids[fluid_name].hidden then
        style = "fnei_main_red_slot_button"
      end

      Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = prot, elem_type = "fluid", style = style, elem_value = fluid_name, locked = true })
    end
  end
end


return FneiMainGui