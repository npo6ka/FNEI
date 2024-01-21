local Item = {
  classname = "FNItems"
}

function Item:get_item_list()
  Debug:debug(Item.classname, "get_item_list( )")
  return game.item_prototypes or {}
end

function Item:get_fluid_list()
  Debug:debug(Item.classname, "get_fluid_list( )")
  return game.fluid_prototypes or {}
end

function Item:get_vItem_list(item_list)
  Debug:debug(Item.classname, "get_vItem_list(", item_list and "item_list", ")")
  return self:create_visible_items(item_list)
end

function Item:get_vFluid_list(fluid_list)
  Debug:debug(Item.classname, "get_vFluid_list_list(", fluid_list and "fluid_list", ")")
  return self:create_visible_fluids(fluid_list)
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

function Item:create_visible_fluids(fluid_list)
  local ret_tb = {}

  for _,fluid in pairs(fluid_list) do
    if not fluid.hidden then
      ret_tb[fluid.name] = fluid
    end
  end

  return ret_tb
end

return Item