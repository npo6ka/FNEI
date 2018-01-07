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

  Settings.get_global_sett()[name] = settings
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
  gui = Gui.addTable(gui, cont_name, sett.name .. "-table", nil, 1)


  local cnt, frame, spr_gui, style, tip, sprite
  -- for cat, items in pairs(craft_tb) do

  --   frame = Gui.addFlow(gui, cont_name, sett.name .. cat, nil, "horizontal")
  --   spr_gui = Gui.addSpriteButton(frame, cont_name, sett.name .. "-cat-name-" .. cat, "fnei_green_category_button_style", cat, nil)
  --   Gui.addLabel(spr_gui, cont_name, sett.name .. "-cat-lable-" .. cat, nil, cat)

  --   for _, item in pairs(items) do
  --       style = CraftingBuildingsSett.get_item_style(settings["items_cat"], item.name)
  --       tip = {"", Gui.get_local_name(item), "\n", {"fnei.left-eneble-click"}, "\n", {"fnei.right-disable-click"}}
  --       sprite = "item/"..item.name

  --       Gui.addSpriteButton(frame, cont_name, sett.name .. "-" .. cat .. "-" ..item.name, style, tip, sprite, nil)
  --   end
  -- end
end

function CraftingBuildingsSett.event(event, sett_name)
  --Settings.set_val(sett_name, event.element.state)
end

function CraftingBuildingsSett.get_item_style(settings, item_name)
  if settings[item_name] then
    return "fnei_green_building_button_style"
  else
    return "fnei_red_building_button_style"
  end
end

return CraftingBuildingsSett


--[[

  local cat_tb = get_item_list_from_cat_tb()
  for _,elem in pairs(cat_tb) do
    item_table.add(fnei.option_gui.get_img(elem.name, fnei.option_gui.get_item_style(player, elem.name)))
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