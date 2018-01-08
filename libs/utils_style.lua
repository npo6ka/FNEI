function set_style(element)
  local item = game.item_prototypes[element.name]
  if item and item.has_flag("hidden") and item.flags["hidden"] == true then
    element.style = "red_slot_button_style"
  else
    element.style = "slot_button"
  end
  return element
end

