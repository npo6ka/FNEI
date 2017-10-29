
--return a list of attainable technologies or empty list
function get_tech_list(player)
  if not player.force then
    return get_attainable_tech(player.force)
  end
  return {}
end

----------------------- supported function --------------------------

function get_attainable_tech(force)
  local data = get_force_data(force)
  if not data.technologies then
    data.technologies = create_attainable_tech(force)
  end
  return data.technologies
end

function create_attainable_tech(force)
  local ret_tb = {}
  local temp_list = {}
  for _,tech in pairs(force.technologies) do
      if is_attainable_tech(tech, temp_list) then
        ret_tb[tech.name] = tech
      end
  end

  return ret_tb
end

function is_attainable_tech(tech, temp_list)
  local tech_name = tech.name
  if temp_list[tech_name] == nil then
    temp_list[tech_name] = false
    local flag = true
    for _,pretech in pairs(tech.prerequisites) do
      if not pretech.enabled then
        flag = false
      elseif pretech.researched then
        flag = flag and true
      else
        flag = flag and is_attainable_tech(pretech, temp_list)
      end
    end
    temp_list[tech_name] = flag
  end
  return temp_list[tech_name]
end