local CategoryMainGui = {
  classname = "FNFneiGui",
}

local category_search_tab

function CategoryMainGui.init_template(contr)
  --local contr = Controller.get_cont("main")

  category_search_tab = {
    { type = "flow", name = "cont-flow", direction = "vertical", children = {

    }}
  }
end

function CategoryMainGui.init_events(gui_name, contr)
  CategoryMainGui.init_template(contr)
  Events.init_temp_events(gui_name, category_search_tab)
end

function CategoryMainGui.draw_template(parent)
  Gui.add_gui_template(parent, category_search_tab)
  
  --Gui.get_gui(Gui.get_pos(), "choose-fluid2").locked = true
end

function CategoryMainGui.event(event, name)
  --out(event, name)
  out(event.element.elem_value)
end

return CategoryMainGui