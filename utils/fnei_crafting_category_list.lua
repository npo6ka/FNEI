---
-- Description of the module.
-- @module CraftCategoty
--
local CraftCategoty = {
  -- single-line comment
  classname = "FNCraftCategoty"
}

--return a list of attainable technologies or empty list
function CraftCategoty:get_crafting_category_list(item_list)
  Debug:debug(CraftCategoty.classname, "get_crafting_category_list(", item_list and "item_list", ")")
  return self:create_crafting_category_list(item_list) or {}
end

function CraftCategoty:get_craft_cat_whis_slot_amount(item_list, category, need_amount_slot)
  Debug:debug(CraftCategoty.classname, "get_craft_cat_whis_slot_amount(", item_list and "item_list,", category, ",", need_amount_slot, ")")
  return self:get_crafting_categories_list_whis_amount(item_list, category, need_amount_slot) or {}
end

----------------------- secondary function --------------------------

function CraftCategoty:create_crafting_category_list(item_list)
  local ret_tb = {}

  for _,item in pairs(item_list) do
    local entity = item.place_result
    if entity ~= nil and entity.crafting_categories then
      for category,v in pairs(entity.crafting_categories) do
        if not ret_tb[category] then
          ret_tb[category] = {}
        end
        table.insert(ret_tb[category], item)
      end
    end 
  end

  return ret_tb
end

function CraftCategoty:get_crafting_categories_list_whis_amount(item_list, category, amount)
  local ret_tb = {}
  local craf_cat = CraftCategoty:create_crafting_category_list(item_list)[category]
  if craf_cat then
    for _,item in pairs(craf_cat) do
      if item and item.place_result then
        local entity = item.place_result
        if entity.ingredient_count ~= nil then 
          if entity.ingredient_count >= amount then
            table.insert(ret_tb, item)
          end
        else
          table.insert(ret_tb, item)
        end
      end
    end
  end

  return ret_tb
end

return CraftCategoty