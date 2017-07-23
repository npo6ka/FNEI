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
  {
    type = "sprite",
    name = "fnei_back_key",
    filename = "__FNEI__/graphics/back_32.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_settings_key",
    filename = "__FNEI__/graphics/settings_32.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_exit_key",
    filename = "__FNEI__/graphics/quit_32.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_left_key",
    filename = "__FNEI__/graphics/prev_32.png",
    priority = "extra-high-no-scale",
    width = 32,
    height = 32,
    scale = 1,
  },
  {
    type = "sprite",
    name = "fnei_right_key",
    filename = "__FNEI__/graphics/next_32.png",
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

-------------------------Font style-----------------------
data.raw["gui-style"].default["fnei_red_recipe_title_label"] =
{
    type = "label_style",
    parent = "label_style",
    --width = 708,
    align = "center",
    font = "font-mb",
    scalable = false,
    height = 36,
    width = 276,
    font_color = {r=1, g=0.2537254, b=0.25980392}
}
data.raw["gui-style"].default["fnei_recipe_title_label"] =
{
    type = "label_style",
    parent = "label_style",
    align = "center",
    font = "font-mb",
    scalable = false,
    height = 36,
    width = 276
}
data.raw["gui-style"].default["fnei_recipe_element"] =
{
    type = "label_style",
    parent = "label_style",
    align = "center",
    scalable = false,
    height = 36,
}
data.raw["gui-style"].default["fnei_recipe_type"] =
{
    type = "label_style",
    parent = "label_style",
    align = "right",
    scalable = false,
    height = 36,
    width = 165,
}
data.raw["gui-style"].default["fnei_recipe_paging"] =
{
    type = "label_style",
    parent = "label_style",
    align = "left",
    scalable = false,
    height = 36,
    width = 165,
}
data.raw["gui-style"].default["fnei_recipe_madein"] =
{
    type = "label_style",
    parent = "label_style",
    align = "center",
    scalable = false,
    height = 36,
    width = 190,
}
data.raw["gui-style"].default["fnei_recipe_technologies"] =
{
    type = "label_style",
    parent = "label_style",
    align = "center",
    scalable = false,
    height = 68,
    width = 190,
}

------------------------button_style-------------------------
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
data.raw["gui-style"].default["fnei_empty_button_style"] = 
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
      x = 75,
      y = 144
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 75,
      y = 144
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__core__/graphics/gui.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 36,
      x = 75,
      y = 144
    },
  }
}

data.raw["gui-style"].default["fnei_left_arrow_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 28,
  width = 28,

  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/prev_click_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/prev_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/prev_sel_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  }
}

data.raw["gui-style"].default["fnei_right_arrow_button_style"] = 
{
  type = "button_style",
  parent = "slot_button_style",
  height = 28,
  width = 28,

  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/next_click_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/next_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/next_sel_32.png",
      height = 32,
      priority = "extra-high-no-scale",
      width = 32,
    },
  }
}

----------------------scroll_pane_style-----------------------
data.raw["gui-style"].default["fnei_scroll_recipe_style"] =
{
  type = "scroll_pane_style",
  maximal_width = 220,
  minimal_width = 220,
  maximal_height = 330,
}


-------------------------flow_style--------------------------
data.raw["gui-style"].default["fnei_list_elements_flow"] =
{
  type = "flow_style",
  minimal_height = 38,
  maximal_height = 38,
}
data.raw["gui-style"].default["fnei_recipe_flow"] =
{
  type = "flow_style",
  minimal_width = 526,
  maximal_width = 526,
  minimal_height = 710,
  maximal_height = 710,

}
data.raw["gui-style"].default["fnei_arrow_flow"] =
{
  type = "flow_style",
  height = 36,
  top_padding = 7,
}


-------------------------frame_style--------------------------



-------------------------table_style--------------------------
data.raw["gui-style"].default["fnei_list_elements"] =
{
  type = "table_style",
  parent = "table_style",
  vertical_spacing = 2,
}
