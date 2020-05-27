data:extend({
--sprite
  {
    type = "sprite",
    name = "fnei_time_icon",
    filename = "__core__/graphics/clock-icon.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_hand_icon",
    filename = "__core__/graphics/hand.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_favorite_icon",
    filename = "__FNEI__/graphics/favorite_icon.png",
    priority = "extra-high-no-scale",
    width = 64,
    height = 64,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_last_usage_icon",
    filename = "__FNEI__/graphics/last_usage_icon.png",
    priority = "extra-high-no-scale",
    width = 64,
    height = 64,
    scale = 1,
  },

--Fonts
  {
    type = "font",
    name = "font-s",
    from = "default",
    size = 12
  },
  {
    type = "font",
    name = "font-m",
    from = "default",
    size = 15
  },
  {
    type = "font",
    name = "font-l",
    from = "default",
    size = 18
  },
  {
    type = "font",
    name = "font-sb",
    from = "default-semibold",
    size = 12
  },
  {
    type = "font",
    name = "font-mb",
    from = "default-semibold",
    size = 15
  },
  {
    type = "font",
    name = "font-lb",
    from = "default-semibold",
    size = 17
  }
})

-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_default_vertical_flow"] =
{
  type = "vertical_flow_style",
  scalable = false,
}

data.raw["gui-style"].default["fnei_default_horizontal_flow"] =
{
  type = "horizontal_flow_style",
  scalable = false,
}

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_default_frame"] =
{
  type = "frame_style",
  top_padding = 3,
  right_padding = 3,
  bottom_padding = 3,
  left_padding = 3,
  resize_row_to_width = true,
  resize_to_row_height = true,
  title_top_padding = 0,
  title_right_padding = 0,
  title_bottom_padding = 0,
  title_left_padding = 0,
  font_color = { r = 1, g = 0, b = 0, a = 1 },
  scalable = false,
}

-------------------------table_style--------------------------

data.raw["gui-style"].default["fnei_default_table"] =
{
  type = "table_style",
  top_padding = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0,
  cell_padding = 0,
  horizontal_spacing = 4,
  vertical_spacing = 4,
  scalable = false,
}

-------------------------label_style--------------------------

data.raw["gui-style"].default["fnei_default_label"] =
{
    type = "label_style",
    scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_default_button"] = 
{
  type = "button_style",
  parent = "compact_slot",
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_button_style"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/Settings_3.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/Settings_1.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/Settings_2.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_exit_button_style"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/Exit_3.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/Exit_1.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/Exit_2.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_back_button_style"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/Back_3.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/Back_1.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/Back_2.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_left_arrow_button_style"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 28,
  width = 28,
  scalable = false,
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/prev_3.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/prev_1.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/prev_2.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_right_arrow_button_style"] = 
{
  type = "button_style",
  parent = "compact_slot",
  height = 28,
  width = 28,
  scalable = false,
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/next_3.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/next_1.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/next_2.png",
    height = 64,
    priority = "extra-high-no-scale",
    width = 64,
  }
}

data.raw["gui-style"].default["fnei_default_empty-tab"] = 
{
  type = "button_style",
  parent = "compact_slot",
  font = "font-mb",
  scalable = false,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/selected_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/default_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/hovered_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  }
}

data.raw["gui-style"].default["fnei_default_selected-tab"] = 
{
  type = "button_style",
  parent = "compact_slot",
  font = "font-mb",
  scalable = false,
    
  clicked_graphical_set = {
    filename = "__FNEI__/graphics/selected_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  },
  default_graphical_set = {
    filename = "__FNEI__/graphics/selected_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  },
  hovered_graphical_set = {
    filename = "__FNEI__/graphics/hovered_tab.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 169,
  }
}
