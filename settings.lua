data:extend{
  {
    type = "bool-setting",
    name = "fnei-show-hidden-recipe",
    setting_type = "runtime-per-user",
    default_value = false,
    order = "show-hidden-recipe",
  },
  {
    type = "string-setting",
    name = "fnei-recipe-location",
    setting_type = "runtime-per-user",
    default_value = "center",
    allowed_values = {"top", "left", "center"},
    order = "location",
  },
  {
    type = "string-setting",
    name = "fnei-main-location",
    setting_type = "runtime-per-user",
    default_value = "center",
    allowed_values = {"top", "left", "center"},
    order = "location",
  }
}