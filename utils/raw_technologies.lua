local RawTech = {
  classname = "FNRawTech"
}

local atech_list = {}

function RawTech:get_tech_list()
  Debug:debug(RawTech.classname, "get_tech_list( )")
  return Player.get().force.technologies or {}
end

--return a list of attainable technologies or empty list
function RawTech:get_aTech_list()
  Debug:debug(RawTech.classname, "get_atech_list( )")
  local global = Player.get_fglobal()
  if not global["atech"] then
    global["atech"] = self:create_attainable_tech()
  end

  return global["atech"]
end

function RawTech:is_attainable_tech(tech)
  Debug:debug(RawTech.classname, "is_attainable_tech(", tech, ")")
  return self:is_attainable_tech_buf(tech)
end

function RawTech:get_recipe_list_in_tech_dependencies()
  Debug:debug(RawTech.classname, "get_recipe_in_tech_dependencies( )")
  local global = Player.get_fglobal()
  if not global["dep_tech"] then
    global["dep_tech"] = self:create_tech_dependencies()
  end

  return global["dep_tech"]
end
----------------------------- secondary fanction --------------------------------

function RawTech:is_attainable_tech_buf(tech)
  local tech_name = tech.name
  if atech_list[tech_name] == nil then
    atech_list[tech_name] = false
    local flag = true
    for _,pretech in pairs(tech.prerequisites) do
      if not pretech.enabled then
        flag = false
      elseif pretech.researched then
        flag = flag and true
      else
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