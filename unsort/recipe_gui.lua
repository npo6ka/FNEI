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
              { type = "flow", name = "left-arrow-flow", style = "fnei_arrow_flow", children = {
                { type = "sprite-button", name = "left-key", style = "fnei_left_arrow_button_style", tooltip = {"fnei.previous-key"}, event = nil },
              }},
              { type = "label", name = "type-lable", style = "fnei_recipe_type_lable", caption = "something" },
              { type = "flow", name = "item-icon", style = "fnei_arrow_flow" },
              { type = "label", name = "paging-label", style = "fnei_recipe_paging_label", caption = "page unknown" },
              { type = "flow", name = "right-arrow-flow", style = "fnei_arrow_flow", children = {
                { type = "sprite-button", name = "right-key", style = "fnei_right_arrow_button_style", tooltip = {"fnei.next-key"}, event = nil },
              }},

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
                { type = "table", name = "list-ingr", style = "fnei_recipe_list_elements", column_count = 1, children = {
                  { type = "flow", name = "time-flow", style = "fnei_list_elements_flow", direction = "horizontal", children = {
                    { type = "sprite-button", name = "fnei_time", style = "slot_button", tooltip = {"fnei.time"}, sprite = "fnei_time_icon" },
                    { type = "label", name = "fnei_time_label", caption = "time"},
                  }}
                }}
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
            { type = "label", name = "madein-lable", style = "fnei_recipe_madein", caption = "something" },
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
  if icon_flow["selected-recipe"] and icon_flow["selected-recipe"].valid then icon_flow["selected-recipe"].destroy() end
  Gui.add_choose_button(icon_flow, { type = "choose-elem-button", name = "selected-recipe", elem_type = "recipe", elem_value = recipe.name, locked = true })
end

function RecipeGui.set_ingredients(list)
  local ingr_tb = Gui.get_gui(Gui.get_pos(), "list-ingr")
  local template = {}


  for _,ingr in pairs(list) do
    table.insert(template, { type = "flow", name = ingr.name .. "-flow", style = "fnei_list_elements_flow", direction = "horizontal", children = {
      { type = "choose-elem-button", name = ingr.type .. "-" .. ingr.name, elem_type = ingr.type, elem_value = ingr.name, locked = true },
      { type = "label", name = ingr.name .. "-label", style = "fnei_recipe_element", caption = RecipeGui.get_element_caption(ingr) }
    }})
  end
  
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
  
  Gui.add_gui_template(res_tb, template)
end

function RecipeGui.set_made_in_list()

end

function RecipeGui.set_techs()

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

function RecipeGui.add_header(parent)
  -- parent = Gui.addFrame(parent, RecipeGui.name, "header-frame", "fnei_recipe_header_frame", "horizontal")
  -- parent = Gui.addTable(parent, RecipeGui.name, "header-table", "fnei_recipe_header_table", 5)
  -- Gui.addFrame(parent, RecipeGui.name, "header-frame")
  -- Gui.addLabel(parent, RecipeGui.name, "header-label", "fnei_recipe_title_label", "recipe_name")
  -- Gui.addSpriteButton(parent, { name = "back-key", style = "fnei_back_button_style", tooltip = {"fnei.back-key"} },Controller.back_key_event)
  -- Gui.addSpriteButton(parent, { name = "settings-key", style = "fnei_settings_button_style", tooltip = {"fnei.settings-key"} }, RecipeGui.settings_key_event)
  -- Gui.addSpriteButton(parent, { name = "exit-key", style = "fnei_exit_button_style", tooltip = {"fnei.exit-key"} }, Controller.main_key_event)
end

function RecipeGui.settings_key_event(event)
  Controller.open_event("settings")
end

return RecipeGui