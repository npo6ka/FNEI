-------------------------flow_style--------------------------

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_hotbar_frame"] =
{
  type = "frame_style",
  top_padding = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0,
  title_top_padding = 0,
  title_right_padding = 0,
  title_bottom_padding = 0,
  title_left_padding = 0,
  scalable = false,
}

-------------------------table_style--------------------------

data.raw["gui-style"].default["fnei_hotbar_zero_spacing_table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  scalable = false,
}

-------------------------label_style--------------------------

data.raw["gui-style"].default["fnei_hotbar_label"] =
{
    type = "label_style",
    top_padding = 0,
    right_padding = 2,
    left_padding = 2,
    width = 72,
    height = 22,
    horizontal_align = "center",
    scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_hotbar_label_button"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 36,
  width = 72,
  font = "font-lb",
  scalable = false,
}

data.raw["gui-style"].default["fnei_hotbar_block_button"] = 
{
  type = "button_style",
  parent = "compact_slot",
  font = "font-mb",
  height = 36,
  width = 36,
  scalable = false,
}

data.raw["gui-style"].default["fnei_hotbar_down_arrow"] = 
{
  type = "button_style",
  parent = "compact_slot",
  font = "font-mb",
  scalable = false,
  height = 14,
  width = 78,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/down_hotbar_arrow_clicked.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/down_hotbar_arrow_default.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/down_hotbar_arrow_hovered.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  }
}

data.raw["gui-style"].default["fnei_hotbar_up_arrow"] = 
{
  type = "button_style",
  parent = "compact_slot",
  font = "font-mb",
  scalable = false,
  height = 14,
  width = 78,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/up_hotbar_arrow_clicked.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/up_hotbar_arrow_default.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/up_hotbar_arrow_hovered.png",
    height = 14,
    priority = "extra-high-no-scale",
    width = 72,
  }
}
