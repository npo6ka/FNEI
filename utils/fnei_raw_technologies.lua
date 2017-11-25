if not Force then Force = require "utils/fnei_force" end

---
-- Description of the module.
-- @module RawTech
--
local RawTech = {
  -- single-line comment
  classname = "FNRawTech"
}

local atech_list = {}

--return a list of attainable technologies or empty list
function RawTech:get_atech_list_p(player)
  Debug:debug(RawTech.classname, "get_atech_list_p(", player, ")")
  return self:get_atech_list_f(Force.get(player))
end

function RawTech:get_atech_list_f(force)
  Debug:debug(RawTech.classname, "get_atech_list_f(", force, ")")
  if not force then return {} end
  return self:create_attainable_tech(self:get_tech_list_f(force))
end

function RawTech:get_tech_list_p(player)
  Debug:debug(RawTech.classname, "get_tech_list_p(", player, ")")
  return self:get_tech_list_f(Force.get(player))
end

function RawTech:get_tech_list_f(force)
  Debug:debug(RawTech.classname, "get_tech_list_f(", force, ")")
  if not force then return {} end
  return force.technologies
end

function RawTech:is_attainable_tech(tech)
  Debug:debug(RawTech.classname, "is_attainable_tech(", tech, ")")
  return self:is_attainable_tech_buf(tech)
end

----------------------------- secondary fanction --------------------------------

function RawTech:is_attainable_tech_buf(tech)
  local tech_name = tech.name
  if atech_list[tech_name] == nil then
    out("1")
    atech_list[tech_name] = false
    local flag = true
    for _,pretech in pairs(tech.prerequisites) do
      if not pretech.enabled then
        flag = false
      elseif pretech.researched then
        flag = flag and true
      else
        flag = flag and self:is_attainable_tech_buf(pretech, atech_list)
      end
    end
    atech_list[tech_name] = flag
  end
  return atech_list[tech_name]
end

function RawTech:create_attainable_tech(in_tech_list)
  local ret_tb = {}
  for _,tech in pairs(in_tech_list) do
      if self:is_attainable_tech_buf(tech) then
        ret_tb[tech.name] = tech
      end
  end

  return ret_tb
end

return RawTech