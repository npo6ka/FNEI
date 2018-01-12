Gui = {
  classname = "FNGui"
}

local mod_prefix = "fnei"
local CustomEvent = require "unsort/custom_events"

function Gui.get_prefix()
  return mod_prefix
end

function Gui.create_gui_name(contr_name, gui_name)
  if type(contr_name) == "string" and type(gui_name) == "string" then
    return Gui.get_prefix() .. '_' .. contr_name .. '_' .. gui_name
  else
    out("Error in function Gui.create_gui_name: type ~= string: ", contr_name, gui_name)
    return nil
  end
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

--check old fnei gui and close them
function Gui.close_old_fnei_gui()
  local function gui_iterate(parent)
    for _,gui_name in pairs(parent.children_names) do
      if string.match(gui_name or "", "fnei") and parent[gui_name].valid then
        parent[gui_name].destroy()
      end
    end
  end

  gui_iterate(Player.get().gui.left)
  gui_iterate(Player.get().gui.top)
  gui_iterate(Player.get().gui.center)
end

function Gui.get_pos()
  local pos = Settings.get_val("position")

  if pos == 1 then
    return Player.get().gui.left
  elseif pos == 2 then
    return Player.get().gui.top
  elseif pos == 3 then
    return Player.get().gui.center
  else
    Debug:error("utils: get_gui: invalid direction: ", pos)
  end
end

function Gui.get_gui(parent, gui_name)
  local cont_name = Controller.get_cur_con_name()
  local full_bame = Gui.create_gui_name(cont_name, gui_name)
  return Gui:get_gui_proc(parent, full_bame)
end

function Gui:get_gui_proc(gui, name)
  if not self.result then self.result = {} end
  if not gui then return end
  for k,v in pairs(gui.children_names) do
    if gui and gui[v] then
      if gui[v].name == name then
        self.result = gui[v]
        break
      end
      self.result = self:get_gui_proc(gui[v], name)
    end
  end
  return self.result
end

function Gui.addSpriteButton(parent, gui_elem, event_handler)
  local cont_name = Controller.get_cur_con_name()
  gui_elem.type = "sprite-button"

  if event_handler then
    Events.add_custom_event(cont_name, gui_elem.type, gui_elem.name, event_handler)
  end

  gui_elem.name = Gui.create_gui_name(cont_name, gui_elem.name)
  if gui_elem.style == "" then
    gui_elem.style = gui_elem.name
  end

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

function Gui.addDropDown(parent, cont_name, gui_name, style, items, selected_index, event_handler)
  local gui_elem = Gui.set_def_fields("drop-down", cont_name, gui_name, style)
  gui_elem.items = items
  gui_elem.selected_index = selected_index

  Events.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)

  return parent.add(gui_elem)
end

function Gui.addCheckbox(parent, cont_name, gui_name, style, state, event_handler)
  local gui_elem = Gui.set_def_fields("checkbox", cont_name, gui_name, style)
  gui_elem.state = state or false

  Events.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)

  return parent.add(gui_elem)
end

function Gui.addLabel(parent, cont_name, gui_name, style, caption)
  local gui_elem = Gui.set_def_fields("label", cont_name, gui_name, style)
  caption = caption or "unknow"
  gui_elem.caption = caption
  return parent.add(gui_elem)
end

function Gui.addTextfield(parent, cont_name, gui_name, style, text, event_handler)
  local gui_elem = Gui.set_def_fields("textfield", cont_name, gui_name, style)
  text = text or ""
  gui_elem.text = text

  Events.add_custom_event(cont_name, gui_elem.type, gui_name, event_handler)

  return parent.add(gui_elem)
end

function Gui.addScrollPane(parent, cont_name, gui_name, style)
  local gui_elem = Gui.set_def_fields("scroll-pane", cont_name, gui_name, style)

  return parent.add(gui_elem)
end

function Gui.get_local_name(element)
  return (element and element.localised_name) or "unknow"
end