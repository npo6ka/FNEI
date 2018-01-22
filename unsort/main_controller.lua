local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"
local tabs = "main-tabs"
local pages = "main-pages"

function MainController.exit()
  out("Main exit")
  MainGui.close_window()
end

function MainController.open()
  out("Main open")

  local gui = MainGui.open_window()
  MainGui.draw_tabs(tabs)
  MainGui.draw_search_tab(tabs:get_cur_tab())

  return gui
end

function MainController.back_key()
  return true
end

function MainController.get_name()
  return MainGui.name
end

function MainController.init_events()
  tabs = Tabs:new(tabs, MainGui.name, {"default-search", "fnei-search", "category-search"}, "fnei_settings_selected-tab", "fnei_settings_empty-tab", MainController.change_tab)
  pages = Page:new(pages, MainGui.name, 2, forward_func, back_func)
  MainGui.init_events()
end


function MainController.open_craft_item(event)
  --Controller.open_event("recipe")
end

function MainController.open_craft_fluid(event)
  --out(Tabs.get_cur_tab(tab_name))
  
end

function MainController.open_usage_item(event)
  out("set new list")
  pages:set_page_list({"a", "b", "c", "d", "e"})
  out(pages:amount_page())
  out(pages:get_cur_page())

  local gui = Gui.get_gui(Gui.get_pos(), "cont-flow")
  pages:draw_forward_arrow( gui )
  pages:draw_back_arrow( gui )


end

function MainController.open_usage_fluid(event)

end

function MainController.change_tab(event, name)
  MainGui.draw_search_tab(tabs:get_cur_tab())
  out(name)
end

return MainController