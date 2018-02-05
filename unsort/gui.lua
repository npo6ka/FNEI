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
    return mod_prefix .. '_' .. contr_name .. '_' .. gui_name
  else
    out("Error in function Gui.create_gui_name: type ~= string: ", contr_name, gui_name)
    return nil
  end
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
  local full_name = Gui.create_gui_name(cont_name, gui_name)
  return Gui.get_gui_proc(parent, full_name)
end

function Gui.get_gui_proc(parent, name)
  if not parent then return end
  local result
  for _,g in pairs(parent.children) do
    if g and g.valid then
      if g.name == name then
        return g
      end
      result = Gui.get_gui_proc(g, name)
      if result then 
        return result 
      end
    else
      Debug:error("not valid element: ", g.name)
    end
  end
  return result
end

function Gui.get_local_name(element)
  return (element and element.localised_name) or "unknow"
end

local gui_function = {}

function Gui.init_function()
  gui_function["sprite-button"] = Gui.add_sprite_button
  gui_function["flow"] = Gui.add_flow
  gui_function["frame"] = Gui.add_frame
  gui_function["table"] = Gui.add_table
  gui_function["drop-down"] = Gui.add_drop_down
  gui_function["checkbox"] = Gui.add_checkbox
  gui_function["button"] = Gui.add_button
  gui_function["label"] = Gui.add_label
  gui_function["textfield"] = Gui.add_textfield
  gui_function["scroll-pane"] = Gui.add_scroll_pane
  gui_function["choose-elem-button"] = Gui.add_choose_button
end

function Gui.add_gui_template(parent, gui_temp)
  if gui_temp then
    local gui
    for _,gui_templ in pairs(gui_temp) do
      local gui_elem = {}
      for type, gui_field in pairs(gui_templ) do
        if type ~= "children" and  type ~= "event" then
          gui_elem[type] = gui_field
        end
      end

      if gui_function[gui_templ.type] then
        gui = gui_function[gui_templ.type](parent, gui_elem)
      else
        Debug:error("Error in function Gui.add_template: unknow gui_type: ", gui_temp.type)
      end

      Gui.add_gui_template(gui, gui_templ.children)    
    end
    return gui
  end
end

function Gui.set_def_fields(gui_elem)
  local cont_name = Controller.get_cur_con_name()

  gui_elem.name = Gui.create_gui_name(cont_name, gui_elem.name)

  if gui_elem.style == "" then
    gui_elem.style = gui_elem.name
  end
  return gui_elem
end

function Gui.add_sprite_button(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_flow(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_frame(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_table(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_drop_down(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_checkbox(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_button(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_label(parent, gui_elem)
  Gui.set_def_fields(gui_elem)

  gui_elem.caption = gui_elem.caption or "unknow"
  gui_elem.tooltip = gui_elem.tooltip or gui_elem.caption

  local gui = parent.add(gui_elem)

  gui.style.single_line = gui_elem.single_line or false
  if gui_elem.want_ellipsis ~= nil then gui.style.want_ellipsis = gui_elem.want_ellipsis end

  return gui
end

function Gui.add_textfield(parent, gui_elem)
  Gui.set_def_fields(gui_elem)
  gui_elem.text = gui_elem.text or ""
  return parent.add(gui_elem)
end

function Gui.add_scroll_pane(parent, gui_elem)
  return parent.add(Gui.set_def_fields(gui_elem))
end

function Gui.add_choose_button(parent, gui_elem)
  local gui = parent.add(Gui.set_def_fields(gui_elem))
  Gui.set_choose_but_val(gui, gui_elem.elem_value)
  gui.locked = gui_elem.locked
  return gui
end

function Gui.set_choose_but_val(button, val)
  if button then
    if button.elem_type == "item" then
      if val and game.item_prototypes[val] then
        button.elem_value = val
      end
    elseif button.elem_type == "fluid" then
      if val and game.fluid_prototypes[val] then
        button.elem_value = val
      end
    elseif button.elem_type == "recipe" then
      button.elem_value = val
    end
  else
    Debug:error("Gui.set_choose_but_val: gui_elem == nil")
  end
end

Gui.init_function()