local CustomEvents = {
  classname = "FNCustomEvents",
}

local event_list = {}

function CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
  if not gui_name or not event_name or not gui_type then
    out("Error in CustomEvents.add_custom_event: input == nil")
    return
  end

  if not CustomEvents.event_exists(gui_name, gui_type, event_name) then
    if not event_list[gui_name] then
      event_list[gui_name] = {}
    end
    if not event_list[gui_name][gui_type] then
      event_list[gui_name][gui_type] = {}
    end
    event_list[gui_name][gui_type][event_name] = func
  else
    out("Event exists: ", event_name)
  end
end

function CustomEvents.del_custom_event(gui_name, gui_type, event_name)
  if not gui_name or not event_name or not gui_type then
    out("Error in CustomEvents.del_custom_event: input == nil")
    return
  end
  if CustomEvents.event_exists(gui_name, gui_type, event_name) then
    event_list[gui_name][gui_type][event_name] = nil
  else 
    out("Error CustomEvents.del_custom_event: Event not found")
  end
end

function CustomEvents.event_exists(gui_name, gui_type, event_name)
  if event_list[gui_name] and event_list[gui_name][gui_type] and event_list[gui_name][gui_type][event_name] then
    return true
  end
  return false
end

function CustomEvents.invoke(gui_name, gui_type, event_name, event)
  if not gui_name or not event_name or not event then
    out("Error in CustomEvents.invoke: input == nil")
    return
  end
  if CustomEvents.event_exists(gui_name, gui_type, event_name) then
    event_list[gui_name][gui_type][event_name](event)
  else
    out("Error CustomEvents.invoke: event not found")
  end
end

function CustomEvents.remove_gui_events(gui_name)
  event_list[gui_name] = nil
end

return CustomEvents
