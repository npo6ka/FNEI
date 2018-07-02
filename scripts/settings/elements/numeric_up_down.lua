local NumericUpDown = {
  classname = "FNNumericUpDown",
}

local textfield_name = "-textfield"
local up_but_name = "-up"
local down_but_name = "-down"
local war_label_name = "-warning"

function NumericUpDown.get_val(setting)
  local global_set = Settings.get_global_sett()

  if global_set[setting.name] == nil then
    global_set[setting.name] = setting.def_val
  end

  return global_set[setting.name]
end

function NumericUpDown.set_val(setting, val)
  if type(val) == "number" then
    if setting.max_val and val > setting.max_val then
      val = setting.max_val
    elseif setting.min_val and val < setting.min_val then
      val = setting.min_val
    end

    Settings.get_global_sett()[setting.name] = val
    NumericUpDown.set_val_in_gui(setting.name, val)
  end
end

function NumericUpDown.set_val_in_gui(sett_name, val)
  local gui = Gui.get_gui(Gui.get_pos(), sett_name .. textfield_name)
  
  if gui then
    gui.text = val
  end
end

function NumericUpDown.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_settings_param-label", caption = {"fnei." .. sett.name} })
end

function NumericUpDown.get_template(sett)
  return 
  {
    { type = "flow", name = sett.name .. "_flow", style = nil, children = {
      { type = "textfield", name = sett.name .. textfield_name, style = "fnei_settings_numeric-text-field", event = NumericUpDown.text_chenge_event },
      { type = "flow", name = sett.name .. "_vertical_flow", style = "fnei_settings_updown-arrow-flow", direction = "vertical", children = {
        { type = "button", name = sett.name .. up_but_name, style = "fnei_settings_up_arrow", event =  NumericUpDown.up_event },
        { type = "button", name = sett.name .. down_but_name, style = "fnei_settings_down_arrow", event =  NumericUpDown.down_event },
      }},
      { type = "label", name = sett.name .. war_label_name, style = "fnei_settings_warning-text", caption = "" },
    }}
  }
end

function NumericUpDown.add_content_func(parent, sett)
  local gui_template = NumericUpDown.get_template(sett)

  Gui.add_gui_template(parent, gui_template)

  local gui = Gui.get_gui(Gui.get_pos(), sett.name .. textfield_name)
  gui.text = Settings.get_val(sett.name)
end

function NumericUpDown.text_chenge_event(event, sett_name)
  sett_name = string.sub(sett_name, 0, string.len(sett_name) - string.len(textfield_name) )
  local element = event.element
  if event.text then
    if event.text ~= "" then
      local val = string.gsub(element.text or "", "[^0-9]", "")
      local num = tonumber(val)
      element.text = num or ""
      local option = Settings.get_sett_list()[sett_name] or {}

      if num and num >= option.min_val and num <= option.max_val then
        Settings.set_val(sett_name, tonumber(val))
        NumericUpDown.success_set(sett_name)
      else
        NumericUpDown.wrong_set(sett_name, ": [" .. (option.min_val or 0) .. "-" .. (option.max_val or "2^32") .. "]")
      end
    end
  end
end

function NumericUpDown.success_set(sett_name)
  local gui_label = Gui.get_gui(Gui.get_pos(), sett_name .. war_label_name)
  local text_field = Gui.get_gui(Gui.get_pos(), sett_name .. textfield_name)

  if not gui_label or not text_field then
    return
  end

  gui_label.caption = ""
  text_field.style = "fnei_settings_numeric-text-field"
end

function NumericUpDown.wrong_set(sett_name, msg)
  local gui_label = Gui.get_gui(Gui.get_pos(), sett_name .. war_label_name)
  local text_field = Gui.get_gui(Gui.get_pos(), sett_name .. textfield_name)

  if not gui_label or not text_field then
    return
  end

  gui_label.caption = {"", {"fnei.out-of-range"}, msg}
  text_field.style = "fnei_settings_wrong_numeric-text-field"
end

function NumericUpDown.up_event(event, sett_name)
  sett_name = string.sub(sett_name, 0, string.len(sett_name) - string.len(up_but_name) )
  Settings.set_val(sett_name, Settings.get_val(sett_name) + 1)
  NumericUpDown.success_set(sett_name)
end

function NumericUpDown.down_event(event, sett_name)
  sett_name = string.sub(sett_name, 0, string.len(sett_name) - string.len(down_but_name) )
  Settings.set_val(sett_name, Settings.get_val(sett_name) - 1)
  NumericUpDown.success_set(sett_name)
end

function NumericUpDown.event_init(sett)
  if sett.def_event ~= false then
    Events.init_temp_events(Controller.get_cont("settings").get_name(), NumericUpDown.get_template(sett))
  end
  if sett.event then
    Events.add_custom_event(Controller.get_cont("settings").get_name(), "textfield", sett.name .. textfield_name, sett.event)
    Events.add_custom_event(Controller.get_cont("settings").get_name(), "button", sett.name .. up_but_name, sett.event)
    Events.add_custom_event(Controller.get_cont("settings").get_name(), "button", sett.name .. down_but_name, sett.event)
  end
end

return NumericUpDown