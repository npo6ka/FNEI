local FneiMainGui = {
  classname = "FNFneiMainGui",
}

local fnei_search_tab

function FneiMainGui.init_template(contr)
  --local contr = Controller.get_cont("main")

  fnei_search_tab = {
    { type = "flow", name = "cont-flow", direction = "vertical", children = {
      
    }}
  }
end

function FneiMainGui.init_events(gui_name, contr)
  FneiMainGui.init_template(contr)
  Events.init_temp_events(gui_name, fnei_search_tab)
end

function FneiMainGui.draw_content(parent)
  Gui.add_gui_template(parent, fnei_search_tab)
end

return FneiMainGui