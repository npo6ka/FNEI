local HotbarGui = {
  classname = "FNHotbarGui",
  name = "hotbar",
}

local hotbar_gui_template
local hotbar_flow_name = "fnei_hotbar_flow"

function HotbarGui.init_template()
  local cont = Controller.get_cont(HotbarGui.name)

  hotbar_gui_template = {
    { type = "table", name = "hotbar-main-table", style = "fnei_hotbar_zero_spacing_table", column_count = 1, children = {
      { type = "frame", name = "frame", style = "fnei_hotbar_frame", children = {
        { type = "sprite-button", name = "fnei-button", style = "fnei_hotbar_label_button", caption = "FNEI", event = Controller.main_key_event},
      }},
      { type = "table", name = "hot-icon-table", style = "fnei_hotbar_zero_spacing_table", column_count = 1 },
    }},
  }

end

function HotbarGui.init_events()
  HotbarGui.init_template()
  Events.init_temp_events(HotbarGui.name, hotbar_gui_template)
end

function HotbarGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_left_gui(), hotbar_gui_template[1].name)

  if val and next(val) and val.valid then
    return true
  else
    return false
  end
end

function HotbarGui.create_hotbar_choose_button(prot, type)
  if prot then
    return { type = "choose-elem-button", name = prot.type .. "_" .. prot.name or "empty", style = "fnei_default_button", elem_type = prot.type, elem_value = prot.name, locked = true }
  elseif type == "favorite" then
    return { type = "sprite-button", name = "empty", style = "fnei_hotbar_block_button", tooltip = {"fnei.qwe"}, sprite = "fnei_favorite_icon" }
  else
    return { type = "sprite-button", name = "empty", style = "fnei_hotbar_block_button", tooltip = {"fnei.ewq"}, sprite = "fnei_last_usage_icon" }
  end
end

function HotbarGui.create_hoticon_bar(parent)
  local line_cnt = Settings.get_val("hotbar-line-num")
  local parent = Gui.get_gui(parent, "hot-icon-table")

  if line_cnt == 0 then
    return
  end

  local mas1 = {}
  local mas2 = {}

  local block_size = 5
  local bl_cnt = math.floor((line_cnt - 1) / block_size) + 1
  local template = {}
  local icon_frame = {}

  if Settings.get_val("show-full-hotbar") then
    table.insert(icon_frame, { type = "label", name = "last-usage-button", style = "fnei_hotbar_label", caption = {"fnei.last_button"} })
    table.insert(icon_frame, { type = "label", name = "favorite-button", style = "fnei_hotbar_label", caption = {"fnei.fav_button"} })

    for i = 1,bl_cnt do
      if i == bl_cnt then
        block_size = (line_cnt - 1) % block_size + 1
      end

      for j = 1,block_size do
        local cur_indx = (i - 1) * 5 + j
        local fav_prot = mas1[cur_indx]
        local last_prot = mas2[cur_indx]
        
        table.insert(icon_frame, HotbarGui.create_hotbar_choose_button(fav_prot, "last_usage"))
        table.insert(icon_frame, HotbarGui.create_hotbar_choose_button(last_prot, "favorite"))
      end

      table.insert(template, 
      { 
        type = "frame", name = "hoticon_frame" .. i, style = "fnei_hotbar_frame", direction = "vertical", children = { 
          { type = "table", name = "hoticon-table" .. i, style = "fnei_hotbar_zero_spacing_table", column_count = 2, children = icon_frame },
        }
      })

      icon_frame = {}
    end

    table.insert(template, { type = "button", name = "hide-button", style = "fnei_hotbar_up_arrow", })
  else
    table.insert(template, { type = "button", name = "hide-button", style = "fnei_hotbar_down_arrow", })
  end

  Gui.add_gui_template(parent, template)
end

function HotbarGui.open_window()
  HotbarGui.close_window()

  local gui = Gui.get_left_gui()

  if not gui[hotbar_flow_name] then
    gui.add({ type = "flow", name = hotbar_flow_name, style = nil, direction = "vertical" }) 
  end
  gui = Gui.add_gui_template(gui[hotbar_flow_name], hotbar_gui_template)

  HotbarGui.create_hoticon_bar(gui)

  return gui
end 

function HotbarGui.close_window()
  if HotbarGui.is_gui_open() then
    Gui.get_gui(Gui.get_left_gui(), hotbar_gui_template[1].name).destroy()
  end
end

return HotbarGui