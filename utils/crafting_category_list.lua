if not Item then Item = require "utils/items" end

local CraftCategoty = {
  -- single-line comment
  classname = "FNCraftCategoty"
}

local craf_cat

--return a list of attainable technologies or empty list
function CraftCategoty:get_crafting_category_list()
  Debug:debug(CraftCategoty.classname, "get_crafting_category_list( )")

  local entity = Player.get().character

  if entity and entity.name then
    if not craf_cat then craf_cat = {} end

    if not craf_cat[entity.name] then
      craf_cat[entity.name] = self:create_crafting_category_list()
    end

    return craf_cat[entity.name] or {}
  end

  return {}
end

----------------------- secondary function --------------------------

function CraftCategoty:create_crafting_category_list()
  local ret_tb = {}
  local item_list = Item:get_item_list()
  local entity = Player.get().character

  if entity ~= nil and entity.prototype.crafting_categories then
    ret_tb["handcraft"] = {}
    table.insert(ret_tb["handcraft"], { type = "player", val = { name = "handcraft" } })

    for category,v in pairs(entity.prototype.crafting_categories) do
      if not ret_tb[category] then
        ret_tb[category] = {}
      end
      table.insert(ret_tb[category], { type = "player", val = { name = "handcraft" } })
    end
  end

  for _,item in pairs(item_list) do
    local entity = item.place_result
    if entity ~= nil and entity.crafting_categories then
      for category,v in pairs(entity.crafting_categories) do
        if not ret_tb[category] then
          ret_tb[category] = {}
        end
        table.insert(ret_tb[category], { type = "building", val = item, ingredient_count = entity.ingredient_count })
      end
    end
  end

  return ret_tb
end

return CraftCategoty