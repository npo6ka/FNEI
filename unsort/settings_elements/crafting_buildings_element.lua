local CraftingBuildingsSett = {
  classname = "FNCraftingBuildingsSett",
}

function CraftingBuildingsSett.init(name, def_val)
  local craft_tb = get_crafting_category()
  local settings = Settings.get_global_sett()[name]


  if not settings then settings = {} end
  if not settings["craft_cat"] then settings["craft_cat"] = {} end
  if not settings["items_cat"] then settings["items_cat"] = {} end

  for cat, items in pairs(craft_tb) do
    settings["craft_cat"][cat] = def_val
    for _, item in pairs(items) do
      settings["items_cat"][item.name] = item
    end
  end
end

function CraftingBuildingsSett.get_val(name)
  return Settings.get_global_sett()[name]
end

function CraftingBuildingsSett.set_val(name, val)
  --Settings.get_global_sett()[name] = val
end

function CraftingBuildingsSett.add_label_func(parent, cont_name, sett)
  Gui.addLabel(parent, cont_name, sett.name .. "-label", "fnei_option_param_label", {"fnei." .. sett.name})
end

function CraftingBuildingsSett.add_content_func(parent, cont_name, sett)
  local settings = CraftingBuildingsSett.get_val(sett.name)
  local craft_tb = get_crafting_category()

  local gui = Gui.addScrollPane(parent, cont_name, sett.name .. "-scroll-pane", "fnei_option_param_3_scroll")
  gui = Gui.addTable(gui, cont_name, sett.name .. "-table", nil, 5)


  local cnt
  for cat, items in pairs(craft_tb) do
    cnt = 0
    Gui.addSpriteButton(gui, cont_name, sett.name .. "-cat-name-" .. cat, nil, cat, nil)
    --settings["craft_cat"][cat] = def_val
    for _, item in pairs(items) do
      if cnt < 5 then
        --settings["items_cat"][item.name] = item
        cnt = cnt + 1
      end
    end
  end

end

function CraftingBuildingsSett.event(event, sett_name)
  --Settings.set_val(sett_name, event.element.state)
end

return CraftingBuildingsSett


--[[

  local cat_tb = get_item_list_from_cat_tb()
  for _,elem in pairs(cat_tb) do
    item_table.add(fnei.option_gui.get_img(elem.name, fnei.option_gui.get_item_style(player, elem.name)))
  end

function fnei.option_gui.get_item_style( player, name )
  if fnei.oc.get_craft_state_for_building( player, name) then 
    return "fnei_green_building_button_style"
  else
    return "fnei_red_building_button_style"
  end
end

function fnei.option_gui.get_img( name, style )
  local local_name = (game.item_prototypes[name] and game.item_prototypes[name].localised_name) or name
  local tip = {"", local_name, "\n", {"fnei.left-eneble-click"}, "\n", {"fnei.right-disable-click"}}
  local img_name = "fnei_building_"..name

  return {
    type = "sprite-button",
    name = img_name,
    style = style,
    tooltip = tip,
    sprite = "item/"..name
  }
end

function fnei.option_gui.change_buildings_state( player, elem_name )
  if fnei.gui.is_option_open(player) then
    local item = fnei:get_gui(get_gui_pos(player), "fnei_building_"..elem_name)
    if item then
      item.style = fnei.option_gui.get_item_style(player, elem_name)
    end
  end
end

]]