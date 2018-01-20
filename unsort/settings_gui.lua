local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

local settings_gui_template
local tab_flow_name = "tabs-flow"
local content_gui_name = "content-table"

function SettingsGui.init_template()
  local cont = Controller.get_cont(SettingsGui.name)

  settings_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_settings_genetal-flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_settings_main-frame", children = {
        { type = "table", name = "main-table", style = "fnei_settings_main-table", column_count = 1, children = {

------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_settings_header-frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_settings_header-table", column_count = 3, children = {
              { type = "label", name = "header-label", style = "fnei_settings_header-label", caption = {"gui-menu.options"} },
              { type = "sprite-button", name = "back-key", style = "fnei_back_button_style", tooltip = {"gui.cancel"}, event = Controller.back_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
            }}
          }},

------------------ tabs ------------------

          { type = "flow", name = tab_flow_name, style = "fnei_settings_tab-flow", children = {
            { type = "sprite-button", name = "main-settings", style = "fnei_settings_selected-tab", tooltip = {"fnei.main-settings"}, caption = {"fnei.main-settings"}, event = cont.set_new_tab_event },
            { type = "sprite-button", name = "crafting-category", style = "fnei_settings_empty-tab", tooltip = {"fnei.crafting-category"}, caption = {"fnei.crafting-category"}, event = cont.set_new_tab_event },
            { type = "sprite-button", name = "admin-settings", style = "fnei_settings_empty-tab", tooltip = {"fnei.admin-settings"}, caption = {"fnei.admin-settings"}, event = cont.set_new_tab_event },
          }},

------------------ settings ------------------

          { type = "frame", name = "content-frame", style = "fnei_settings_content-frame", direction = "horizontal", children = {
            { type = "table", name = content_gui_name, style = "fnei_settings_content-table", column_count = 2}
          }}
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

function SettingsGui.open_window()
  SettingsGui.close_window()

  return Gui.add_gui_template(Gui.get_pos(), settings_gui_template)
end

function SettingsGui.close_window()
  if SettingsGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), settings_gui_template[1].name).destroy()
  end
end

function SettingsGui.change_cur_tab(tab_index)
  local tabs = Gui.get_gui(Gui.get_pos(), tab_flow_name)
  for number, tab in pairs(tabs.children) do
    if number == tab_index then
      tab.style = "fnei_settings_selected-tab"
    else
      tab.style = "fnei_settings_empty-tab"
    end
  end
end

function SettingsGui.add_option_list(sett_list, tab_index)
  local gui = Gui.get_gui(Gui.get_pos(), content_gui_name)

  if not gui then
    debug:error("Error in function SettingsGui.add_option_in_gui: gui == nil")
    return
  end

  for _,gui in pairs(gui.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  for name, sett in pairs(sett_list) do
    if sett.tab_num == tab_index then
      SettingsGui.add_option_in_gui(gui, sett)
    end
  end
end

function SettingsGui.add_option_in_gui(parent, sett)
  sett.elem.add_label_func(parent, sett)
  sett.elem.add_content_func(parent, sett)
end

return SettingsGui