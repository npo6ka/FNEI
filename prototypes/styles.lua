data:extend({
  {
    type = "sprite",
    name = "fnei_time_icon",
    filename = "__core__/graphics/clock-icon.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
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
    size = 18
  }
})

-- green_slot_button_style
-- red_slot_button_style
-- selected_slot_button_style
-- technology_slot_button_style
-- not_available_slot_button_style


data.raw["gui-style"].default["fnei_red_recipe_title_label"] =
{
    type = "label_style",
    parent = "label_style",
    --width = 708,
    align = "center",
    font = "font-mb",
    scalable = false,
    font_color = {r=1, g=0.2537254, b=0.25980392}
}

data.raw["gui-style"].default["fnei_recipe_title_label"] =
{
    type = "label_style",
    parent = "label_style",
    --width = 708,
    align = "center",
    font = "font-mb",
    scalable = false,
}


data.raw["gui-style"].default["fnei_empty_slot_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
    
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 0
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 0
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 111,
      y = 0
    },
  }
}

data.raw["gui-style"].default["fnei_red_tech_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 68,
  width = 68,

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

data.raw["gui-style"].default["fnei_yellow_tech_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 68,
  width = 68,

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
      y = 72,
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
      y = 72,
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
      y = 72,
    },
  },
}

data.raw["gui-style"].default["fnei_green_tech_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 68,
  width = 68,

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

data.raw["gui-style"].default["fnei_scroll_recipe_style"] =
{
  type = "scroll_pane_style",
  maximal_width = 220,
  minimal_width = 220,

}

data.raw["gui-style"].default["fnei_empty_flow"] =
{
  type = "flow_style",
  maximal_width = 36 + 2,
  minimal_width = 36 + 2,
  maximal_height = 36 + 2,
  minimal_height = 36 + 2,
}