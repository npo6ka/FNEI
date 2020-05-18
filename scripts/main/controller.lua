local MainController = {
  classname = "FNMainController",
}

local MainGui = require "scripts/main/gui"
local tabs = "main-tabs"

local gui_tabs_cont = {}
gui_tabs_cont["default-search"] = require "scripts/main/controllers/default"
gui_tabs_cont["fnei-search"] = require "scripts/main/controllers/fnei"
--gui_tabs_cont["category-search"] = require "scripts/main/controllers/category"

function MainController.init_events()
  local tab_list = {}

  for tb_name,_ in pairs(gui_tabs_cont) do 
    table.insert(tab_list, tb_name)
  end

  tabs = Tabs:new(tabs, MainGui.name, tab_list, "fnei_main_selected-tab", "fnei_main_empty-tab", MainController.change_tab)
  MainGui.init_events(gui_tabs_cont)
end

function MainController.exit()
  out("Main exit")
  Player.get_global()["gui_loc"] = MainGui.close_window()
end

function MainController.open()
  out("Main open")

  local gui = MainGui.open_window(Player.get_global()["gui_loc"] or {x = 82, y = 70})
  MainGui.draw_tabs(tabs)
  MainController.draw_tab()

  return gui
end

function MainController.back_key()
  return true
end

function MainController.can_open_gui()
  return true
end

function MainController.get_name()
  return MainGui.name
end

function MainController.is_gui_open()
  return MainGui.is_gui_open()
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