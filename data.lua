require "prototypes.styles"
require "prototypes.main_styles"
require "prototypes.recipe_styles"
require "prototypes.settings_styles"
require "prototypes.hotbar_styles"


data:extend({
  {
    type = "custom-input",
    name = "pressed-fnei-gui-key",
    key_sequence = "CONTROL + E",
    consuming = "none"
  }
})

data:extend({
  {
    type = "custom-input",
    name = "pressed-fnei-back-key",
    key_sequence = "BACKSPACE",
    consuming = "none"
  }
})
