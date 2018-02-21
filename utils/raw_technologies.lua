local RawTech = {
  classname = "FNRawTech"
}

local atech_list = {}
local atech
local dep_tech

function RawTech:get_tech_list()
  Debug:debug(RawTech.classname, "get_tech_list( )")
  return Player.get().force.technologies or {}
end

--return a list of attainable technologies or empty list
function RawTech:get_aTech_list()
  Debug:debug(RawTech.classname, "get_atech_list( )")

  if not atech then
    atech = self:create_attainable_tech()
  end

  return atech
end

function RawTech:is_attainable_tech(tech)
  Debug:debug(RawTech.classname, "is_attainable_tech(", tech, ")")
  return self:is_attainable_tech_buf(tech)
end

function RawTech:get_recipe_list_in_tech_dependencies()
  Debug:debug(RawTech.classname, "get_recipe_in_tech_dependencies( )")

  if not dep_tech then
    dep_tech = self:create_tech_dependencies()
  end

  return dep_tech
end
----------------------------- secondary fanction --------------------------------

function RawTech:is_attainable_tech_buf(tech)
  local tech_name = tech.name

  if tech_name and atech_list[tech_name] == nil then
    local flag = true
    atech_list[tech_name] = false

    if not tech.enabled then
      flag = false
    elseif tech.researched then
      flag = true
    else
      for _,pretech in pairs(tech.prerequisites) do
        flag = flag and self:is_attainable_tech_buf(pretech)
      end
    end

    atech_list[tech_name] = flag
  end

  return atech_list[tech_name]
end

function RawTech:create_attainable_tech()
  local ret_tb = {}
  local tech_list = RawTech:get_tech_list()

  for _,tech in pairs(tech_list) do
      if self:is_attainable_tech_buf(tech) then
        ret_tb[tech.name] = tech
      end
  end

  return ret_tb
end

function RawTech:create_tech_dependencies()
  local ret_tb = {}
  local tech_list = RawTech:get_tech_list()

  for _,tech in pairs(tech_list) do
    for _,modifier in pairs(tech.effects) do
      if modifier.type == "unlock-recipe" then
        if not ret_tb[modifier.recipe] then
          ret_tb[modifier.recipe] = {}
        end
        table.insert(ret_tb[modifier.recipe], tech)
      end
    end
  end
  return ret_tb
end

return RawTech