require "libs.utils"
require "prototypes.styles"
require "prototypes.main_styles"
require "prototypes.recipe_styles"

data:extend({
  {
    type = "custom-input",
    name = "pressed-fnei-gui-key",
    key_sequence = "CONTROL + E",
    consuming = "script-only"
  }
})

data:extend({
  {
    type = "custom-input",
    name = "pressed-fnei-back-key",
    key_sequence = "BACKSPACE",
    consuming = "all"
  }
})

data:extend({
  {
    type = "custom-input",
    name = "pressed-fnei-gui2-key",
    key_sequence = "SHIFT + E",
    consuming = "script-only"
  }
})