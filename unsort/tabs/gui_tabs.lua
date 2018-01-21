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

  function obj:draw_tabs(gui_name, tabs, cur_tab)
    if gui_name then
      self.tab_gui = gui_name
    end

    if not self.tab_gui then
      Debug:error("Error in function GuiTabs:draw_tabs: parent == nil: tab_name = ", self.tab_name)
      return
    end


    parent = Gui.get_gui(Gui.get_pos(), self.tab_gui)
    out(Player.get().name, parent.name)
    if not (parent and parent.valid) then
      return
    end
    out("redraw")

    for _, gui in pairs(parent.children) do
      if gui and gui.valid then
        gui.destroy()
      end
    end

    for tb_name, val in pairs(tabs) do
      local style = dis_style
      if tb_name == cur_tab then
        style = en_style
      end

      Gui.add_sprite_button(parent, { type = "sprite-button", name = self.tab_name .. "-" .. tb_name, style = style,  tooltip = {"fnei." .. tb_name}, caption = {"fnei." .. tb_name},})
    end
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end