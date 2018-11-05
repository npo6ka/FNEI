local CustomEvents = {
  classname = "FNCustomEvents",
}

event_list = {}

function CustomEvents.add_custom_event(gui_name, gui_type, event_name, func)
  Debug:debug(CustomEvents.classname, "CustomEvents.add_custom_event(", gui_name, gui_type, event_name, func, ")")
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
    event_list[gui_name][gui_type][event_name] = {}
  end
  if type(func) == "function" then 
    table.insert(event_list[gui_name][gui_type][event_name], func)
  elseif type(func) == "table" then
    for _,fun in pairs(func) do
      table.insert(event_list[gui_name][gui_type][event_name], fun)
    end
  end
end

function CustomEvents.del_custom_event(gui_name, gui_type, event_name)
  Debug:debug(CustomEvents.classname, "CustomEvents.del_custom_event(", gui_name, gui_type, event_name, ")")
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
  Debug:debug(CustomEvents.classname, "CustomEvents.event_exists(", gui_name, gui_type, event_name, ")")
  if event_list[gui_name] and 
     event_list[gui_name][gui_type] and 
     event_list[gui_name][gui_type][event_name] then
    return true
  end
  return false
end

function CustomEvents.invoke(gui_name, gui_type, event_name, event, split_strings)
  Debug:debug(CustomEvents.classname, "CustomEvents.invoke(", gui_name, gui_type, event_name, event, ")")
  if not gui_name or not event_name or not event then
    out("Error in CustomEvents.invoke: input == nil")
    return
  end
  if CustomEvents.event_exists(gui_name, gui_type, event_name) then
    local events = event_list[gui_name][gui_type][event_name]
    for _,cur_event in pairs(events) do
      local ok , err = pcall(function()
        cur_event(event, event_name, split_strings)
      end)

      if not(ok) then
        Debug:error(CustomEvents.classname, "FNEI: event ", gui_name, gui_type, event_name, " return error!")
        Debug:error(CustomEvents.classname, err)

        Gui.refresh_fnei_gui()
      end
    end
  else
    out("Error CustomEvents.invoke: event not found ", event, event.element.name, gui_name, gui_type, event_name)
  end
end

function CustomEvents.remove_gui_events(gui_name)
  Debug:debug(CustomEvents.classname, "CustomEvents.remove_gui_events(", gui_name, ")")
  event_list[gui_name] = nil
end

function CustomEvents.debug()
  for a,gui_name in pairs(event_list) do
    for b,gui_type in pairs(gui_name) do
      for c,gui_event in pairs(gui_type) do
        for d,event in pairs(gui_event) do
          out(a, b, c, d)
        end
      end
    end
  end
end

return CustomEvents
