local CraftingBuildingsSett = {
  classname = "FNCraftingBuildingsSett",
}

local cat_text = "cat"
local buildings = "buildings"
local categoties = "categoties"

function CraftingBuildingsSett.get_val(setting)
  local global_set = Settings.get_global_sett()

  if not global_set[setting.name] then global_set[setting.name] = {} end
  global_set = global_set[setting.name]

  if not global_set[categoties] then
    local craft_tb = get_crafting_category()

    global_set[categoties] = {}
    for cat, items in pairs(craft_tb) do
      global_set[categoties][cat] = setting.def_val
    end
  end

  if not global_set[buildings] then 
    local craft_tb = get_crafting_category()

    global_set[buildings] = {}
    for cat, items in pairs(craft_tb) do
      for _, item in pairs(items) do
        global_set[buildings][item.name] = setting.def_val
      end
    end
  end

  return global_set
end

function CraftingBuildingsSett.set_val(setting, val)
  local gl_sett = CraftingBuildingsSett.get_val(setting)

  if gl_sett[val.type] and gl_sett[val.type][val.name] ~= nil then
    gl_sett[val.type][val.name] = not gl_sett[val.type][val.name]
  end
end

function CraftingBuildingsSett.add_label_func(parent, sett) end

function CraftingBuildingsSett.add_content_func(parent, sett)
  local settings = CraftingBuildingsSett.get_val(sett)
  local craft_tb = get_crafting_category()
  local gui_template = {}

  for cat, items in pairs(craft_tb) do
    local flow_childer = {}

    table.insert(flow_childer, { type = "sprite-button", name = sett.name .. "_" .. cat_text .. "_" .. cat .. "_but", 
                                 style = CraftingBuildingsSett.get_category_style(settings[categoties], cat), tooltip = cat, children = 
    {
      { type = "label", name = sett.name .. "_cat_" .. cat .. "_lable", single_line = false, caption = cat, tooltip = cat }
    }})

    for _, item in pairs(items) do
      table.insert(flow_childer, { type = "sprite-button", name = sett.name .. "_" .. cat .. "_" .. item.name,  
                                   style = CraftingBuildingsSett.get_building_style(settings, cat, item.name),
                                   tip = {"", Gui.get_local_name(item), "\n", {"fnei.left-eneble-click"}, "\n", {"fnei.right-disable-click"}},
                                   sprite = "item/"..item.name,
      })
    end

    table.insert(gui_template, { type = "flow", name = sett.name .. cat, direction = "horizontal", children = flow_childer })
  end

  gui_template = {
    { type = "table", name = sett.name .."-table", column_count = 1, children = {
      { type = "label", name = "header-label-2", style = "fnei_option_label", caption = "mnogo razlichnoi infi blablablabla bla blabla bla bla blabla vb l a bl a b l a b l a b l a b l a b l a b l a" },
      { type = "scroll-pane", name = sett.name .. "-scroll-pane", style = "fnei_option_param_3_scroll", children = {
        { type = "table", name = sett.name .. "-table", column_count = 1, children = gui_template }
      }}
    }}
  }

  Gui.add_gui_template(parent, gui_template)
end

function CraftingBuildingsSett.change_content_style(sett_name)
  local settings = Settings.get_val(sett_name)
  local craft_tb = get_crafting_category()
  local parent = Gui.get_gui(Gui.get_pos(), sett_name .. "-table")
  local gui

  for cat, items in pairs(craft_tb) do
    gui = Gui.get_gui(parent, sett_name .. "_" .. cat_text .. "_" .. cat .. "_but")

    if gui then
      gui.style = CraftingBuildingsSett.get_category_style(settings[categoties], cat)
    end

    for _, item in pairs(items) do
      gui = Gui.get_gui(parent, sett_name .. "_" .. cat .. "_" .. item.name)

      if gui then 
        gui.style = CraftingBuildingsSett.get_building_style(settings, cat, item.name)
      end
    end
  end
end

function CraftingBuildingsSett.event(event, sett_name)
  local name = event.element.name or ""
  local gui_elem = {}

  for k in string.gmatch(name, "[^_]+") do
    table.insert(gui_elem, k)
  end
  
  if gui_elem[4] == cat_text then
    Settings.set_val(sett_name, {type = categoties, name = gui_elem[5]})
  else
    Settings.set_val(sett_name, {type = buildings, name = gui_elem[5]})
  end

  CraftingBuildingsSett.change_content_style(sett_name)
end

function CraftingBuildingsSett.event_init(sett)
  local event = sett.event or CraftingBuildingsSett.event
  Events.add_custom_event(Controller.get_cont("settings").get_name(), "sprite-button", sett.name, event)
  Events.add_custom_event(Controller.get_cont("settings").get_name(), "label", sett.name, event)
end

function CraftingBuildingsSett.get_building_style(settings, cat, item_name)



  if  not settings[buildings][item_name] then
    return "fnei_disable_building_button_style"
  elseif settings[categoties][cat] then
    return "fnei_enabled_building_button_style"
  else
    return "fnei_hide_building_button_style"
  end
end

function CraftingBuildingsSett.get_category_style(settings, cat_name)
  if settings[cat_name] then
    return "fnei_enable_category_button_style"
  else
    return "fnei_disable_category_button_style"
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