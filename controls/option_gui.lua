function fnei.option_gui.open_option_gui(player)
  fnei.option_gui.close_option_gui(player)

  local main_flow = get_gui_pos(player, fnei.gui.location).add({type = "flow", name = "fnei_option_main_flow", style = "fnei_recipe_flow"})
    local main_frame = main_flow.add({type = "frame", name = "fnei_option_main_frame", style = "fnei_recipe_main_frame"})
       local main_table = main_frame.add({type = "table", name = "fnei_option_main_table", colspan = 1, style = "fnei_recipe_main_table"})
        local header = main_table.add({type = "frame", name = "fnei_option_header_frame", direction = "horizontal", style = "fnei_recipe_header_frame"})
          local header_tab = header.add({type = "table", name = "fnei_option_header_table", colspan = 5, style = "fnei_recipe_header_table"})
            header_tab.add({type = "label", name = "fnei_option_header_label", caption = {"fnei.options"}})
            header_tab.add({type = "sprite-button", name = "fnei_option_back_key", style = "slot_button_style", tooltip = {"fnei.back-key"}, sprite = "fnei_back_key"})
            header_tab.add({type = "sprite-button", name = "fnei_option_exit_key", style = "slot_button_style", tooltip = {"fnei.exit-key"}, sprite = "fnei_exit_key"})
        local content = main_table.add({type = "frame", name = "fnei_option_content_frame", direction = "horizontal", style = "fnei_recipe_header_frame"})
          local content_tab = content.add({type = "table", name = "fnei_option_content_table", colspan = 2})
          --par0
            content_tab.add({type = "label", name = "fnei_option_label_0", caption = {"fnei.position"}})
            content_tab.add({type = "drop-down", name = "fnei_option_param_0", items = {{"fnei.left"}, {"fnei.top"}, {"fnei.center"}}, selected_index = fnei.oc.get_gui_position(player)})
          --par1
            content_tab.add({type = "label", name = "fnei_option_label_1", caption = {"fnei.need-show"}})
            content_tab.add({type = "checkbox", name = "fnei_option_param_1", state = fnei.oc.need_to_close_gui(player)})
          --par2
            content_tab.add({type = "label", name = "fnei_option_label_2", caption = {"fnei.detail-chance"}})
            content_tab.add({type = "checkbox", name = "fnei_option_param_2", state = fnei.oc.detail_chance(player)})

          --admins function
          --adm_par0
            content_tab.add({type = "label", name = "fnei_option_admin_label_0", caption = {"fnei.admin-commands"}})
            content_tab.add({type = "checkbox", name = "fnei_option_admin_param_0", state = fnei.oc.get_admin_permission()})
          --adm_par1
  if global.fnei.settings.admin_function then
            content_tab.add({type = "label", name = "fnei_option_admin_label_1", caption = {"fnei.show-tech"}})
            content_tab.add({type = "checkbox", name = "fnei_option_admin_param_1", state = fnei.oc.can_show_tech(player)})
  end
end

function fnei.option_gui.close_option_gui(player)
  if fnei.option_gui.is_option_gui_open(player) then
    get_gui_pos(player, fnei.gui.location).fnei_option_main_flow.destroy()
  end
end

function fnei.option_gui.is_option_gui_open(player)
  if get_gui_pos(player, fnei.gui.location).fnei_option_main_flow then
    return true
  else
    return false
  end
end

function fnei.option_gui.set_option_gui(player)

end