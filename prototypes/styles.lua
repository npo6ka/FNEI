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


------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_empty_slot_button_style"] = 
{
  type = "button_style",
  parent = "slot_button",
    
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

data.raw["gui-style"].default["fnei_default_empty-tab"] = 
{
  type = "button_style",
  parent = "slot_button",
  font = "font-mb",
  scalable = false,
    
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/selected_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/default_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/hovered_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  }
}

data.raw["gui-style"].default["fnei_default_selected-tab"] = 
{
  type = "button_style",
  parent = "slot_button",
  font = "font-mb",
  scalable = false,
    
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/selected_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/selected_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/hovered_tab.png",
      height = 36,
      priority = "extra-high-no-scale",
      width = 169,
    },
  }
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

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_empty_button_style"] = 
{
  type = "button_style",
  parent = "slot_button",
  scalable = false, 
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

data.raw["gui-style"].default["fnei_settings_button_style"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Settings_3.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Settings_1.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Settings_2.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  }
}

data.raw["gui-style"].default["fnei_exit_button_style"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Exit_3.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Exit_1.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Exit_2.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  }
}

data.raw["gui-style"].default["fnei_back_button_style"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,
  clicked_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Back_3.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  default_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Back_1.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  },
  hovered_graphical_set = {
    type = "monolith",
    monolith_image = {
      filename = "__FNEI__/graphics/Back_2.png",
      height = 64,
      priority = "extra-high-no-scale",
      width = 64,
    },
  }
}