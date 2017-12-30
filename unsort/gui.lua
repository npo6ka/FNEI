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

function Gui.set_def_fields(gui_type, cont_name, gui_name, style)
  local gui_elem = {
    type = gui_type,
    name = Gui.create_gui_name(cont_name, gui_name),
  }

  if style == "" then
    gui_elem.style = gui_elem.name
  else
    gui_elem.style = style
  end
  return gui_elem
end

function Gui.addSpriteButton(parent, cont_name, gui_name, style, tooltip, event_handler)
  local gui_elem = Gui.set_def_fields("sprite-button", cont_name, gui_name, style)

  if tooltip then
    gui_elem.tooltip = tooltip
  else
    gui_elem.tooltip = {"",""}
  end

  Events.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)

  return parent.add(gui_elem)
end

function Gui.addFlow(parent, cont_name, gui_name, style)
  local gui_elem = Gui.set_def_fields("flow", cont_name, gui_name, style)
  return parent.add(gui_elem)
end

function Gui.addFrame(parent, cont_name, gui_name, style, direction)
  local gui_elem = Gui.set_def_fields("frame", cont_name, gui_name, style)
  if direction then
    gui_elem.direction = direction
  end
  return parent.add(gui_elem)
end

function Gui.addTable(parent, cont_name, gui_name, style, column_count)
  local gui_elem = Gui.set_def_fields("table", cont_name, gui_name, style)
  gui_elem.column_count = column_count
  return parent.add(gui_elem)
end

function Gui.addDropDown(parent, cont_name, gui_name, style, items, selected_index)
  local gui_elem = Gui.set_def_fields("drop-down", cont_name, gui_name, style)
  gui_elem.items = items
  gui_elem.selected_index = selected_index
  return parent.add(gui_elem)
end

function Gui.addCheckbox(parent, cont_name, gui_name, style, state)
  local gui_elem = Gui.set_def_fields("checkbox", cont_name, gui_name, style)
  gui_elem.state = state
  return parent.add(gui_elem)
end

function Gui.addLabel(parent, cont_name, gui_name, style, caption)
  local gui_elem = Gui.set_def_fields("label", cont_name, gui_name, style)
  caption = caption or "unknow"
  gui_elem.caption = caption
  return parent.add(gui_elem)
end

return Gui