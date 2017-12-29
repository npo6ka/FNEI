local Gui = {
  classname = "FNGui"
}

local mod_prefix = "fnei"
local CustomEvent = require "unsort/custom_events"

function Gui.get_prefix()
  return mod_prefix
end

function Gui.create_gui_name(cont_name, gui_name)
  return Gui.get_prefix() .. '_' .. cont_name .. '_' .. gui_name
end


function Gui.addSpriteButton(parent, cont_name, gui_name, tooltip, style, event_handler)
  local gui_elem = {
    type = "sprite-button",
    name = Gui.create_gui_name(cont_name, gui_name),
  }

  if style then
    gui_elem.style = style
  else
    gui_elem.style = gui_elem.name
  end

  if tooltip then
    gui_elem.tooltip = tooltip
  else
    gui_elem.tooltip = {"",""}
  end

  parent.add(gui_elem)

  DefaultEvents.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)
end

return Gui