
-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_main_content_flow"] =
{
  type = "horizontal_flow_style",
  horizontal_spacing = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_selection_flow"] =
{
  type = "horizontal_flow_style",
  horizontal_spacing = 4,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_choose_flow"] =
{
  type = "horizontal_flow_style",
  top_padding = 6,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_element_flow"] =
{
  type = "vertical_flow_style",
  width = 230,
  scalable = false,
}

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_main_frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 478,
  maximal_width = 478,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_content-frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 466,
  maximal_width = 466,
  scalable = false,
}

-------------------------table_style--------------------------

data.raw["gui-style"].default["fnei_main_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_header-table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_fnei_content_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 2,
  vertical_spacing = 2,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_content_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 4,
  vertical_spacing = 2,
  scalable = false,
}

----------------------scroll_pane_style-----------------------

------------------------label_style-------------------------

data.raw["gui-style"].default["fnei_main_header-label"] =
{
  type = "label_style",
  font = "font-lb",
  font_color = {r = 255, g = 230, b = 192},
  width = 50,
  horizontal_align = "center",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_prot_label"] =
{
  type = "label_style",
  font = "font-mb",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_tab-description-label"] =
{
  type = "label_style",
  width = 454,
  horizontal_align = "center",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_search_label"] =
{
  type = "label_style",
  width = 300,
  top_padding = 3,
  horizontal_align = "right",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_page_label"] =
{
  type = "label_style",
  width = 396,
  top_padding = 3,
  horizontal_align = "center",
  scalable = false,
}

-------------------------text_field_style--------------------------

data.raw["gui-style"].default["fnei_main_search_field"] =
{
  type = "textbox_style",
  parent = "textbox",
  width = 152,
  scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_main_empty-tab"] = 
{
  type = "button_style",
  parent = "fnei_default_empty-tab",
  height = 36,
  width = 229,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_selected-tab"] = 
{
  type = "button_style",
  parent = "fnei_default_selected-tab",
  height = 36,
  width = 229,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_red_slot_button"] = 
{
  type = "button_style",
  parent = "red_slot_button",
  height = 36,
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_grey_slot_button"] = {
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_search_slot_button"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 48,
  width = 48,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_default_button"] = 
{
  type = "button_style",
  height = 32,
  width = 130,
  top_padding = 0,
  font = "font-mb",
  scalable = false,
}

------------------------empty_widget_style-------------------------

data.raw["gui-style"].default["fnei_main_header-drag-widget"] =
{
  type = "empty_widget_style",
  height = 36,
  width = 380,
  left_margin = -380,
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_header-sprite-widget"] =
{
  type = "empty_widget_style",
  parent = "draggable_space",
  height = 36,
  width = 310,
  scalable = false,
}