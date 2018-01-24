local MainGui = {
  classname = "FNMainGui",
  name = "main",
}

local gui_tabs = {}
gui_tabs["default-search"] = require "unsort/main_gui/main_default_gui"
gui_tabs["fnei-search"] = require "unsort/main_gui/main_fnei_gui"
gui_tabs["category-search"] = require "unsort/main_gui/main_category_gui"

local main_gui_template
local content_flow_name = "content-flow"
local tab_flow_name = "main-tabs"

function MainGui.init_template()
  --local contr = Controller.get_cont("main")

  main_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_recipe_flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
        { type = "table", name = "main-table", style = "fnei_recipe_main_table", column_count = 1, children = {

  ------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 4, children = {
              { type = "label", name = "header-label", caption = {"FNEI"} },
              { type = "sprite-button", name = "settings-key", style = "fnei_settings_button_style", tooltip = {"gui-menu.options"}, event = MainGui.settings_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
            }}
          }},

  ------------------ tabs ------------------

          { type = "flow", name = tab_flow_name },

  ------------------ content -------------------

          { type = "flow", name = content_flow_name },

        }}
      }}
    }}
  }
end

function MainGui.init_events(gui_tabs_cont_list)
  MainGui.init_template()
  Events.init_temp_events(MainGui.name, main_gui_template)

  for gui_name,gui in pairs(gui_tabs) do
    local contr = gui_tabs_cont_list[gui_name]

    if not contr then
      Debug:error("Error in function MainGui.init_events: controller ", gui_name, "not found")
    end

    gui.init_events(MainGui.name, contr)
    contr.init_event(MainGui.name, gui_tabs[gui_name])
  end
end

function MainGui.get_cur_gui_tab(tab_name)
  return gui_tabs[tab_name]
end

function MainGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), main_gui_template[1].name)
  if val and next(val) and val.valid then
    return true
  else
    return false
  end
end

function MainGui.close_window()
  if MainGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), main_gui_template[1].name).destroy()
  end
  Gui.close_old_fnei_gui()
end

function MainGui.draw_tabs(tabs)
  tabs:draw_tabs()
end

function MainGui.open_window()
  MainGui.close_window()
  return Gui.add_gui_template(Gui.get_pos(), main_gui_template)
end

function MainGui.draw_search_tab(cur_tab)
  local parent = Gui.get_gui(Gui.get_pos(), content_flow_name)

  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  if parent and gui_tabs[cur_tab] then
    gui_tabs[cur_tab].draw_template(parent)
  else
    Debug:error("Error in function MainGui.draw_factorio_search_tab(): gui == nil")
  end
end

function MainGui.settings_key_event(event)
  Controller.open_event("settings")
end

function MainGui.search_event(event)
  out(event)
end

return MainGui

-- local buttons = ui.add({type = "flow", name = "fnei_page_line", direction = "horizontal"})

--   buttons.add({type = "sprite-button", name = "fnei_prev_main_page", style = "fnei_left_arrow_button_style"})
--   buttons.add({type = "label", name = "fnei_page_number", caption = "empty_main_page"})
--   buttons.add({type = "sprite-button", name = "fnei_next_main_page", style = "fnei_right_arrow_button_style"})
-- ui.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})