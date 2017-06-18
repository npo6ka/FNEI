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

function fnei.mc.set_style(element)
  local item = game.item_prototypes[element.name]
  if item and item.flags["hidden"] == true then
    element.style = "fnei_red_slot_button_style"
  else
    element.style = "fnei_slot_button_style"
  end
  return element
end