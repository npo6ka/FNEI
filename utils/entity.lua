if not Item then Item = require "utils/items" end

local Entity = {
  classname = "FNEntity"
}

local mineable_entity
local nConvert_entity

function Entity:get_entity_list()
  Debug:debug(Entity.classname, "get_entity_list( )")
  return game.entity_prototypes or {}
end

function Entity:get_mineable_entity_list()
  Debug:debug(Entity.classname, "get_mineable_entity_list( )")

  if not mineable_entity then
    mineable_entity = self:create_mineable_entity(Entity:get_entity_list())
  end

  return mineable_entity or {}
end

function Entity:get_nConvert_entity_list()
  Debug:debug(Entity.classname, "get_nConver_entity_list( )")

  if not nConvert_entity then
    nConvert_entity = self:create_nConvert_entity(Entity:get_mineable_entity_list())
  end

  return nConvert_entity or {}
end

----------------------- secondary function --------------------------

function Entity:create_mineable_entity(entity_list)
  local ret_tb = {}

  for _,entity in pairs(entity_list) do
    if entity.mineable_properties and entity.mineable_properties.products then
      ret_tb[entity.name] = entity
    end
  end

  return ret_tb
end

function Entity:create_nConvert_entity(entity_list)
  local ret_tb = {}
  local item_list = Item:get_item_list()
  local is_add

  for _,entity in pairs(entity_list) do
    if entity.mineable_properties and entity.mineable_properties.products then
      local prod = entity.mineable_properties.products

      if #prod > 1 then
        is_add = true
      elseif #prod == 1 and entity.mineable_properties.products[1] then
        local prot = entity.mineable_properties.products[1]

        if prot.type == "fluid" or item_list[prot.name].place_result ~= entity then
          is_add = true
        end
      end

      if is_add == true then
        ret_tb[entity.name] = entity
        is_add = false
      end
    end
  end

  return ret_tb
end

return Entity