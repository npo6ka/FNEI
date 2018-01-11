if not global.fnei.event_list then global.fnei.event_list = {} end

local CustomEvents = {
  classname = "FNCustomEvents",
}

function CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
  Debug:debug(CustomEvents.classname, "CustomEvents.add_custom_event(", gui_name, gui_type, event_name, func, ")")
  if not gui_name or not event_name or not gui_type then
    out("Error in CustomEvents.add_custom_event: input == nil")
    return
  end

  if not CustomEvents.event_exists(gui_name, gui_type, event_name) then
    if not global.fnei.event_list[gui_name] then
      global.fnei.event_list[gui_name] = {}
    end
    if not global.fnei.event_list[gui_name][gui_type] then
      global.fnei.event_list[gui_name][gui_type] = {}
    end
    global.fnei.event_list[gui_name][gui_type][event_name] = func
  end
end

function CustomEvents.del_custom_event(gui_name, gui_type, event_name)
  Debug:debug(CustomEvents.classname, "CustomEvents.del_custom_event(", gui_name, gui_type, event_name, ")")
  if not gui_name or not event_name or not gui_type then
    out("Error in CustomEvents.del_custom_event: input == nil")
    return
  end
  if CustomEvents.event_exists(gui_name, gui_type, event_name) then
    global.fnei.event_list[gui_name][gui_type][event_name] = nil
  else 
    out("Error CustomEvents.del_custom_event: Event not found")
  end
end

function CustomEvents.event_exists(gui_name, gui_type, event_name)
  Debug:debug(CustomEvents.classname, "CustomEvents.event_exists(", gui_name, gui_type, event_name, ")")
  if global.fnei.event_list[gui_name] and 
     global.fnei.event_list[gui_name][gui_type] and 
     global.fnei.event_list[gui_name][gui_type][event_name] then
    return true
  end
  return false
end

function CustomEvents.invoke(gui_name, gui_type, event_name, event)
  Debug:debug(CustomEvents.classname, "CustomEvents.invoke(", gui_name, gui_type, event_name, event, ")")
  if not gui_name or not event_name or not event then
    out("Error in CustomEvents.invoke: input == nil")
    return
  end
  if CustomEvents.event_exists(gui_name, gui_type, event_name) then
    global.fnei.event_list[gui_name][gui_type][event_name](event, event_name)
  else
    out("Error CustomEvents.invoke: event not found ", event, event.element.name)
  end
end

function CustomEvents.remove_gui_events(gui_name)
  Debug:debug(CustomEvents.classname, "CustomEvents.remove_gui_events(", gui_name, ")")
  global.fnei.event_list[gui_name] = nil
end

return CustomEvents
