Events = {
  classname = "FNEvents"
}

local gui_key_name = "pressed-fnei-gui-key"
local back_key_name = "pressed-fnei-back-key"
local CustomEvents = require "scripts/custom_events"

local supported_gui_event = {
  defines.events.on_gui_checked_state_changed,
  defines.events.on_gui_selection_state_changed,
  defines.events.on_gui_click,
  defines.events.on_gui_text_changed,
  defines.events.on_gui_elem_changed,
}

function Events.debug()
  CustomEvents.debug()
end

function Events.add_custom_event(gui_name, gui_type, event_name, func)
  CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
end

function Events.del_custom_event(gui_name, gui_type, event_name)
  CustomEvents.del_custom_event(gui_name, gui_type, event_name)
end

function Events.on_configuration_changed(event)
  if not global.fnei then global.fnei = {} end
  if not global.fnei.event_list then global.fnei.event_list = {} end

  for i, player in pairs(game.players) do
    Player.load({ player_index = i })
    Gui.close_old_fnei_gui()
    Controller.back_key_event()
    Controller.get_cont("hotbar").on_configuration_change()
  end
end

function Events.on_player_created(event)
  Player.load(event)
  Controller.get_cont("hotbar").open()
end

function Events.back_key(event)
  Player.load(event)
  Controller.back_key_event()
end

function Events.gui_key(event)
  Player.load(event)
  Controller.main_key_event()
end

function Events.on_tick(event)
  hard_load()
end

function Events.on_gui_closed(event)
  Player.load(event)
  if event and event.element and string.match(event.element.name, "fnei%\t") then
    Events.gui_key(event)
  end
  TechHook.on_gui_closed(event)
end

function Events.on_player_left_game(event)

end

function Events.on_event_invoke(event)
  Player.load(event)
  local gui_name, gui_type, event_name, split_strings = Events.parse_name(event)
  CustomEvents.invoke(gui_name, gui_type, event_name, event, split_strings)
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

  local split_strings = {}

  for num in string.gmatch(element.name or "", "[^\t]+") do
    table.insert(split_strings, num)
  end

  if split_strings[1] == Gui.get_prefix() then
    return split_strings[2], element.type, split_strings[3], split_strings
  end
end

function Events:init()
  script.on_configuration_changed(self.on_configuration_changed)
  script.on_init(self.on_configuration_changed)
  script.on_load(self.on_load)

  self.event_load(defines.events.on_player_created, self.on_player_created)
  self.event_load(defines.events.on_tick, self.on_tick)
  self.event_load(gui_key_name, self.gui_key)
  self.event_load(back_key_name, self.back_key)
  self.event_load(defines.events.on_gui_closed, self.on_gui_closed)
  self.event_load(defines.events.on_player_left_game, self.on_player_left_game)

  for _,event in pairs(supported_gui_event) do
    self.event_load(event, self.on_event_invoke)
  end

  Controller.init_events()
end

function Events.init_temp_events(gui_name, gui_template)
  if gui_template then
    for _,gui_temp in pairs(gui_template) do
      if gui_temp.event then
        Events.add_custom_event(gui_name, gui_temp.type, gui_temp.name, gui_temp.event)
      end
      Events.init_temp_events(gui_name, gui_temp.children)
    end
  end
end

function Events.event_load(event_name, func)
  script.on_event(event_name, func)
end