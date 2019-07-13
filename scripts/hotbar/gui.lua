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

function HotbarGui.create_hotbar_element_button(prot, type)
  if prot and prot.recipe_name then

    if string.match(prot.recipe_name, 'impostor') then
      local ps,pos = string.find(prot.recipe_name, "impostor[-]minable:")

      if not pos then 
        _,pos = string.find(prot.recipe_name, "impostor[-]pumped:")
      end

      local entity_name = string.sub(prot.recipe_name, (pos or -1) + 1) or ""

      local tooltip

      if type == "favorite" then
        tooltip = {"", {"fnei.tooltip-recipe"}, ":\n", game.entity_prototypes[entity_name].localised_name, "\n", {"fnei.alt-to-remove"} }
      else
        tooltip = {"", {"fnei.tooltip-recipe"}, ":\n", game.entity_prototypes[entity_name].localised_name }
      end

      sprite = "entity/" .. entity_name

      return {
        type = "sprite-button",
        name = "r" .. type .. "_" .. prot.action_type .. "_" .. prot.type .. "_" .. prot.name .. "_" .. prot.recipe_name,
        style = "fnei_hotbar_block_button",
        tooltip = tooltip,
        sprite = sprite
      }
    end

    return { 
      type = "choose-elem-button",
      name = "r" .. type .. "_" .. prot.action_type .. "_" .. prot.type .. "_" .. prot.name .. "_" .. prot.recipe_name,
      style = "fnei_default_button",
      elem_type = "recipe",
      elem_value = prot.recipe_name,
      locked = true
      -- type = "sprite-button",
      -- name = "r" .. type .. "_" .. prot.action_type .. "_" .. prot.type .. "_" .. prot.name .. "_" .. prot.recipe_name,
      -- style = "fnei_hotbar_block_button",
      -- tooltip = tooltip,
      -- sprite = sprite
    }
  end

  if type == "favorite" then
    return { type = "sprite-button", name = type .. "_empty", style = "fnei_hotbar_block_button", tooltip = {"", {"fnei.fav_button"}, "\n", {"fnei.alt-to-remove"}}, sprite = "fnei_favorite_icon" }
  else
    return { type = "sprite-button", name = type .. "_empty", style = "fnei_hotbar_block_button", tooltip = {"fnei.last_button"}, sprite = "fnei_last_usage_icon" }
  end
end

function HotbarGui.draw_hotbar_bar_extension(last_arr, fav_arr)
  local last_line_cnt = Settings.get_val("hotbar-last-line-num")
  local fav_line_cnt = Settings.get_val("hotbar-fav-line-num")
  local parent = Gui.get_gui(Gui.get_left_gui(), "hot-icon-table")
  local columns_number = 2

  if last_line_cnt == 0 and fav_line_cnt == 0 then
    return
  end

  local template = {}

  if Settings.get_val("show-extended-hotbar") then
    if last_line_cnt > 0 then
      local last_frame = {}
      local last_label = { type = "label", name = "last-usage-button", style = "fnei_hotbar_label", single_line = true, caption = {"fnei.last_button"} }
    
      for j = 1, last_line_cnt do
        for i = 1, columns_number do
          local cur_indx = (j - 1) * columns_number + i

          table.insert(last_frame, HotbarGui.create_hotbar_element_button(last_arr[cur_indx], "last-usage"))
        end
      end

      table.insert(template,
      { 
        type = "frame", name = "hotbar_last_frame", style = "fnei_hotbar_frame", direction = "vertical", children = {
          { type = "table", name = "hoticon-table", style = "fnei_hotbar_zero_spacing_table", column_count = 1, children = {
            last_label,
            { type = "table", name = "hoticon-table", style = "fnei_hotbar_zero_spacing_table", column_count = 2, children = last_frame },
          }},
        }
      })
    end

    if fav_line_cnt > 0 then
      local fav_frame = {}
      local fav_label = { type = "label", name = "favorite-button", style = "fnei_hotbar_label", single_line = true, caption = {"", {"fnei.fav_button"}, "\n", {"fnei.alt-to-remove"}} }

      for j = 1, fav_line_cnt do
        for i = 1, columns_number do
          local cur_indx = (j - 1) * columns_number + i
        
          table.insert(fav_frame, HotbarGui.create_hotbar_element_button(fav_arr[cur_indx], "favorite"))
        end
      end

      table.insert(template, 
      { 
        type = "frame", name = "hotbar_fav_frame", style = "fnei_hotbar_frame", direction = "vertical", children = {
          { type = "table", name = "hoticon-table", style = "fnei_hotbar_zero_spacing_table", column_count = 1, children = {
            fav_label,
            { type = "table", name = "hoticon-table2", style = "fnei_hotbar_zero_spacing_table", column_count = 2, children = fav_frame },
          }},
        }
      })
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

  return Gui.add_gui_template(gui[hotbar_flow_name], hotbar_gui_template)
end 

function HotbarGui.close_window()
  if HotbarGui.is_gui_open() then
    Gui.get_gui(Gui.get_left_gui(), hotbar_gui_template[1].name).destroy()
  end
end

return HotbarGui
