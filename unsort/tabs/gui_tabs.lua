GuiTabs = {
  classname = "FNGuiTabs",
}

function GuiTabs:new(name, en_style, dis_style)

  local obj = {
    tab_name = name,
    en_style = en_style,
    dis_style = dis_style,
    tab_gui = nil
  }

  function obj:draw_tabs(parent, tabs, cur_tab)
    if parent and parent.valid then
      self.tab_gui = parent.name
    elseif self.tab_gui then
      parent = Gui.get_gui(Gui.get_pos(), self.tab_gui)
    else
      Debug:error("Error in function GuiTabs:draw_tabs: parent == nil: tab_name = ", tab_name)
      return
    end

    for gui_name, gui in pairs(parent.children) do
      if gui and gui.valid then
        gui.destroy()
      end
    end

    gui = Gui.add_flow(parent, { type = "flow", name = self.tab_name .. "-tab-flow"})

    for tb_name, val in pairs(tabs) do
      local style = dis_style
      if tb_name == cur_tab then
        style = en_style
      end

      Gui.add_sprite_button(gui, { type = "sprite-button", name = self.tab_name .. "-" .. tb_name, style = style,  tooltip = {"fnei." .. tb_name}, caption = {"fnei." .. tb_name},})
    end
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end