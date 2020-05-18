
-------------------------text_field_style--------------------------

data.raw["gui-style"].default["fnei_settings_numeric-text-field"] =
{
  type = "textbox_style",
  parent = "textbox",
  width = 50,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_wrong_numeric-text-field"] =
{
  type = "textbox_style",
  parent = "invalid_value_textfield",
  width = 50,
  scalable = false,
}

-------------------------flow_style--------------------------

data.raw["gui-style"].default["fnei_settings_tab-flow"] =
{
  type = "horizontal_flow_style",
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_updown-arrow-flow"] =
{
  type = "vertical_flow_style",
  scalable = false,
  vertical_spacing = 2,
}

-------------------------frame_style--------------------------

data.raw["gui-style"].default["fnei_settings_main-frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 530,
  maximal_width = 530,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_header-frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 518,
  maximal_width = 518,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_content-frame"] =
{
  type = "frame_style",
  parent = "fnei_default_frame",
  minimal_width = 518,
  maximal_width = 518,
  scalable = false,
}

-------------------------table_style--------------------------

data.raw["gui-style"].default["fnei_settings_main-table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_header-table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  horizontal_spacing = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_content-table"] =
{
  type = "table_style",
  parent = "fnei_default_table",
  scalable = false,
}

----------------------scroll_pane_style-----------------------

data.raw["gui-style"].default["fnei_settings_craft-cat-scroll"] =
{
  type = "scroll_pane_style",
  maximal_width = 506,
  minimal_width = 506,
  maximal_height = 400,
  scalable = false,
}

------------------------button_style-------------------------

data.raw["gui-style"].default["fnei_settings_empty-tab"] = 
{
  type = "button_style",
  parent = "fnei_default_empty-tab",
  height = 36,
  width = 167,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_selected-tab"] = 
{
  type = "button_style",
  parent = "fnei_default_selected-tab",
  height = 36,
  width = 167,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_enabled-building"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 185,
    y = 108,
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 111,
    y = 108,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 148,
    y = 108,
  },
}

data.raw["gui-style"].default["fnei_settings_disabled-building"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 185,
    y = 36,
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 111,
    y = 36,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 148,
    y = 36,
  },
}

data.raw["gui-style"].default["fnei_settings_hidden-building"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 36,
  scalable = false,

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 185,
    y = 0,
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 111,
    y = 0,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 148,
    y = 0,
  },
}

data.raw["gui-style"].default["fnei_settings_enable-category"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 108,
  font = "font-mb",
  scalable = false,

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 185,
    y = 108,
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 111,
    y = 108,

  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 148,
    y = 108,
  },
}

data.raw["gui-style"].default["fnei_settings_disable-category"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 36,
  width = 108,
  font = "font-mb",
  scalable = false,

  clicked_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 185,
    y = 0,
  },
  default_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 111,
    y = 0,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__core__/graphics/gui.png",
    height = 36,
    priority = "extra-high-no-scale",
    width = 36,
    x = 148,
    y = 0,
  },
}

data.raw["gui-style"].default["fnei_settings_up_arrow"] = 
{
  type = "button_style",
  parent = "button",
  height = 12,
  width = 24,
  scalable = false,

  default_graphical_set = {
    border = 1,
    filename = "__FNEI__/graphics/switch-quickbar.png",
    height = 12,
    priority = "extra-high-no-scale",
    width = 24,
    x = 0,
    y = 0,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__FNEI__/graphics/switch-quickbar.png",
    height = 12,
    priority = "extra-high-no-scale",
    width = 24,
    x = 24,
    y = 0,
  },
}

data.raw["gui-style"].default["fnei_settings_down_arrow"] = 
{
  type = "button_style",
  parent = "slot_button",
  height = 12,
  width = 24,
  scalable = false,

  default_graphical_set = {
    border = 1,
    filename = "__FNEI__/graphics/switch-quickbar.png",
    height = 12,
    priority = "extra-high-no-scale",
    width = 24,
    x = 0,
    y = 12,
  },
  hovered_graphical_set = {
    border = 1,
    filename = "__FNEI__/graphics/switch-quickbar.png",
    height = 12,
    priority = "extra-high-no-scale",
    width = 24,
    x = 24,
    y = 12,
  },
}

------------------------label_style-------------------------

data.raw["gui-style"].default["fnei_settings_header-label"] =
{
  type = "label_style",
  font = "font-lb",
  font_color = {r = 255, g = 230, b = 192},
  width = 70,
  horizontal_align = "center",
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_param-label"] =
{
  type = "label_style",
  width = 330,
  left_padding = 1,
  right_padding = 1,
  top_padding = 1,
  bottom_padding = 1,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_craft-category-label"] =
{
  type = "label_style",
  width = 506,
  horizontal_align = "center",
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_warning-text"] =
{
  type = "label_style",
  width = 100,
  font_color = { b = 0, g = 0.2, r = 1 },
  scalable = false,
}

------------------------empty_widget_style-------------------------

data.raw["gui-style"].default["fnei_settings_header-drag-widget"] =
{
  type = "empty_widget_style",
  height = 36,
  width = 440,
  left_margin = -440,
  scalable = false,
}

data.raw["gui-style"].default["fnei_settings_header-sprite-widget"] =
{
  type = "empty_widget_style",
  parent = "draggable_space",
  height = 36,
  width = 344,
  scalable = false,
}