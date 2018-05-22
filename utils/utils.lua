function get_localised_name( element )
  return element and (element.localised_name or element.name)
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function clear_gui(parent)
  for _, gui in pairs(parent.children) do
    if gui and gui.valid then
      gui.destroy()
    end
  end
end