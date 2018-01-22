local CategoryMainGui = {
  classname = "FNFneiGui",
}

local category_search_tab

function CategoryMainGui.init_template()
  local contr = Controller.get_cont("main")

  category_search_tab = {
    { type = "flow", name = "cont-flow", direction = "vertical", children = {
      { type = "label", name = "category-tab-desription", caption = {"fnei.category-tab-desription"} },
      { type = "label", name = "choose-item-label", caption = {"fnei.choose-item"} },
      { type = "flow", name = "choose-item-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-item", elem_type = "item"},
        { type = "flow", name = "choose-item-flow", direction = "vertical", children = {
          { type = "button", name = "item-recipe", caption = {"fnei.category_search_tab"}, event = contr.open_craft_item},
          { type = "button", name = "item-usage", caption = {"fnei.usage"}, event = contr.open_usage_item },
        }},
      }},
      { type = "label", name = "choose-fluid-label", caption = {"fnei.choose-fluid"} },
      { type = "flow", name = "choose-fluid-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-fluid", elem_type = "fluid"},
        { type = "choose-elem-button", name = "choose-fluid2", elem_type = "item", event = CategoryMainGui.event },
        { type = "flow", name = "choose-fluid-flow", direction = "vertical", children = {
          { type = "button", name = "fluid-recipe", caption = {"fnei.recipe"}, event = contr.open_craft_fluid },
          { type = "button", name = "fluid-usage", caption = {"fnei.usage"}, event = contr.open_usage_fluid },
        }},
      }},
    }}
  }
end

function CategoryMainGui.init_events(gui_name)
  CategoryMainGui.init_template()
  Events.init_temp_events(gui_name, category_search_tab)
end

function CategoryMainGui.draw_content(parent)
  Gui.add_gui_template(parent, category_search_tab)
  
  --Gui.get_gui(Gui.get_pos(), "choose-fluid2").locked = true
end

function CategoryMainGui.event(event, name)
  --out(event, name)
  out(event.element.elem_value)
end

return CategoryMainGui