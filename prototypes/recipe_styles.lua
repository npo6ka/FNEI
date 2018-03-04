-------------------------label_style-----------------------

data.raw["gui-style"].default["fnei_red_recipe_title_label"] =
{
    type = "label_style",
    parent = "label",
    align = "center",
    font = "font-mb",
    height = 36,
    width = 348,
    want_ellipsis = true,
    font_color = { r=1, g=0.2537254, b=0.25980392 },
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_title_label"] =
{
    type = "label_style",
    parent = "label",
    align = "center",
    vertical_align = "center",
    font = "font-mb",
    height = 36,
    width = 348,
    want_ellipsis = true,
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
    align = "center",
    height = 36,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_technologies_label"] =
{
    type = "label_style",
    parent = "label",
    align = "center",
    height = 68,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_element_label"] =
{
    type = "label_style",
    parent = "label",
    align = "center",
    height = 32,
    top_padding = 0,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_type_label"] =
{
    type = "label_style",
    parent = "label",
    align = "right",
    height = 36,
    width = 182,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_paging_label"] =
{
    type = "label_style",
    parent = "label",
    align = "left",
    height = 36,
    width = 190,
    scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_craft_time_for_building_label"] =
{
    type = "label_style",
    parent = "label",
    top_padding = 0,
    height = 16,
    width = 36,
    scalable = false,
}

-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_recipe_flow"] =
{
  type = "horizontal_flow_style",
  minimal_width = 526,
  maximal_width = 526,
  minimal_height = 710,
  maximal_height = 710,
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
  left_padding = 3,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_res_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
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
  scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_recipe_red_tech_button"] = 
{
  type = "button_style",
  parent = "not_available_technology_slot",
  height = 68,
  width = 68,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_green_tech_button"] = 
{
  type = "button_style",
  parent = "researched_technology_slot",
  height = 68,
  width = 68,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_yellow_tech_button"] = 
{
  type = "button_style",
  parent = "available_technology_slot",
  height = 68,
  width = 68,
  scalable = false,
}

data.raw["gui-style"].default["fnei_recipe_grey_tech_button"] = 
{
  type = "button_style",
  parent = "technology_slot_button",
  height = 68,
  width = 68,
  scalable = false,
}