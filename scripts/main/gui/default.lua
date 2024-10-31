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
              { type = "choose-elem-button", name = "choose-item", style = "fnei_main_default_search_slot_button", elem_type = "item", elem_value = "wooden-chest", event = contr.set_item, locked = false }
            }},
            { type = "table", name = "item-content-tabel", style = "fnei_main_default_content_table", column_count = 2, children = {
              { type = "checkbox", name = "item-checkbox-craft", style = nil, state = false, tooltip = {"fnei.item-auto-craft"}, event = contr.item_craft_checkbox_event},
              { type = "button", name = "item-craft", style = "fnei_main_default_button", caption = {"fnei.recipe"}, event = contr.open_craft_item},
              { type = "checkbox", name = "item-checkbox-usage", style = nil, state = false, tooltip = {"fnei.item-auto-usage"}, event = contr.item_usage_checkbox_event},
              { type = "button", name = "item-usage", style = "fnei_main_default_button", caption = {"fnei.usage"}, event = contr.open_usage_item },
            }}
          }}
        }},
        { type = "flow", name = "fluid-flow", style = "fnei_main_default_element_flow", direction = "vertical", children = {
          { type = "label", name = "choose-fluid-label", style = "fnei_main_default_prot_label", caption = {"fnei.choose-fluid"} },
          { type = "flow", name = "fluid-flow-content", style = "fnei_main_default_selection_flow", direction = "horizontal", children = {
            { type = "flow", name = "fluid-choose-elem-flow", style = "fnei_main_default_choose_flow", direction = "horizontal", children = {
              { type = "choose-elem-button", name = "choose-fluid", style = "fnei_main_default_search_slot_button", elem_type = "fluid", elem_value = "water", event = contr.set_fluid, locked = false }
            }},
            { type = "table", name = "fluid-content-tabel", style = "fnei_main_default_content_table", column_count = 2, children = {
              { type = "checkbox", name = "fluid-checkbox-craft", style = nil, state = false, tooltip = {"fnei.fluid-auto-craft"}, event = contr.fluid_craft_checkbox_event},
              { type = "button", name = "fluid-craft", style = "fnei_main_default_button", caption = {"fnei.recipe"}, event = contr.open_craft_fluid},
              { type = "checkbox", name = "fluid-checkbox-usage", style = nil, state = false, tooltip = {"fnei.fluid-auto-usage"}, event = contr.fluid_usage_checkbox_event},
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

function DefaultMainGui.set_checkbox_val(chb1, chb2, chb3, chb4)
  local checkbox = Gui.get_gui(Gui.get_pos(), "item-checkbox-craft") or {}
  checkbox.state = chb1

  local checkbox = Gui.get_gui(Gui.get_pos(), "item-checkbox-usage") or {}
  checkbox.state = chb2

  local checkbox = Gui.get_gui(Gui.get_pos(), "fluid-checkbox-craft") or {}
  checkbox.state = chb3

  local checkbox = Gui.get_gui(Gui.get_pos(), "fluid-checkbox-usage") or {}
  checkbox.state = chb4
end

function DefaultMainGui.set_choose_but_val()
  local contr = Controller.get_cont("main").get_cur_contr_tab()
  if contr then
    Gui.set_choose_but_val(Gui.get_gui(Gui.get_pos(), "choose-item"), contr.get_item() or "wooden-chest")
    Gui.set_choose_but_val(Gui.get_gui(Gui.get_pos(), "choose-fluid"), contr.get_fluid() or "water")
  end
end

return DefaultMainGui