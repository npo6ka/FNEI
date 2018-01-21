local MainGui = {
  classname = "FNMainGui",
  name = "main",
}

local main_gui_template
local factorio_search_tab
local fnei_search_tab
local categoty_search_tab
local content_tb_name = "main-table"
local tab_flow_name = "tabs-flow"

function MainGui.init_template()
  local contr = Controller.get_cont("main")

  main_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_recipe_flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
        { type = "table", name = content_tb_name, style = "fnei_recipe_main_table", column_count = 1, children = {

  ------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 4, children = {
              { type = "label", name = "header-label", caption = {"gui-browse-mods.search"} },
              { type = "textfield", name = "search-field", event = MainGui.search_event },
              { type = "sprite-button", name = "settings-key", style = "fnei_settings_button_style", tooltip = {"gui-menu.options"}, event = MainGui.settings_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
            }}
          }},

  ------------------ tabs ------------------

          { type = "flow", name = tab_flow_name, style = "fnei_settings_tab-flow" },

  ------------------ content -------------------

        }}  
      }}
    }}
  }

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

function MainGui.init_events()
  MainGui.init_template()
  Events.init_temp_events(MainGui.name, main_gui_template)
  Events.init_temp_events(MainGui.name, factorio_search_tab)
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
  --local gui = Gui.get_gui(Gui.get_pos(), tab_flow_name)
  tabs:draw_tabs(tab_flow_name)
end

function MainGui.open_window()
  MainGui.close_window()

  local gui = Gui.add_gui_template(Gui.get_pos(), main_gui_template)
  MainGui.draw_factorio_search_tab()

  return gui
end

function MainGui.draw_factorio_search_tab()
  local gui = Gui.get_gui(Gui.get_pos(), content_tb_name)

  if gui then
    Gui.add_gui_template(gui, factorio_search_tab)
  else
    Debag:error("Error in function MainGui.draw_factorio_search_tab(): gui == nil")
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