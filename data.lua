require "libs.utils"
require "prototypes.styles"

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