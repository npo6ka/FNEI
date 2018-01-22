local DefaultMainGui = {
  classname = "FNDefaultMainGui",
}

local default_search_tab

function DefaultMainGui.init_template()
  local contr = Controller.get_cont("main")

  default_search_tab = {
    { type = "flow", name = "cont-flow", direction = "vertical", children = {
      { type = "label", name = "default-tab-desription", caption = {"fnei.default-tab-desription"} },
      { type = "label", name = "choose-item-label", caption = {"fnei.choose-item"} },
      { type = "flow", name = "choose-item-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-item", elem_type = "item"},
        { type = "flow", name = "choose-item-flow", direction = "vertical", children = {
          { type = "button", name = "item-recipe", caption = {"fnei.default_search_tab"}, event = contr.open_craft_item},
          { type = "button", name = "item-usage", caption = {"fnei.usage"}, event = contr.open_usage_item },
        }},
      }},
      { type = "label", name = "choose-fluid-label", caption = {"fnei.choose-fluid"} },
      { type = "flow", name = "choose-fluid-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-fluid", elem_type = "fluid"},
        { type = "flow", name = "choose-fluid-flow", direction = "vertical", children = {
          { type = "button", name = "fluid-recipe", caption = {"fnei.recipe"}, event = contr.open_craft_fluid },
          { type = "button", name = "fluid-usage", caption = {"fnei.usage"}, event = contr.open_usage_fluid },
        }},
      }},
    }}
  }
end

function DefaultMainGui.init_events(gui_name)
  DefaultMainGui.init_template()
  Events.init_temp_events(gui_name, default_search_tab)
end

function DefaultMainGui.draw_content(parent)
  Gui.add_gui_template(parent, default_search_tab)
end

return DefaultMainGui