local DefaultMainGui = {
  classname = "FNDefaultMainGui",
}

local default_search_tab

function DefaultMainGui.init_template(contr)
  default_search_tab = {
    { type = "frame", name = "content-frame", direction = "vertical", style = "fnei_main_content-frame", children = {
      { type = "label", name = "default-tab-desription", style = "fnei_main_tab-description-label", caption = {"fnei.default-tab-desription"} },
      { type = "label", name = "choose-item-label", caption = {"fnei.choose-item"} },
      { type = "flow", name = "choose-item-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-item", elem_type = "item", event = contr.set_item },
        { type = "flow", name = "choose-item-flow", direction = "vertical", children = {
          { type = "button", name = "item-recipe", caption = {"fnei.recipe"}, event = contr.open_craft_item},
          { type = "button", name = "item-usage", caption = {"fnei.usage"}, event = contr.open_usage_item },
        }},
      }},
      { type = "label", name = "choose-fluid-label", caption = {"fnei.choose-fluid"} },
      { type = "flow", name = "choose-fluid-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-fluid", elem_type = "fluid", event = contr.set_fluid },
        { type = "flow", name = "choose-fluid-flow", direction = "vertical", children = {
          { type = "button", name = "fluid-recipe", caption = {"fnei.recipe"}, event = contr.open_craft_fluid },
          { type = "button", name = "fluid-usage", caption = {"fnei.usage"}, event = contr.open_usage_fluid },
        }},
      }},
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