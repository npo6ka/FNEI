local DefaultEvents = {
  classname = "FNDefaultEvents"
}

local gui_key_name = "pressed-fnei-gui-key"
local back_key_name = "pressed-fnei-back-key"
local CustomEvents = require "unsort/custom_events"
local Gui = require "unsort/gui"
local supported_gui_event = {
  defines.events.on_gui_checked_state_changed,
  defines.events.on_gui_selection_state_changed,
  defines.events.on_gui_click,
  defines.events.on_gui_text_changed,
  defines.events.on_gui_elem_changed,
}

function DefaultEvents.add_custom_event(gui_name, gui_type, event_name, func)
  CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
end

function DefaultEvents.del_custom_event(gui_name, gui_type, event_name)
  CustomEvents.del_custom_event(gui_name, gui_type, event_name)
end

function DefaultEvents.on_configuration_changed(event)
  --if not global.fnei then global.fnei = {} end
end

function DefaultEvents.back_key(event)
  Player.load(event)

end

function DefaultEvents.but_click(event)
  out("but_click")
end

function DefaultEvents.gui_key(event)
  Player.load(event)

  local gui = game.players[event.player_index].gui.center.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})
  Gui.addSpriteButton(gui, "main", "settings-key", {"fnei.settings-key"}, "fnei_settings_button_style", DefaultEvents.but_click)
  gui.add({type = "choose-elem-button", name = "fnei_main_sdf", elem_type = "fluid"})
  gui.add({type = "choose-elem-button", name = "fnei_main_sd1f", elem_type = "item"})
  gui.add({type = "choose-elem-button", name = "fnei_main_sdf2", elem_type = "recipe"})
  --game.players[event.player_index].opened = gui
end

function DefaultEvents.on_tick(event)

end

function DefaultEvents.on_gui_closed(event)
  Player.load(event)
  out(event)
end

function DefaultEvents.on_event_invoke(event)
  Player.load(event)
  local gui_name, gui_type, event_name  = DefaultEvents.parse_name(event)
  CustomEvents.invoke(gui_name, gui_type, event_name, event)
end

function DefaultEvents.parse_name(event)
  if event == nil then 
    out("Error: DefaultEvents.parse_name: event == nil ")
    return 
  end
  local element = event.element
  if element == nil then 
    out("Error: DefaultEvents.parse_name: element == nil ")
    return 
  end

  local split_func = string.gmatch(element.name or "", "[^_]+")

  local mod = split_func();
  if mod ~= Gui.get_prefix() then
    return
  end

  local gui_name = split_func();
  local event_name = split_func();
  return gui_name, element.type, event_name
end

function DefaultEvents:init()
  script.on_configuration_changed(self.on_configuration_changed)
  self.event_load(defines.events.on_tick, self.on_tick)
  self.event_load(gui_key_name, self.gui_key)
  self.event_load(back_key_name, self.back_key)
  self.event_load(defines.events.on_gui_closed, self.on_gui_closed)

  for _,event in pairs(supported_gui_event) do
    self.event_load(event, self.on_event_invoke)
  end  
end

function DefaultEvents.event_load(event_name, func)
  script.on_event(event_name, func)
end

return DefaultEvents