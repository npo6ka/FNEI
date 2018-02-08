require "prototypes.styles"
require "prototypes.main_styles"
require "prototypes.recipe_styles"
require "prototypes.option_styles"

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
    type = "technology",
    name = "electronics-machine-10",
    icon = "__base__/graphics/technology/automation.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "electronics-machine-1"
      }
    },
    prerequisites =
    {
      "automation",
    },
    unit =
    {
      count = 3000000,
      ingredients =
      {
        {"science-pack-1", 1},
      },
      time = 15
    },
    upgrade = true,
    order = "a-c-a",
  }}
)