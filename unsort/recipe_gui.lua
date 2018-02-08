local RecipeGui  = {
  classname = "FNRecipeGui",
  name = "recipe",
}

local recipe_gui_template

function RecipeGui.init_template()
  local cont = Controller.get_cont(RecipeGui.name)

  recipe_gui_template = {
    { type = "flow", name = "main-flow", style = "fnei_recipe_flow", children = {
      { type = "frame", name = "main-frame", style = "fnei_recipe_main_frame", children = {
        { type = "table", name = "main-table", style = "fnei_recipe_main_table", column_count = 1, children = {

------------------ header ------------------

          { type = "frame", name = "header-frame", style = "fnei_recipe_header_frame", direction = "horizontal", children = {
            { type = "table", name = "header-table", style = "fnei_recipe_header_table", column_count = 5, children = {
              { type = "flow", name = "header-icon" },
              { type = "label", name = "header-label", style = "fnei_recipe_title_label", caption = "recipe_name" },
              { type = "sprite-button", name = "back-key", style = "fnei_back_button_style", tooltip = {"gui.cancel"}, event = Controller.back_key_event },
              { type = "sprite-button", name = "settings-key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"}, event = RecipeGui.settings_key_event },
              { type = "sprite-button", name = "exit-key", style = "fnei_exit_button_style", tooltip = {"gui.exit"}, event = Controller.main_key_event },
            }}
          }},

------------------ paging ------------------

          { type = "frame", name = "paging-frame", style = "fnei_recipe_paging_frame", children = {
            { type = "table", name = "paging-table", style = "fnei_recipe_paging_table", column_count = 5, children = {
              { type = "flow", name = "left-arrow-flow", style = "fnei_arrow_flow" },
              { type = "label", name = "type-label", style = "fnei_recipe_type_lable", caption = "something" },
              { type = "flow", name = "prot-icon", style = "fnei_arrow_flow" },
              { type = "label", name = "paging-label", style = "fnei_recipe_paging_label", caption = "page unknown" },
              { type = "flow", name = "right-arrow-flow", style = "fnei_arrow_flow" },
            }},
          }},

------------------ content ------------------
        
          { type = "table", name = "prod-table", style = "fnei_prod_table", column_count = 2, children = {
            { type = "frame", name = "ingr-frame", style = "fnei_recipe_ingr_frame", children = {
              { type = "label", name = "ingr-label", caption = {"fnei.ingredients"} },
            }},
            { type = "frame", name = "res-frame", style = "fnei_recipe_res_frame", children = {
              { type = "label", name = "res-label", caption = {"fnei.results"} },
            }},
            { type = "frame", name = "list-ingr-frame", style = "fnei_recipe_list_ingr_frame", children = {
              { type = "scroll-pane", name = "ingr-scroll", style = "fnei_scroll_recipe_style", direction = "vertical", children = {
                { type = "table", name = "list-ingr", style = "fnei_recipe_list_elements", column_count = 1 }
              }}
            }},
            { type = "frame", name = "list-res-frame", style = "fnei_recipe_list_res_frame", children = {
              { type = "scroll-pane", name = "res-scroll", style = "fnei_scroll_recipe_style", direction = "vertical", children = {
                { type = "table", name = "list-res", style = "fnei_recipe_list_elements", column_count = 1 }
              }}
            }},
          }},

------------------- madein --------------------

          { type = "frame", name = "madein-frame", style = "fnei_recipe_paging_frame", direction = "horizontal", children = {
            { type = "label", name = "madein-lable", style = "fnei_recipe_madein", caption = {"fnei.made-in"} },
            { type = "table", name = "madein-table", column_count = 5 }
          }},

        }}  
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

function RecipeGui.open_window()
  RecipeGui.close_window()

  return Gui.add_gui_template(Gui.get_pos(), recipe_gui_template)
end

function RecipeGui.close_window()
  if RecipeGui.is_gui_open() then
    Gui.get_gui(Gui.get_pos(), recipe_gui_template[1].name).destroy()
  end
end

function RecipeGui.set_recipe_time(energy)
  local time = Gui.get_gui(Gui.get_pos(), "fnei_time_label")
  time.caption = energy
end

function RecipeGui.set_recipe_name(recipe_name)
  local name = Gui.get_gui(Gui.get_pos(), "header-label")
  name.caption = recipe_name
end

function RecipeGui.set_recipe_icon(recipe)
  local icon_flow = Gui.get_gui(Gui.get_pos(), "header-icon")

  clear_gui(icon_flow)
  Gui.add_choose_button(icon_flow, { type = "choose-elem-button", name = "selected-recipe", elem_type = "recipe", elem_value = recipe.name, locked = true })
end

function RecipeGui.set_ingredients(list)
  local ingr_tb = Gui.get_gui(Gui.get_pos(), "list-ingr")
  local template = {}

  table.insert(template,  
    { type = "flow", name = "time-flow", style = "fnei_list_elements_flow", direction = "horizontal", children = {
      { type = "sprite-button", name = "fnei_time", style = "slot_button", tooltip = {"fnei.time"}, sprite = "fnei_time_icon" },
      { type = "label", name = "fnei_time_label", caption = "time"},
    }})
                  
  for _,ingr in pairs(list) do
    table.insert(template, { type = "flow", name = ingr.name .. "-flow", style = "fnei_list_elements_flow", direction = "horizontal", children = {
      { type = "choose-elem-button", name = ingr.type .. "-" .. ingr.name, elem_type = ingr.type, elem_value = ingr.name, locked = true },
      { type = "label", name = ingr.name .. "-label", style = "fnei_recipe_element", caption = RecipeGui.get_element_caption(ingr) }
    }})
  end
  
  clear_gui(ingr_tb)
  Gui.add_gui_template(ingr_tb, template)
end

function RecipeGui.set_products(list)
  local res_tb = Gui.get_gui(Gui.get_pos(), "list-res")
  local template = {}


  for _,res in pairs(list) do
    table.insert(template, { type = "flow", name = res.name .. "-flow", style = "fnei_list_elements_flow", direction = "horizontal", children = {
      { type = "choose-elem-button", name = res.type .. "-" .. res.name, elem_type = res.type, elem_value = res.name, locked = true },
      { type = "label",  name = res.name .. "-label", style = "fnei_recipe_element", caption = RecipeGui.get_element_caption(res) }
    }})
  end
  
  clear_gui(res_tb)
  Gui.add_gui_template(res_tb, template)
end

function RecipeGui.set_made_in_list(recipe)
  local gui_tabel = Gui.get_gui(Gui.get_pos(), "madein-table")
  local craft_cat_sett = Settings.get_val("show-recipes")
  local craft_cat_list = get_crafting_categories_list()

  clear_gui(gui_tabel)

  if craft_cat_sett.categories[recipe.category] then
    local cat_list = craft_cat_list[recipe.category]

    for _, cat in pairs(cat_list) do
      if cat.type == "player" then
        Gui.add_sprite_button(gui_tabel, { type = "sprite-button", name = cat.val.name,
                                     --style = CraftingBuildingsSett.get_building_style(settings, cat, item.val.name),
                                     tooltip = {"", {"fnei.handcraft"}},
                                     sprite = "fnei_hand_icon" })
      elseif cat.ingredient_count >= #recipe.ingredients and craft_cat_sett.buildings[cat.val.name] then
        Gui.add_choose_button(gui_tabel, { type = "choose-elem-button", name = cat.val.name, elem_type = "item", elem_value = cat.val.name, locked = true })
      end
    end
  end

end

function RecipeGui.set_techs(recipe)

end

function RecipeGui.set_crafting_type(action_type)
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

  Gui.add_choose_button(prot_flow, { type = "choose-elem-button", name = type .. "-" .. name, elem_type = type, elem_value = name, locked = true })
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
  end


  if element.amount then
    return {"fnei.recipe-amnt", element.amount, get_localised_name(prot) }
  else
    local min = element.amount_min or 0
    local max = element.amount_max or 0
    local prob = element.probability or 0
    local ret_val

    if not Settings.get_val("detail-chance") then
      return {"fnei.recipe-amnt", round((min + max) / 2 * prob, 3), get_localised_name(prot)}
    end

    if min ~= max then
      ret_val = {"fnei.recipe-amnt-range", min, max}
    else
      ret_val = max
    end
    if prob == 1 then
      return {"fnei.recipe-amnt", ret_val, get_localised_name(prot)}
    else
      return {"fnei.recipe-amnt-prob", {"fnei.recipe-amnt", ret_val, round(prob * 100, 3)}, get_localised_name(prot)}
    end
  end
end

function RecipeGui.draw_paging(page)
  local page_gui = Gui.get_gui(Gui.get_pos(), "paging-table")
  local label = Gui.get_gui(page_gui, "paging-label")
  local amnt = page:amount_page()

  page:draw_forward_arrow( Gui.get_gui(page_gui, "right-arrow-flow") )
  page:draw_back_arrow( Gui.get_gui(page_gui, "left-arrow-flow") )
  
  if amnt == 0 then amnt = 1 end
  label.caption = {"", {"fnei.page"}, ": " .. page:get_cur_page() .. "/".. amnt}
end

function RecipeGui.settings_key_event(event)
  Controller.open_event("settings")
end

return RecipeGui