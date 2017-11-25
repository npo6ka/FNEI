---
-- Description of the module.
-- @module Force
--
local Forceq = {
  -- single-line comment
  classname = "FNForceq"
}


--return a list of attainable technologies or empty list
function get_crafting_categories(player)
  if player.force then
    return get_crafting_categories_list(player.force)
  end
  player.print("nil force in get_crafting_categories")
  return {}
end

function get_craft_cat_whis_amount(player, category, need_amount_slot)
 if player.force then
    return get_crafting_categories_list_whis_amount(player.force, category, need_amount_slot)
  end
  player.print("nil force in get_craft_cat_whis_amount")
  return {}
end

----------------------- secondary function --------------------------

function get_crafting_categories_list(force)
  local data = get_force_data(force)
  if not data.crafting_categories then
    data.crafting_categories = create_crafting_categories_list(force)
  end
  return data.crafting_categories
end

function create_crafting_categories_list(force)
  local ret_tb = {}

  for _,item in pairs(game.item_prototypes) do
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

function get_crafting_categories_list_whis_amount(force, category, amount)
  local ret_tb = {}
  local craf_cat = get_crafting_categories_list(force)[category]
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