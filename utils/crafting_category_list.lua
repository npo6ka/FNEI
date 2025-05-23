if not Item then Item = require "utils/items" end

local CraftCategoty = {
  -- single-line comment
  classname = "FNCraftCategoty"
}

local craf_cat

--return a list of attainable technologies or empty list
function CraftCategoty:get_crafting_category_list()
  Debug:debug(CraftCategoty.classname, "get_crafting_category_list( )")

  local entity = Player.get().character
  local key = "default"

  if entity and entity.name then
    key = entity.name
  end

  if not craf_cat then craf_cat = {} end

  if not craf_cat[key] then
    craf_cat[key] = self:create_crafting_category_list()
  end

  return craf_cat[key] or {}
end

----------------------- secondary function --------------------------

-- TODO: Clean this up..
function CraftCategoty:create_crafting_category_list()
  local result = {}

  local function add_category_entry(category, entry)
    if not result[category] then
      result[category] = {}
    end

    table.insert(result[category], entry)
  end

  local character = Player.get().character

  -- Add character 'by hand' recipes
  if character then
    if character.prototype.crafting_categories then
      local by_hand = { type = "player", val = { name = "handcraft" } }

      add_category_entry('handcraft', by_hand)

      for category, _ in pairs(character.prototype.crafting_categories) do
        add_category_entry(category, by_hand)
      end
    end
    if character.prototype.resource_categories then
      local by_hand = { type = "player", val = { name = "handmine", mining_speed = character.prototype.mining_speed } }

      for category, _ in pairs(character.prototype.resource_categories) do
        add_category_entry("mine " .. category, by_hand)
      end
    end
  end

  local item_list = Item:get_item_list()

  for _, item in pairs(item_list) do
    local entity = item.place_result

    if entity then
      local in_fluidbox = 0
      local out_fluidbox = 0

      if entity.fluidbox_prototypes then
        for _,fb in pairs(entity.fluidbox_prototypes) do
          for _,con in pairs(fb.pipe_connections) do
            if (con.flow_direction == "output") then
              out_fluidbox = out_fluidbox + 1
            elseif (con.flow_direction == "input") then
              in_fluidbox = in_fluidbox + 1
            elseif (con.flow_direction == "input-output") then
              in_fluidbox = in_fluidbox + 1
              out_fluidbox = out_fluidbox + 1
            end
          end
        end
      end

      -- A building might be able to craft items in a category
      for category, _ in pairs(entity.crafting_categories or {}) do
        add_category_entry(category, { type = "building", val = item, ingredient_count = entity.ingredient_count, ifbox = in_fluidbox, ofbox = out_fluidbox })
      end

      -- A building may be used to mine a certain item
      for category, _ in pairs(entity.resource_categories or {}) do
        add_category_entry("mine " .. category, { type = "resource-miner", val = item, mining_speed = entity.mining_speed, ifbox = in_fluidbox, ofbox = out_fluidbox })
      end

      -- A building may implicitly produce a fluid, regardless of any action
      if entity.type == "offshore-pump" then
        add_category_entry("offshore-pump", { type = 'building', val = item, ingredient_count = math.huge, ifbox = in_fluidbox, ofbox = out_fluidbox })
      end
    end
  end

  return result
end

return CraftCategoty