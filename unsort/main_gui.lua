local MainGui = {
  classname = "FNMainGui",
  name = "main",
}

local main_gui_template

function MainGui.init_template()
  main_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_recipe_flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
        { type = "table", name = "main-table", style = "fnei_recipe_main_table", column_count = 1, children = {

  ------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 4, children = {
              { type = "label", name = "header-label", caption = "?Search:" },
              { type = "textfield", name = "search-field", event = MainGui.search_event },
              { type = "sprite-button", name = "settings-key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"}, event = MainGui.settings_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"}, event = Controller.main_key_event },
            }}
          }}

  ------------------ content -------------------

        }}  
      }}
    }}
  }
end

function MainGui.init_events()
  MainGui.init_template()
  MainGui.rec_init(main_gui_template)
end

function MainGui.rec_init(gui_templdte)
  if gui_templdte then
    for _,gui_temp in pairs(gui_templdte) do
      out("init_events: ", gui_temp.name)
      if gui_temp.event then
        Events.add_custom_event(MainGui.name, gui_temp.type, gui_temp.name, gui_temp.event)
      end
      MainGui.rec_init(gui_temp.children)
    end
  end
end

function MainGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), main_gui_template[1].name)
  return (val and next(val) ~= nil) or false
end

function MainGui.open_window()
  MainGui.close_window()

  local cur_gui = Gui.get_pos()
  local ret_gui = Gui.addFlow(cur_gui, MainGui.name, main_gui_template[1].name, "fnei_recipe_flow")
  cur_gui = Gui.addFrame(ret_gui, MainGui.name, "main-frame", "fnei_recipe_main_frame")
  cur_gui = Gui.addTable(cur_gui, MainGui.name, "main-table", "fnei_recipe_main_table", 1)  

  MainGui.add_header(cur_gui)

MainGui.init_events(main_gui_template)


  return ret_gui
end

function MainGui.close_window()
  if MainGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), main_gui_template[1].name).destroy()
  end
  Gui.close_old_fnei_gui()
end

function MainGui.add_header(parent)
  parent = Gui.addFrame(parent, MainGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  parent = Gui.addTable(parent, MainGui.name, "header-table", "fnei_recipe_header_table", 4)

  Gui.addLabel(parent, MainGui.name, "header-label", nil, "Search:")
  Gui.addTextfield(parent, MainGui.name, "search-field")

  Gui.addSpriteButton(parent, { name = "settings-key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"} })
  Gui.addSpriteButton(parent, { name = "exit-key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"} })
end

function MainGui.settings_key_event(event)
  Controller.open_event(Controller.get_cont("settings"))
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