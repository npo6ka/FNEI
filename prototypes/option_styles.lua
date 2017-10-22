-------------------------Font style-----------------------

-------------------------flow_style--------------------------

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_option_text_frame"] =
{
  type = "frame_style",
  maximal_width = 270,
  minimal_width = 270,

  scalable = false,
}

-------------------------table_style--------------------------

----------------------scroll_pane_style-----------------------

data.raw["gui-style"].default["fnei_option_param_3_scroll"] =
{
  type = "scroll_pane_style",
  maximal_width = 232,
  minimal_width = 232,
  maximal_height = 120,
  scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_red_building_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 36,
  width = 36,

  clicked_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 36,
    },
  },
  default_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 36,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 36,
    },
  },
}

data.raw["gui-style"].default["fnei_green_building_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 36,
  width = 36,

  clicked_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 108,
    },
  },
  default_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 108,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    bottom_monolith_border = 1,
    left_monolith_border = 1,
    right_monolith_border = 1,
    top_monolith_border = 1,
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 108,
    },
  },
}

------------------------label_style-------------------------

data.raw["gui-style"].default["fnei_option_param_label"] =
{
  type = "label_style",
  maximal_width = 260,
  left_padding = 1,
  right_padding = 1,
  top_padding = 1,
  bottom_padding = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_option_label"] =
{
  type = "label_style",
  font = "font-mb",
  width = 400,
  align = "center",
  scalable = false,
}