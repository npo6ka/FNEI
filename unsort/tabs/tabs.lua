Tabs = {
  classname = "FNTabs",
}

local GuiTabs = require "unsort/tabs/gui_tabs"

function Tabs:new(tab_name, gui_name, tabs_list, en_style, dis_style, func)

  local obj = {
    tab_name = tab_name,
    tabs = tabs_list,
    en_style = en_style,
    dis_style = dis_style,
    func = func
  }

  function init()
    for val,tab in pairs(tabs_list) do
      Events.add_custom_event(gui_name, "sprite-button", tab_name .. "-" .. tab, obj.tab_event)
    end
  end

  function obj:get_tab_global()
    local global = Player.get_global()
    if not global.tabs then global.tabs = {} end
    return global.tabs
  end

  function obj:get_cur_tab()
    return self:get_tab_global()[self.tab_name] or self.tabs[1]
  end

  function obj:set_cur_tab(val)
    local global = self:get_tab_global()
    global[self.tab_name] = val
    self:draw_tabs()
  end

  function obj:get_tabs_list()
    return self.tabs
  end

  function obj:draw_tabs()
    GuiTabs.draw_tabs(self.tab_name, self)
  end

  function obj.tab_event(event, name)
    local _,pos = string.find(name, string.gsub(obj.tab_name, "%p", "%%%0"))
    local tab_name = string.sub(name, pos + 2)

    obj:set_cur_tab(tab_name)

    if obj.func then
      obj.func(event, tab_name)
    end
  end

  init()
  setmetatable(obj, self)
  self.__index = self; return obj
end