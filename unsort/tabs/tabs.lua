Tabs = {
  classname = "FNTabs",
}

local tabs_list = {}

function Tabs.new(tab_name, gui_name, tabs_name_list, en_style, dis_style, func)
  tabs_list[tab_name] = {
    tab_name = tab_name,
    tabs = tabs_name_list,
    en_style = en_style,
    dis_style = dis_style,
  }

  for _,tab in pairs(tabs_name_list) do
    Events.add_custom_event(gui_name, "sprite-button", tab_name .. "-" .. tab, func)
  end
end

function Tabs.get_tab_global()
  local global = Player.get_global()
  if not global.tabs then global.tabs = {} end
  return global.tabs
end

function Tabs.get_tabs_list(tab_name)
  return tabs_list[tab_name] and tabs_list[tab_name].tabs or {}
end

function Tabs.get_cur_tab(tab_name)
  return Tabs.get_tab_global()[tab_name] or tabs_list[tab_name].tabs[1]
end

function Tabs.set_cur_tab(tab_name, set_val)
  local global = Tabs.get_tab_global()
  global[tab_name] = set_val
end

function Tabs.draw_tabs(parent, tab_name)
  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end

  local tab = tabs_list[tab_name]
  local cur_tab = Tabs.get_cur_tab(tab_name)

  for _, tb_name in pairs(tab.tabs) do
    local style = tab.dis_style
    if tb_name == cur_tab then
      style = tab.en_style
    end

    Gui.add_sprite_button(parent, { type = "sprite-button", name = tab.tab_name .. "-" .. tb_name, style = style,  tooltip = {"fnei." .. tb_name}, caption = {"fnei." .. tb_name},})
  end
end

function Tabs.get_tab_name(tab_name, gui_name)
  local _,pos = string.find(gui_name, string.gsub(tab_name, "%p", "%%%0"))
  return string.sub(gui_name, pos + 2)
end