local DefaultMainGui = {
  classname = "FNDefaultMainGui",
}

local default_search_tab

function DefaultMainGui.init_template(contr)
  default_search_tab = {
    { type = "frame", name = "content-frame", style = "fnei_main_content-frame", direction = "vertical", children = {
      { type = "label", name = "default-tab-desription", style = "fnei_main_tab-description-label", caption = {"fnei.default-tab-desription"} },
      { type = "table", name = "content-tabel", style = "fnei_main_header-table", column_count = 2, children = {
        { type = "flow", name = "item-flow", style = "fnei_main_default_element_flow", direction = "vertical", children = {
          { type = "label", name = "choose-item-label", style = "fnei_main_default_prot_label", caption = {"fnei.choose-item"} },
          { type = "flow", name = "item-flow-content", style = "fnei_main_default_selection_flow", direction = "horizontal", children = {
            { type = "flow", name = "item-choose-elem-flow", style = "fnei_main_default_choose_flow", direction = "horizontal", children = {
              { type = "choose-elem-button", name = "choose-item", style = "fnei_main_default_search_slot_button", elem_type = "item", event = contr.set_item }
            }},
            { type = "table", name = "item-content-tabel", style = "fnei_main_default_content_table", column_count = 2, children = {
              { type = "checkbox", name = "item-checkbox-recipe", style = nil, state = false, tooltip = {"fnei.default_open_type"}, event = nil},
              { type = "button", name = "item-recipe", style = "fnei_main_default_button", caption = {"fnei.recipe"}, event = contr.open_craft_item},
              { type = "checkbox", name = "item-checkbox-usage", style = nil, state = false, tooltip = {"fnei.default_open_type"}, event = nil},
              { type = "button", name = "item-usage", style = "fnei_main_default_button", caption = {"fnei.usage"}, event = contr.open_usage_item },
            }}
          }}
        }},
        { type = "flow", name = "fluid-flow", style = "fnei_main_default_element_flow", direction = "vertical", children = {
          { type = "label", name = "choose-fluid-label", style = "fnei_main_default_prot_label", caption = {"fnei.choose-fluid"} },
          { type = "flow", name = "fluid-flow-content", style = "fnei_main_default_selection_flow", direction = "horizontal", children = {
            { type = "flow", name = "fluid-choose-elem-flow", style = "fnei_main_default_choose_flow", direction = "horizontal", children = {
              { type = "choose-elem-button", name = "choose-fluid", style = "fnei_main_default_search_slot_button", elem_type = "fluid", event = contr.set_fluid }
            }},
            { type = "table", name = "fluid-content-tabel", style = "fnei_main_default_content_table", column_count = 2, children = {
              { type = "checkbox", name = "fluid-checkbox-recipe", style = nil, state = false, tooltip = {"fnei.default_open_type"}, event = nil},
              { type = "button", name = "fluid-recipe", style = "fnei_main_default_button", caption = {"fnei.recipe"}, event = contr.open_craft_fluid},
              { type = "checkbox", name = "fluid-checkbox-usage", style = nil, state = false, tooltip = {"fnei.default_open_type"}, event = nil},
              { type = "button", name = "fluid-usage", style = "fnei_main_default_button", caption = {"fnei.usage"}, event = contr.open_usage_fluid },
            }}
          }}
        }}
      }}
    }}
  }
end

function DefaultMainGui.init_events(gui_name, contr)
  DefaultMainGui.init_template(contr)
  Events.init_temp_events(gui_name, default_search_tab)
end

function DefaultMainGui.draw_template(parent)
  Gui.add_gui_template(parent, default_search_tab)
end

function DefaultMainGui.set_choose_but_val()
  local contr = Controller.get_cont("main").get_cur_contr_tab()
  if contr then
    Gui.set_choose_but_val(Gui.get_gui(Gui.get_pos(), "choose-item"), contr.get_item())
    Gui.set_choose_but_val(Gui.get_gui(Gui.get_pos(), "choose-fluid"), contr.get_fluid())
  end
end

return DefaultMainGui