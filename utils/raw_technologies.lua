local RawTech = {
  classname = "FNRawTech"
}

local dep_tech

function RawTech:get_tech_list()
  Debug:debug(RawTech.classname, "get_tech_list( )")
  return Player.get().force.technologies or {}
end

function RawTech:get_recipe_list_in_tech_dependencies()
 -- Debug:debug(RawTech.classname, "get_recipe_in_tech_dependencies( )")

  if not dep_tech then
    dep_tech = self:create_tech_dependencies(RawTech:get_tech_list())
  end

  return dep_tech
end
----------------------------- secondary fanction --------------------------------

function RawTech:create_tech_dependencies(tech_list)
  local ret_tb = {}

  for _,tech in pairs(tech_list) do
    for _,modifier in pairs(tech.effects) do
      if modifier.type == "unlock-recipe" then
        if not ret_tb[modifier.recipe] then
          ret_tb[modifier.recipe] = {}
        end
        local flag = true
        for _,d_tech in pairs(ret_tb[modifier.recipe]) do
          if d_tech.name == tech.name then
            flag = false
          end
        end
        if flag then
          table.insert(ret_tb[modifier.recipe], tech)
        end
      end
    end
  end
  return ret_tb
end

return RawTech