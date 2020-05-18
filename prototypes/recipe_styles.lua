-------------------------label_style-----------------------

data.raw["gui-style"].default["fnei_recipe_title_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "center",
    vertical_align = "center",
    font = "font-mb",
    height = 36,
    width = 311,
    font_color = { r=0, g=0.9, b=0 },
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_red_title_label"] =
{
    type = "label_style",
    parent = "fnei_recipe_title_label",
    font_color = { r=1, g=0.2537254, b=0.25980392 },
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_grey_title_label"] =
{
    type = "label_style",
    parent = "fnei_recipe_title_label",
    font_color = { r=0.5, g=0.5, b=0.5 },
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_madein_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "center",
    height = 36,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_technologies_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "center",
    height = 68,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_element_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "center",
    height = 32,
    top_padding = 0,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_type_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "right",
    height = 36,
    width = 182,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_paging_label"] =
{
    type = "label_style",
    parent = "label",
    horizontal_align = "left",
    height = 36,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_craft_time_for_building_label"] =
{
    type = "label_style",
    parent = "label",
    top_padding = 0,
    height = 20,
    minimal_width = 36,
    scalable = false,
}

-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_recipe_favorite_flow"] =
{
  type = "horizontal_flow_style",
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_arrow_flow"] =
{
  type = "horizontal_flow_style",
  top_padding = 0,
  left_padding = 0,
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_header_icon_flow"] =
{
  type = "horizontal_flow_style",
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_list_elements_flow"] =
{
  type = "horizontal_flow_style",
  minimal_height = 38,
  maximal_height = 38,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_building_flow"] =
{
  type = "vertical_flow_style",
  vertical_spacing = 0,
  scalable = false,
}

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_recipe_main_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 520,
  maximal_width = 520,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_header_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 508,
  maximal_width = 508,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_paging_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  left_padding = 7,
  minimal_width = 508,
  maximal_width = 508,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_ingr_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  width = 252,
  left_padding = 3,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_res_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  width = 252,
  left_padding = 3,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_list_ingr_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  left_padding = 3,
  width = 252,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_list_res_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  left_padding = 3,
  width = 252,
  scalable = false,
}

-------------------------table_style--------------------------

data.raw["gui-style"].default["fnei_recipe_main_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_header_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_paging_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  top_padding = 0,
  left_padding = 0,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_products_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_list_elements_table"] =
{
  type = "table_style",
  parent = "table",
  vertical_spacing = 2,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_made_in_table"] =
{
  type = "table_style",
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_tech_table"] =
{
  type = "table_style",
  scalable = false,
}

----------------------scroll_pane_style-----------------------

data.raw["gui-style"].default["fnei_recipe_products_scroll_pane"] =
{
  type = "scroll_pane_style",
  maximal_width = 240,
  minimal_width = 240,
  maximal_height = 330,
  vertical_align = "center",
  scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_recipe_red_tech_button"] = 
{
  type = "button_style",
  parent = "red_slot_button",
  height = 68,
  width = 68,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_green_tech_button"] = 
{
  type = "button_style",
  parent = "green_slot_button",
  height = 68,
  width = 68,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_yellow_tech_button"] = 
{
  type = "button_style",
  parent = "slot_button",

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      185,
      72
    },
    scale = 1,
    size = 36
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      111,
      72
    },
    scale = 1,
    size = 36
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      148,
      72
    },
    scale = 1,
    size = 36
  },
  
  height = 68,
  width = 68,
  scalable = false
}

data.raw["gui-style"].default["fnei_recipe_grey_tech_button"] = 
{
  type = "button_style",
  parent = "slot_button",

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      185,
      0
    },
    scale = 1,
    size = 36
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      111,
      0
    },
    scale = 1,
    size = 36
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    position = {
      148,
      0
    },
    scale = 1,
    size = 36
  },
  
  height = 68,
  width = 68,
  scalable = false
}

data.raw["gui-style"].default["fnei_recipe_favorive_button"] = 
{
  type = "button_style",
  parent = "slot_button",
  font = "font-mb",
  scalable = false,
  height = 36,
  width = 36,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/favorite_clicked.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/favorite.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/favorite_hovered.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_recipe_selected_favorive_button"] = 
{
  type = "button_style",
  parent = "slot_button",
  font = "font-mb",
  scalable = false,
  height = 36,
  width = 36,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/favorite_clicked.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/favorite_selected.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/favorite_hovered.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

------------------------empty_widget_style-------------------------

data.raw["gui-style"].default["fnei_recipe_header-drag-widget"] =
{
  type = "empty_widget_style",
  height = 36,
  width = 315,
  left_margin = -315,
  scalable = false,
}

-- data.raw["gui-style"].default["fnei_recipe_header-sprite-widget"] =
-- {
--   type = "empty_widget_style",
--   parent = "draggable_space",
--   height = 36,
--   width = 310,
--   scalable = false,
-- }