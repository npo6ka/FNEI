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
    local gui = Gui.get_gui(Gui.get_pos(), setting.name .. textfield_name)
    if gui then
      gui.text = val
    end
  end
end

function NumericUpDown.add_label_func(parent, sett)
  Gui.add_label(parent, { type = "label", name = sett.name .. "-label", style = "fnei_settings_param-label", caption = {"fnei." .. sett.name} })
end

function NumericUpDown.get_template(sett)
  return 
  {
    { type = "flow", name = sett.name .. "_flow", style = nil, children = {
      { type = "textfield", name = sett.name .. textfield_name, style = nil, event = NumericUpDown.text_chenge_event },
      { type = "flow", name = sett.name .. "_vertical_flow", style = nil, direction = "vertical", children = {
        { type = "button", name = sett.name .. up_but_name, style = nil, event =  NumericUpDown.up_event },
        { type = "button", name = sett.name .. down_but_name, style = nil, event = NumericUpDown.down_event },
      }},
      { type = "label", name = sett.name .. war_label_name, style = nil, caption = "" },
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
      local gui = Gui.get_gui(Gui.get_pos(), sett_name .. war_label_name)

      if num >= option.min_val and num <= option.max_val then
        Settings.set_val(sett_name, tonumber(val))
        gui.caption = ""
      else
        local msg = ": [" .. (option.min_val or 0) .. "-" .. (option.max_val or "2^32") .. "]"

        gui.caption = {"", {"fnei.out-of-range"}, msg}
      end
    end
  end
end

function NumericUpDown.up_event(event, sett_name)
  sett_name = string.sub(sett_name, 0, string.len(sett_name) - string.len(up_but_name) )
  Settings.set_val(sett_name, Settings.get_val(sett_name) + 1)
  local gui = Gui.get_gui(Gui.get_pos(), sett_name .. war_label_name)
  if gui then gui.caption = "" end
end

function NumericUpDown.down_event(event, sett_name)
  sett_name = string.sub(sett_name, 0, string.len(sett_name) - string.len(down_but_name) )
  Settings.set_val(sett_name, Settings.get_val(sett_name) - 1)
  local gui = Gui.get_gui(Gui.get_pos(), sett_name .. war_label_name)
  if gui then gui.caption = "" end
end


function NumericUpDown.event_init(sett)
  Events.init_temp_events(Controller.get_cont("settings").get_name(), NumericUpDown.get_template(sett))
end

return NumericUpDown