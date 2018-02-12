-------------------------Font style-----------------------

-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_main_genetal-flow"] =
{
  type = "horizontal_flow_style",
  minimal_width = 526,
  maximal_width = 526,
  minimal_height = 800,
  maximal_height = 800,
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

----------------------scroll_pane_style-----------------------

------------------------label_style-------------------------

data.raw["gui-style"].default["fnei_main_header-label"] =
{
  type = "label_style",
  font = "font-lb",
  width = 380,
  align = "center",
  scalable = false,
}

data.raw["gui-style"].default["fnei_main_tab-description-label"] =
{
  type = "label_style",
  width = 454,
  align = "center",
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