local CategoryMainGui = {
  classname = "FNFneiGui",
}

local factorio_search_tab

function CategoryMainGui.init_template()
  local contr = Controller.get_cont("main")

  factorio_search_tab = {
    { type = "frame", name = "content-frame", direction = "vertical", children = {
      { type = "label", name = "choose-item-label", caption = {"fnei.choose-item"} },
      { type = "flow", name = "choose-item-flow", direction = "horizontal", children = {
        { type = "choose-elem-button", name = "choose-item", elem_type = "item"},
        { type = "flow", name = "choose-item-flow", direction = "vertical", children = {
          { type = "button", name = "item-recipe", caption = {"fnei.recipe"}, event = contr.open_craft_item},
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

function CategoryMainGui.init_events()
  CategoryMainGui.init_template()
  --Events.init_temp_events(CategoryMainGui.name, factorio_search_tab)
end

function CategoryMainGui.draw_content()

end

return CategoryMainGui