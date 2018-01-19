Tabs = {}

function Tabs:new(name, tabs_list)

  local obj = {
    tab_name = name,
    tabs = {}
  }

  function init()
    local ind = 1

    for _,tab in pairs(tabs_list) do
      obj.tabs[tab] = ind
      ind = ind + 1
    end
  end

  function obj:get_tab_global()
    local global = Player.get_global()
    if not global.tabs then global.tabs = {} end
    return global.tabs
  end

  function obj:get_cur_tab()
    local tab_index = self:get_tab_global()[self.tab_name] or 1

    for tb_name,index in pairs(self.tabs) do
      if index == tab_index then
        return tb_name
      end
    end
  end

  function obj:set_cur_tab(val)
    local global = self:get_tab_global()

    global[self.tab_name] = self.tabs[val]
  end

  function obj:get_tabs_list()
    return self.tabs
  end

  init()
  setmetatable(obj, self)
  self.__index = self; return obj
end