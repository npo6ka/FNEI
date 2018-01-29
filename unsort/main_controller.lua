local MainController = {
  classname = "FNMainController",
}

local MainGui = require "unsort/main_gui"
local tabs = "main-tabs"

local gui_tabs_cont = {}
gui_tabs_cont["default-search"] = require "unsort/main_controllers/main_default_controller"
gui_tabs_cont["fnei-search"] = require "unsort/main_controllers/main_fnei_controller"
--gui_tabs_cont["category-search"] = require "unsort/main_controllers/main_category_controller"

function MainController.init_events()
  local tab_list = {}

  for tb_name,_ in pairs(gui_tabs_cont) do 
    table.insert(tab_list, tb_name)
  end

  tabs = Tabs:new(tabs, MainGui.name, tab_list, "fnei_settings_selected-tab", "fnei_settings_empty-tab", MainController.change_tab)
  MainGui.init_events(gui_tabs_cont)
end

function MainController.exit()
  out("Main exit")
  MainGui.close_window()
end

function MainController.open()
  out("Main open")

  local gui = MainGui.open_window()
  MainGui.draw_tabs(tabs)
  MainController.draw_tab()

  return gui
end

function MainController.back_key()
  return true
end

function MainController.get_name()
  return MainGui.name
end

function MainController.get_cur_contr_tab()
  return gui_tabs_cont[tabs:get_cur_tab()]
end

function MainController.get_cur_gui_tab()
  return MainGui.get_cur_gui_tab(tabs:get_cur_tab())
end

function MainController.draw_tab()
  MainGui.draw_search_tab(tabs:get_cur_tab())
  gui_tabs_cont[tabs:get_cur_tab()].draw_content()
end


function MainController.change_tab(event, name)
  MainController.draw_tab()
end

return MainController