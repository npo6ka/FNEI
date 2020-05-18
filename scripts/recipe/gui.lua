local RecipeGui  = {
  classname = "FNRecipeGui",
  name = "recipe",
}

local recipe_gui_template

function RecipeGui.init_template()
  local cont = Controller.get_cont(RecipeGui.name)

  recipe_gui_template = {
    { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
      { type = "table", name = "main-table", style = "fnei_recipe_main_table", column_count = 1, children = {

------------------ header ------------------

        { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
          { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 8, children = {
            { type = "flow", name = "header-icon", style = "fnei_default_horizontal_flow" },
            { type = "label", name = "header-label", style = "fnei_recipe_title_label", align = "center", vertical_align = "center", caption = "recipe_name" },
            --{ type = "empty-widget", name = "" , style = "fnei_main_header-sprite-widget", caption = {"fnei.FNEI"} },
            { type = "empty-widget", name = "drag-widget", style = "fnei_recipe_header-drag-widget", drag_target = true},
            { type = "flow", name = "favorite-flow", style = "fnei_recipe_favorite_flow", children = { 
              { type = "sprite-button", name = "favorite-key", tooltip = {"fnei.favorite-button"}, event = cont.favorite_key_event },
            }},
            { type = "sprite-button", name = "back-key", style = "fnei_back_button_style", tooltip = {"gui.cancel"}, event = cont.back_key_event },
            { type = "sprite-button", name = "settings-key", style = "fnei_settings_button_style", tooltip = {"gui-menu.settings"}, event = cont.settings_key_event },
            { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
          }}
        }},

------------------ paging ------------------

        { type = "frame", name = "paging-frame", style = "fnei_recipe_paging_frame", children = {
          { type = "table", name = "paging-table", style = "fnei_recipe_paging_table", column_count = 5, children = {
            { type = "flow", name = "left-arrow-flow", style = "fnei_recipe_arrow_flow" },
            { type = "label", name = "type-label", style = "fnei_recipe_type_label", vertical_align = "center", align = "right", caption = "" },
            { type = "flow", name = "prot-icon", style = "fnei_recipe_header_icon_flow" },
            { type = "label", name = "paging-label", style = "fnei_recipe_paging_label", vertical_align = "center", align = "left", caption = "" },
            { type = "flow", name = "right-arrow-flow", style = "fnei_recipe_arrow_flow" },
          }},
        }},

------------------ content ------------------
      
        { type = "table", name = "prod-table", style = "fnei_recipe_products_table", column_count = 2, children = {
          { type = "frame", name = "ingr-frame", style = "fnei_recipe_ingr_frame", children = {
            { type = "label", name = "ingr-label", style = "fnei_default_label", caption = {"fnei.ingredients"} },
          }},
          { type = "frame", name = "res-frame", style = "fnei_recipe_res_frame", children = {
            { type = "label", name = "res-label", style = "fnei_default_label", caption = {"fnei.results"} },
          }},
          { type = "frame", name = "list-ingr-frame", style = "fnei_recipe_list_ingr_frame", children = {
            { type = "scroll-pane", name = "ingr-scroll", style = "fnei_recipe_products_scroll_pane", direction = "vertical", children = {
              { type = "table", name = "list-ingr", style = "fnei_recipe_list_elements_table", column_count = 1 }
            }}
          }},
          { type = "frame", name = "list-res-frame", style = "fnei_recipe_list_res_frame", children = {
            { type = "scroll-pane", name = "res-scroll", style = "fnei_recipe_products_scroll_pane", direction = "vertical", children = {
              { type = "table", name = "list-res", style = "fnei_recipe_list_elements_table", column_count = 1 }
            }}
          }},
        }},

------------------- madein --------------------

        { type = "frame", name = "madein-frame", style = "fnei_recipe_paging_frame", direction = "horizontal", children = {
          { type = "label", name = "madein-lable", style = "fnei_recipe_madein_label", caption = {"fnei.made-in"} },
          { type = "table", name = "madein-table", style = "fnei_recipe_made_in_table", column_count = 7 }
        }},

------------------- techs --------------------

        { type = "flow", name = "tech-flow", style = "fnei_default_horizontal_flow" },

      }}  
    }}
  }
end

function RecipeGui.init_events()
  RecipeGui.init_template()
  Events.init_temp_events(RecipeGui.name, recipe_gui_template)
end


function RecipeGui.is_gui_open()
  local val = Gui.get_gui(Gui.get_pos(), recipe_gui_template[1].name)
  if val and next(val) and val.valid then
    return true
  else
    return false
  end
end

function RecipeGui.open_window(loc)
  loc = RecipeGui.close_window() or loc
  local gui = Gui.add_gui_template(Gui.get_pos(), recipe_gui_template)
  gui.location = loc
  return gui
end

function RecipeGui.close_window()
  if RecipeGui.is_gui_open() then
    local gui = Gui.get_gui(Gui.get_pos(), recipe_gui_template[1].name)
    local loc = gui.location 
    gui.destroy()
    return loc
  end
end

function RecipeGui.draw_favorite_state(state)
  local favorite_button = Gui.get_gui(Gui.get_pos(), "favorite-flow")

  if favorite_button and favorite_button.valid then
    local style = (state and "fnei_recipe_selected_favorive_button") or "fnei_recipe_favorive_button"

    clear_gui(favorite_button)
    Gui.add_gui_template(favorite_button, {{ 
      type = "sprite-button",
      name = "favorite-key",
      style = style,
      tooltip = {"fnei.favorite-button"},
    }})
  end
end

function RecipeGui.set_recipe_time(energy)
  local time = Gui.get_gui(Gui.get_pos(), "fnei_time_label")
  time.caption = energy
end

function RecipeGui.set_recipe_name(recipe)
  local name = Gui.get_gui(Gui.get_pos(), "header-label")
  name.caption = get_localised_name( recipe )
  name.tooltip = name.caption

  local style = "fnei_recipe_title_label"
  
  if recipe and recipe.hidden then
    style = "fnei_recipe_grey_title_label"
  elseif recipe and not recipe.enabled then
    style = "fnei_recipe_red_title_label"
  end

  name.style = style
end

function RecipeGui.set_recipe_icon(recipe)
  local icon_flow = Gui.get_gui(Gui.get_pos(), "header-icon")
  local value = recipe.name
  local type = "recipe"

  if rawget(recipe, 'impostor') then
    local _,pos = string.find(value, "impostor[-]minable:")

    if not pos then 
      _,pos = string.find(value, "impostor[-]pumped:")
    end

    value = string.sub(value, (pos or -1) + 1)
    type = "entity"
  end

  clear_gui(icon_flow)
  Gui.add_choose_button(icon_flow, { type = "choose-elem-button", name = "selected-recipe", style = "fnei_default_button", elem_type = type, elem_value = value, locked = true })
end

function RecipeGui.set_ingredients(list, dif_prot)
  local ingr_tb = Gui.get_gui(Gui.get_pos(), "list-ingr")
  local template = {}

  table.insert(template,  
    { type = "flow", name = "time-flow", style = "fnei_recipe_list_elements_flow", direction = "horizontal", children = {
      { type = "sprite-button", name = "fnei_time", style = "slot_button", tooltip = {"fnei.crafting-time"}, sprite = "fnei_time_icon" },
      { type = "label", name = "fnei_time_label", style = "fnei_recipe_element_label", vertical_align = "center", align = "left", caption = {"fnei.crafting-time"} },
    }})
                  
  for _,ingr in pairs(list) do
    table.insert(template, { type = "flow", name = ingr.name .. "-flow", style = "fnei_recipe_list_elements_flow", direction = "horizontal", children = {
      { type = "choose-elem-button", name = ingr.type .. "_" .. ingr.name, style = "fnei_default_button", elem_type = ingr.type, elem_value = ingr.name, locked = true },
      { type = "label", name = ingr.name .. "-label", style = "fnei_recipe_element_label", single_line = true, vertical_align = "center", align = "left", caption = RecipeGui.get_element_caption(ingr) }
    }})
  end

  local scroll = Gui.get_gui(Gui.get_pos(), "ingr-scroll") or {}
  if list and #list < 7 then
    scroll.vertical_scroll_policy = "never"
  else
    scroll.vertical_scroll_policy = "auto"
  end

  for i = 1, dif_prot do
    table.insert(template, { type = "flow", name = "empty_flow" .. i, style = "fnei_recipe_list_elements_flow" })
  end
  
  clear_gui(ingr_tb)
  Gui.add_gui_template(ingr_tb, template)
end

function RecipeGui.set_products(list, dif_prot)
  local res_tb = Gui.get_gui(Gui.get_pos(), "list-res")
  local template = {}

  for _,res in pairs(list) do
    table.insert(template, { type = "flow", name = res.name .. "-flow", style = "fnei_recipe_list_elements_flow", direction = "horizontal", children = {
      { type = "choose-elem-button", name = res.type .. "_" .. res.name, style = "fnei_default_button", elem_type = res.type, elem_value = res.name, locked = true },
      { type = "label",  name = res.name .. "-label", style = "fnei_recipe_element_label", single_line = true, vertical_align = "center", align = "left", caption = RecipeGui.get_element_caption(res) }
    }})
  end

  local scroll = Gui.get_gui(Gui.get_pos(), "res-scroll") or {}
  if list and #list < 8 then
    scroll.vertical_scroll_policy = "never"
  else
    scroll.vertical_scroll_policy = "auto"
  end

  for i = 1, dif_prot do
    table.insert(template, { type = "flow", name = "empty_flow" .. i, style = "fnei_recipe_list_elements_flow" })
  end
  
  clear_gui(res_tb)
  Gui.add_gui_template(res_tb, template)
end

function RecipeGui.set_made_in_list(recipe)
  local gui_tabel = Gui.get_gui(Gui.get_pos(), "madein-table")
  local craft_cat_list = get_crafting_categories_list()
  local item_list = get_full_item_list()

  clear_gui(gui_tabel)

  if recipe and Settings.get_val("show-recipes", "categories", recipe.category) then
    local cat_list = craft_cat_list[recipe.category]

    for _, cat in pairs(cat_list) do
      local caption = Settings.get_val("show-craft-time-label")
      local element

      if cat.type == "player" and Settings.get_val("show-recipes", "buildings", cat.val.name) then
        local player = Player.get()

        if caption and player and player.character_crafting_speed_modifier + player.force.manual_crafting_speed_modifier + 1 ~= 0 then
          caption = round(recipe.energy / ((player.character_crafting_speed_modifier + 1) * (player.force.manual_crafting_speed_modifier + 1)), 3)
        end

        element = { type = "sprite-button",
                    name = cat.val.name,
                    style = "fnei_default_button",
                    tooltip = {"", {"fnei.handcraft"}},
                    sprite = "fnei_hand_icon"
                  }
      elseif cat.type == "building" and cat.ingredient_count and Settings.get_val("show-recipes", "buildings", cat.val.name) then
        local ing_cnt = 0
        local in_fluidbox_cnt = 0
        local out_fluidbox_cnt = 0

        for _,prot in pairs(recipe.ingredients) do
          if prot.type == "item" then
            ing_cnt = ing_cnt + 1
          elseif prot.type == "fluid" then
            in_fluidbox_cnt = in_fluidbox_cnt + 1
          end
        end

        for _,prot in pairs(recipe.products) do
          if prot.type == "fluid" then
            out_fluidbox_cnt = out_fluidbox_cnt + 1
          end
        end

        if cat.ingredient_count >= ing_cnt and in_fluidbox_cnt <= (cat.ifbox or 0) and out_fluidbox_cnt <= (cat.ofbox or 0) then
          local entity = item_list[cat.val.name].place_result

          if caption and entity and entity.crafting_speed ~= nil then
            caption = round(recipe.energy / entity.crafting_speed, 3)
          end

          if caption and entity and entity.pumping_speed then
            caption = round(recipe.energy / entity.pumping_speed, 3)
          end

          element = { 
            type = "choose-elem-button",
            name = "item_" .. cat.val.name,
            style = "fnei_default_button",
            elem_type = "item",
            elem_value = cat.val.name,
            locked = true
          }
        end
      elseif cat.type == 'resource-miner' and cat.mining_speed and Settings.get_val("show-recipes", "buildings", cat.val.name) then
        element = {
          type = "choose-elem-button",
          name = "item_" .. cat.val.name,
          style = "fnei_default_button",
          elem_type = "item",
          elem_value = cat.val.name,
          locked = true
        }
        -- https://wiki.factorio.com/Mining
        caption = round(recipe.mining_time / (cat.mining_speed), 3)
      end

      if element then
        local label

        if caption then
          label = { 
            type = "label", 
            name = cat.val.name .. "-label", 
            style = "fnei_recipe_craft_time_for_building_label", 
            vertical_align = "top", 
            align = "center",
            caption = caption,
            tooltip = {"", {"fnei.craft-time-in-building"}, ": ", caption} 
          }
        end

        Gui.add_gui_template(gui_tabel, {
          { type = "flow", name = cat.val.name .. "-flow", style = "fnei_recipe_building_flow", direction = "vertical", children = {
            element,
            label
          }}
        })
      end
    end
  end

end

function RecipeGui.set_techs( recipe )
  local tech_list = get_technologies_for_recipe(recipe.name)
  local gui_flow = Gui.get_gui(Gui.get_pos(), "tech-flow")

  clear_gui(gui_flow)

  local new_tech_list = {}
  if Settings.get_val("open-unavailable-techs") then
    new_tech_list = tech_list
  else
    for _, tech in pairs(tech_list) do
      if is_attainable_tech(tech) then
        table.insert(new_tech_list, tech)
      end
    end
  end

  if new_tech_list and #new_tech_list > 0 then
    local techs = {}

    for _, tech in pairs(new_tech_list) do
      table.insert(techs, {
        type = "sprite-button",
        name = "tech_".. tech.name,
        style = RecipeGui.get_tech_style( tech ),
        tooltip = get_localised_name(tech),
        sprite = "technology/" .. tech.name
      })
    end

    local template = {
      { type = "frame", name = "tech-frame", style = "fnei_recipe_paging_frame", direction = "horizontal", children = {
        { type = "label", name = "tech-label", style = "fnei_recipe_technologies_label", caption = {"fnei.technology"} },
        { type = "table", name = "tach-table", style = "fnei_recipe_tech_table", column_count = 3, children = techs },
      }}
    }

    Gui.add_gui_template(gui_flow, template)
  end
end

function RecipeGui.get_tech_style( tech )
  if not is_attainable_tech(tech) then
    return "fnei_recipe_grey_tech_button"
  elseif tech.researched then
    return "fnei_recipe_green_tech_button"
  else
    local preq = tech.prerequisites
    for _,tec in pairs(preq) do
      if tec and not tec.researched then
        return "fnei_recipe_red_tech_button"
      end
    end
    return "fnei_recipe_yellow_tech_button"
  end
end

function RecipeGui.set_crafting_type( action_type )
  local label = Gui.get_gui(Gui.get_pos(), "type-label")

  if action_type == "usage" then
    label.caption = {"fnei.usage-for"}
  elseif action_type == "craft" then
    label.caption = {"fnei.recipe-for"}
  else
    label.caption = "unknown "
  end
end

function RecipeGui.draw_cur_prot(type, name)
  local prot_flow = Gui.get_gui(Gui.get_pos(), "prot-icon")
  clear_gui(prot_flow)
  if name then
    Gui.add_choose_button(prot_flow, { type = "choose-elem-button", name = type .. "_" .. name, style = "fnei_default_button", elem_type = type, elem_value = name, locked = true })
  end
end

function RecipeGui.get_element_caption(element)
  if not element then
    return "unknown name"
  end

  local prot
  if element.type == "item" then
    prot = get_full_item_list()[element.name]
  elseif element.type == "fluid" then
    prot = get_fluid_list()[element.name]
  elseif element.type == 'entity' then
    prot = game.entity_prototypes[element.name]
  end

  local loc_str = nil
  local prob = element.probability
  local amnt = element.amount


  if not Settings.get_val("detail-chance") and prob ~= nil then
    if element.amount then
      loc_str = round(element.amount * prob, 3)
    else
      local min = element.amount_min or 0
      local max = element.amount_max or 0

      loc_str = round((min + max) / 2 * prob, 3)
    end

    loc_str = {"", loc_str, " × ", get_localised_name(prot)}
  else 
    -- get amoutn for product

    if amnt ~= nil then
        loc_str = element.amount
    else
      local min = element.amount_min or 0
      local max = element.amount_max or 0

      if not Settings.get_val("detail-chance") and prob ~= nil then
        loc_str = round((min + max) / 2 * prob, 3)
      else
        if min == max then
            loc_str = max
        else
          loc_str = {"", "[" ..  min .. " - " .. max .. "]"}
        end
      end
    end

    -- if not single output then add " × "

    if loc_str ~= 1 or prob == nil or prob == 1 then
      loc_str = {"", loc_str, " × "}
    else
      loc_str = ""
    end

    -- add probability for product if exists

    if prob ~= nil and prob ~= 1 then
      loc_str = {"", loc_str, "" .. round(prob * 100, 3) .. "% "}
    end

    -- add localised name

    loc_str = {"", loc_str, get_localised_name(prot)}
  end

  -- add temperature for fluid

  if element.type == "fluid" and element.temperature and Settings.get_val("show-temperature-of-fluids") then
    loc_str = {"", loc_str, " (" .. element.temperature .. "°)"}
  end

  return loc_str
end

function RecipeGui.draw_paging(page)
  local page_gui = Gui.get_gui(Gui.get_pos(), "paging-table")
  local label = Gui.get_gui(page_gui, "paging-label")
  local amnt = page:amount_page()

  local arrow = Gui.get_gui(page_gui, "right-arrow-flow")
  if arrow and arrow.style then
    page:draw_forward_arrow( arrow )
    arrow.style.vertical_align = "center"
  end

  local arrow = Gui.get_gui(page_gui, "left-arrow-flow")
  if arrow and arrow.style then
    page:draw_back_arrow( arrow )
    arrow.style.vertical_align = "center"
  end
  
  if amnt == 0 then amnt = 1 end
  label.caption = {"", {"fnei.page"}, ": " .. page:get_cur_page() .. "/".. amnt}
end

return RecipeGui