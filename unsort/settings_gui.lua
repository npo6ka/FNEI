local SettingsGui = {
  classname = "FNSettingsGui",
  name = "settings",
}

local settings_gui_template

function SettingsGui.init_template()
  local cont = Controller.get_cont(SettingsGui.name)

  settings_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_recipe_flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
        { type = "table", name = "main-table", style = "fnei_recipe_main_table", column_count = 1, children = {

------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 3, children = {
              { type = "label", name = "header-label", style = "fnei_option_label", caption = {"fnei.options"} },
              { type = "sprite-button", name = "back-key", style = "fnei_back_button_style", tooltip = {"fnei.back-key"}, event = Controller.back_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"}, event = Controller.main_key_event },
            }}
          }},

------------------ tabs ------------------

          { type = "flow", name = "tabs-flow",  children = {
            { type = "sprite-button", name = "main-settings", style = "fnei_selected_tab_button_style", tooltip = "?main settings", caption = "?main settings", event = cont.set_new_tab_event },
            { type = "sprite-button", name = "crafting-category", style = "fnei_empty_tab_button_style", tooltip = "?crafting category", caption = "?crafting category", event = cont.set_new_tab_event },
            { type = "sprite-button", name = "admin-settings", style = "fnei_empty_tab_button_style", tooltip = "?admin settings", caption = "?admin settings", event = cont.set_new_tab_event },
          }},

------------------ settings ------------------

          { type = "frame", name = "content-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "content-table", column_count = 2, children = {

            }}
          }}
        }}  
      }}
    }}
  }

end

local tab_flow_name = "tabs-flow"
local content_gui_name = "content-table"

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

-- function SettingsGui.drow_tabs(parent)
--   local tabs_flow = parent[tab_flow_name]
--   local contr = Controller.get_cur_con()

--   if tabs_flow and tabs_flow.valid then
--     tabs_flow.destroy()
--   end
--   tabs_flow = Gui.addFlow(parent, SettingsGui.name, tab_flow_name)  
--   Gui.addSpriteButton(tabs_flow, { name = "main-settings", style = SettingsGui.get_tab_style(contr, "main-settings"), tooltip = "?main settings", caption = "?main settings" }, contr.set_new_tab_event)
--   Gui.addSpriteButton(tabs_flow, { name = "crafting-category", style = SettingsGui.get_tab_style(contr, "crafting-category"), tooltip = "?crafting category", caption = "?crafting category" }, contr.set_new_tab_event)
--   Gui.addSpriteButton(tabs_flow, { name = "admin-settings", style = SettingsGui.get_tab_style(contr, "admin-settings"), tooltip = "?admin settings", caption = "?admin settings" }, contr.set_new_tab_event)
-- end

-- function SettingsGui.get_tab_style( contr, tab_name )
--   if contr.is_cur_tab(tab_name) then
--     return "fnei_selected_tab_button_style"
--   else
--     return "fnei_empty_tab_button_style"
--   end
-- end

function SettingsGui.change_cur_tab(tab_index)
  local tabs = Gui.get_gui(Gui.get_pos(), tab_flow_name)
  for number, tab in pairs(tabs.children) do
    if number == tab_index then
      tab.style = "fnei_selected_tab_button_style"
    else
      tab.style = "fnei_empty_tab_button_style"
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