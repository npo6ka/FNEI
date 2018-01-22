local FneiMainGui = {
  classname = "FNFneiMainGui",
}

local fnei_search_tab

function FneiMainGui.init_template()
  local contr = Controller.get_cont("main")

  fnei_search_tab = {
    { type = "flow", name = "cont-flow", direction = "vertical", children = {
      { type = "label", name = "choose-item-label", caption = {"fnei.choose-item"} },
      { type = "flow", name = "choose-item-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-item", elem_type = "item"},
        { type = "flow", name = "choose-item-flow", direction = "vertical", children = {
          { type = "button", name = "item-recipe", caption = {"fnei.fnei_search_tab"}, event = contr.open_craft_item},
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

function FneiMainGui.init_events(gui_name)
  FneiMainGui.init_template()
  Events.init_temp_events(gui_name, fnei_search_tab)
end

function FneiMainGui.draw_content(parent)
  Gui.add_gui_template(parent, fnei_search_tab)
end

return FneiMainGui