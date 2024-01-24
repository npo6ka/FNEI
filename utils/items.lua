local Item = {
  classname = "FNItems"
}

function Item:get_item_list()
  Debug:debug(Item.classname, "get_item_list( )")
  return game.item_prototypes or {}
end

function Item:get_vItem_list(item_list)
  Debug:debug(Item.classname, "get_vItem_list(", item_list and "item_list", ")")
  return self:create_visible_items(item_list)
end

----------------------- secondary function --------------------------

function Item:create_visible_items(item_list)
  local ret_tb = {}

  for _,item in pairs(item_list) do
    if not item.has_flag("hidden") then
      ret_tb[item.name] = item
    end
  end

  return ret_tb
end

return Item