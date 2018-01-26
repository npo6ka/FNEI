if not Item then Item = require "utils/items" end

local CraftCategoty = {
  -- single-line comment
  classname = "FNCraftCategoty"
}

local craf_cat

--return a list of attainable technologies or empty list
function CraftCategoty:get_crafting_category_list()
  Debug:debug(CraftCategoty.classname, "get_crafting_category_list( )")
  if not craf_cat then
    craf_cat = self:create_crafting_category_list()
  end
  return craf_cat or {}
end

function CraftCategoty:get_craft_cat_whis_slot_amount(category, need_amount_slot)
  Debug:debug(CraftCategoty.classname, "get_craft_cat_whis_slot_amount(", category, ",", need_amount_slot, ")")
  return self:get_crafting_categories_list_whis_amount(category, need_amount_slot) or {}
end

----------------------- secondary function --------------------------

function CraftCategoty:create_crafting_category_list()
  local ret_tb = {}
  local item_list = Item:get_item_list()

  ret_tb["handcraft"] = {}
  table.insert(ret_tb["handcraft"], {type = "player", val = "handcraft"})

  local entity = Player.get().character
  if entity ~= nil and entity.prototype.crafting_categories then
    for category,v in pairs(entity.prototype.crafting_categories) do
      if not ret_tb[category] then
        ret_tb[category] = {}
      end
      table.insert(ret_tb[category], {type = "player", val = "handcraft"})
    end
  end

  for _,item in pairs(item_list) do
    local entity = item.place_result
    if entity ~= nil and entity.crafting_categories then
      for category,v in pairs(entity.crafting_categories) do
        if not ret_tb[category] then
          ret_tb[category] = {}
        end
        table.insert(ret_tb[category], {type = "building", val = item})
      end
    end
  end

  return ret_tb
end

function CraftCategoty:get_crafting_categories_list_whis_amount(category, amount)
  local ret_tb = {}
  local craf_cat = CraftCategoty:get_crafting_category_list()[category]
  if craf_cat then
    for _,item in pairs(craf_cat) do
      if item.type == "building" then
        if item.val and item.val.place_result then
          local entity = item.val.place_result
          if entity.ingredient_count ~= nil then 
            if entity.ingredient_count >= amount then
              table.insert(ret_tb, item)
            end
          else
            table.insert(ret_tb, item)
          end
        end
      elseif item.type == "player" then
        table.insert(ret_tb, item)
      end
    end
  end

  return ret_tb
end

return CraftCategoty