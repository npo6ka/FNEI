local HotbarGui = {
  classname = "FNHotbarGui",
  name = "hotbar",
}

local hotbar_gui_template
local hotbar_flow_name = "fnei_hotbar_flow"

function HotbarGui.init_template()
  local cont = Controller.get_cont(HotbarGui.name)

  hotbar_gui_template = {
    { type = "frame", name = "frame", style = "fnei_hotbar_frame", children = {
      { type = "sprite-button", name = "fnei-button", style = "fnei_hotbar_label_button", caption = "FNEI", event = Controller.main_key_event}
    }}
  }

end

function HotbarGui.init_events()
  HotbarGui.init_template()
  Events.init_temp_events(HotbarGui.name, hotbar_gui_template)
end

function HotbarGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_left_gui(), hotbar_gui_template[1].name)

  if val and next(val) and val.valid then
    return true
  else
    return false
  end
end

function HotbarGui.open_window()
  HotbarGui.close_window()

  local gui = Gui.get_left_gui()

  if not gui[hotbar_flow_name] then
    gui.add({ type = "flow", name = hotbar_flow_name }) 
  end

  gui = gui[hotbar_flow_name]
  return Gui.add_gui_template(gui, hotbar_gui_template)
end

function HotbarGui.close_window()
  if HotbarGui.is_gui_open() then
    Gui.get_gui(Gui.get_left_gui(), hotbar_gui_template[1].name).destroy()
  end
end

return HotbarGui