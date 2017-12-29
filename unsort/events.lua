local Events = {
  classname = "FNEvents"
}

local gui_key_name = "pressed-fnei-gui-key"
local back_key_name = "pressed-fnei-back-key"
local CustomEvents = require "unsort/custom_events"
local Controller = require "unsort/controller"

local supported_gui_event = {
  defines.events.on_gui_checked_state_changed,
  defines.events.on_gui_selection_state_changed,
  defines.events.on_gui_click,
  defines.events.on_gui_text_changed,
  defines.events.on_gui_elem_changed,
}

function Events.add_custom_event(gui_name, gui_type, event_name, func)
  CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
end

function Events.del_custom_event(gui_name, gui_type, event_name)
  CustomEvents.del_custom_event(gui_name, gui_type, event_name)
end

function Events.on_configuration_changed(event)
  --if not global.fnei then global.fnei = {} end
end

function Events.back_key(event)
  Player.load(event)
  Controller.back_key_event()
end

function Events.but_click(event)
  out("but_click")
  Events.del_custom_event("main", "sprite-button", "settings-key")
end

function Events.gui_key(event)
  Player.load(event)
  Controller.main_key_event()

  if game.players[event.player_index].gui.center["fnei_element_list"] then

    return
  end

  local gui = game.players[event.player_index].gui.center.add({type = "flow", name = "fnei_element_list", direction = "horizontal"})
  Gui.addSpriteButton(gui, "main", "settings-key", {"fnei.settings-key"}, "fnei_settings_button_style", Events.but_click)
  gui.add({type = "choose-elem-button", name = "fnei_main_sdf", elem_type = "fluid"})
  gui.add({type = "choose-elem-button", name = "fnei_main_sd1f", elem_type = "item"})
  gui.add({type = "choose-elem-button", name = "fnei_main_sdf2", elem_type = "recipe"})
  game.players[event.player_index].opened = gui
end

function Events.on_tick(event)

end

function Events.on_gui_closed(event)
  Player.load(event)
  out(event)
  if event and event.element and string.match(event.element.name, "fnei%_") then
    Events.gui_key(event)
  end
end

function Events.on_event_invoke(event)
  Player.load(event)
  local gui_name, gui_type, event_name  = Events.parse_name(event)
  CustomEvents.invoke(gui_name, gui_type, event_name, event)
end

function Events.parse_name(event)
  if event == nil then 
    out("Error: Events.parse_name: event == nil ")
    return 
  end
  local element = event.element
  if element == nil then 
    out("Error: Events.parse_name: element == nil ")
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

function Events:init()
  script.on_configuration_changed(self.on_configuration_changed)
  self.event_load(defines.events.on_tick, self.on_tick)
  self.event_load(gui_key_name, self.gui_key)
  self.event_load(back_key_name, self.back_key)
  self.event_load(defines.events.on_gui_closed, self.on_gui_closed)

  for _,event in pairs(supported_gui_event) do
    self.event_load(event, self.on_event_invoke)
  end  
end

function Events.event_load(event_name, func)
  script.on_event(event_name, func)
end

return Events