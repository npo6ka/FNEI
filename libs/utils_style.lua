function get_tech_style(tech)
  if not tech then 
    return "fnei_empty_slot_button_style" 
  end
  if tech.researched then
    return "fnei_green_tech_button_style"
  else
    local preq = tech.prerequisites
    for _,tec in pairs(preq) do
      if tec and not tec.researched then
        return "fnei_red_tech_button_style"
      end
    end
    return "fnei_yellow_tech_button_style"
  end
end

function set_style(element)
  local item = game.item_prototypes[element.name]
  if item and item.has_flag("hidden") and item.flags["hidden"] == true then
    element.style = "red_slot_button_style"
  else
    element.style = "slot_button_style"
  end
  return element
end

function get_recipe_style(enabled)
  if enabled then 
    return "fnei_recipe_title_label"
  else
    return"fnei_red_recipe_title_label"
  end
end
