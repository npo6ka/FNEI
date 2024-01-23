function get_localised_name( element )
  return element and (element.localised_name or element.name)
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function round_to_str(num, idp)
  local val = 0
  if (num > 1000000 or (num < 0.001 and num > 0)) then
    val = string.format("%1.1e", num)
  else
    val = round(num, idp)
  end
  return val
end

function clear_gui(parent)
  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end
end