local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

local settings_gui_template
local tab_flow_name = "sett-tabs"
local content_gui_name = "content-table"

function SettingsGui.init_template()
  local cont = Controller.get_cont(SettingsGui.name)

  settings_gui_template = {
    { type = "frame", name = "main-frame", style = "fnei_settings_main-frame", children = {
      { type = "table", name = "main-table", style = "fnei_settings_main-table", column_count = 1, children = {

------------------ header ------------------

        { type = "frame", name = "header-frame", style = "fnei_settings_header-frame", direction = "horizontal", children = {
          { type = "table", name = "header-table", style = "fnei_settings_header-table", column_count = 5, children = {
            { type = "label", name = "header-label", style = "fnei_settings_header-label", caption = {"gui-menu.settings"} },
            { type = "empty-widget", name = "widget-sprite" , style = "fnei_settings_header-sprite-widget" },
            { type = "empty-widget", name = "drag-widget", style = "fnei_settings_header-drag-widget", drag_target = true },
            { type = "sprite-button", name = "back-key", style = "fnei_back_button_style", tooltip = {"gui.cancel"}, event = Controller.back_key_event },
            { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
          }}
        }},

------------------ tabs ------------------

        { type = "flow", name = tab_flow_name },

------------------ settings ------------------

        { type = "frame", name = "content-frame", style = "fnei_settings_content-frame", direction = "horizontal", children = {
          { type = "table", name = content_gui_name, style = "fnei_settings_content-table", column_count = 2}
        }}
      }}
    }}
  }
end

function SettingsGui.init_events()
  SettingsGui.init_template()
  Events.init_temp_events(SettingsGui.name, settings_gui_template)
end

function SettingsGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), settings_gui_template[1].name)
  if val and next(val) and val.valid then
    return true
  else
    return false
  end
end

function SettingsGui.open_window(loc)
  loc = SettingsGui.close_window() or loc

  local gui = Gui.add_gui_template(Gui.get_pos(), settings_gui_template)
  gui.location = loc
  return gui
end

function SettingsGui.draw_tabs(tabs)
  tabs:draw_tabs()
end

function SettingsGui.close_window()
  if SettingsGui.is_gui_open() then
    local gui = Gui.get_gui(Gui.get_pos(), settings_gui_template[1].name)
    local loc = gui.location
    
    gui.destroy()
    
    return loc
  end
end

function SettingsGui.add_option_list(sett_list)
  local gui = Gui.get_gui(Gui.get_pos(), content_gui_name)

  if not gui or not gui.valid then
    debug:error("Error in function SettingsGui.add_option_in_gui: gui == nil")
    return
  end

  for _,gui in pairs(gui.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  for name, sett in pairs(sett_list) do
    SettingsGui.add_option_in_gui(gui, sett)
  end
end

function SettingsGui.add_option_in_gui(parent, sett)
  sett.elem.add_label_func(parent, sett)
  sett.elem.add_content_func(parent, sett)
end

return SettingsGui