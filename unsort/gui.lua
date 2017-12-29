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

function set_def_fields(gui_type, cont_name, gui_name, style)
  local gui_elem = {
    type = "sprite-button",
    name = Gui.create_gui_name(cont_name, gui_name),
  }

  if style == "" then
    gui_elem.style = gui_elem.name
  else
    gui_elem.style = style
  end
  return gui_elem
end

function Gui.addSpriteButton(parent, cont_name, gui_name, tooltip, style, event_handler)
  local gui_elem = set_def_fields("sprite-button", cont_name, gui_name, style)

  if tooltip then
    gui_elem.tooltip = tooltip
  else
    gui_elem.tooltip = {"",""}
  end

  parent.add(gui_elem)

  Events.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)
end

function Gui.addFlow(parent, cont_name, gui_name, style)
  local gui_elem = set_def_fields("flow", cont_name, gui_name, style)
  parent.add(gui_elem)
end

function Gui.addFrame(parent, cont_name, gui_name, style)
  local gui_elem = set_def_fields("frame", cont_name, gui_name, style)
  parent.add(gui_elem)
end

function Gui.addTable(parent, cont_name, gui_name, style, colspan)
  local gui_elem = set_def_fields("table", cont_name, gui_name, style)
  gui_elem.colspan = colspan
  parent.add(gui_elem)
end

function Gui.addDropDown(parent, cont_name, gui_name, style, items, selected_index)
  local gui_elem = set_def_fields("drop-down", cont_name, gui_name, style)
  gui_elem.items = items
  gui_elem.selected_index = selected_index
  parent.add(gui_elem)
end

function Gui.addCheckbox(parent, cont_name, gui_name, style, state)
  local gui_elem = set_def_fields("checkbox", cont_name, gui_name, style)
  gui_elem.state = state
  parent.add(gui_elem)
end

return Gui