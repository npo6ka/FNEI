local GuiTabs = {
  classname = "FNGuiTabs",
}

function GuiTabs.draw_tabs(parent, tabs)

  if not(parent and parent.valid) then
    Debug:error("Error in function GuiTabs: draw_tabs: parent == nil")
    return
  end

  --parent = Gui.get_gui(Gui.get_pos(), self.tab_gui)

  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  for tb_name, val in pairs(tabs.tabs) do
    local style = tabs.dis_style
    if tb_name == tabs:get_cur_tab() then
      style = tabs.en_style
    end

    Gui.add_sprite_button(parent, { type = "sprite-button", name = tabs.tab_name .. "-" .. tb_name, style = style,  tooltip = {"fnei." .. tb_name}, caption = {"fnei." .. tb_name},})
  end
end

return GuiTabs