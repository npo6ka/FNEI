TechHook = {
  classname = "FNTechHook",
}

function TechHook.save_cur_fnei_state()
  Player.get_global().opened_gui = Controller.get_cur_con_name()
end

function TechHook.on_gui_closed(event)
  out("gui closed", event.gui_type)
  if event.gui_type == 2 then
    local contr = Player.get_global().opened_gui

    if not Settings.get_val("close-gui-when-tech-open") and Settings.get_val("need-show") and contr then
      out("open old gui", contr)
      Controller.open_event(contr)
      Player.get_global().opened_gui = nil
    end
  end
end