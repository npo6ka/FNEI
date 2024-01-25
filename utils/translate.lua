Translate = {
  classname = "FNtranslate"
}

require "utils/utf8_tolower"

local item_registry = nil
local item_registry_ids = nil
local fluid_registry = nil
local fluid_registry_ids = nil

function Translate.translate(name, type)
  local player = Player:get()
  if type == "item" and item_registry and item_registry[player.name] then
    return item_registry[player.name][name]
  elseif type == "fluid" and fluid_registry and fluid_registry[player.name] then
    return fluid_registry[player.name][name]
  else
    return nil
  end
end

function Translate.tolower(str)
  return tolower(str)
end

function Translate.reset_translate()
  local player = Player:get()
  if (item_registry ~= nil) then
    item_registry[player.name] = nil
    fluid_registry[player.name] = nil
    item_registry_ids[player.name] = nil
    fluid_registry_ids[player.name] = nil
  end

  Translate.init_translate()
end

function Translate.init_translate()
  if (item_registry == nil) then
    item_registry = {}
    fluid_registry = {}
    item_registry_ids = {}
    fluid_registry_ids = {}
  end
  Translate.init_translate_prot(game.item_prototypes, item_registry, item_registry_ids)
  Translate.init_translate_prot(game.fluid_prototypes, fluid_registry, fluid_registry_ids)
end

function Translate.init_translate_prot(prots, registry, registry_ids)
  local player = Player:get()
  if registry[player.name] == nil and registry_ids[player.name] == nil then
    registry[player.name] = {}
    registry_ids[player.name] = {}

    local loc_names = {}

    for _,item in pairs(prots) do
      table.insert(loc_names, item.localised_name)
    end

    local ids = Player.get().request_translations(loc_names)

    local i = 0
    for _,item in pairs(prots) do
      i = i + 1
      registry_ids[player.name][ids[i]] = item.name
    end
  end
end

function Translate.set_translate_result(id, str)
  local player = Player:get()
  local prot_name = item_registry_ids[player.name][id]

  if prot_name then
    item_registry[player.name][prot_name] = str
    item_registry_ids[player.name][id] = nil
  else
    prot_name = fluid_registry_ids[player.name][id]

    if prot_name then
      fluid_registry[player.name][prot_name] = str
      fluid_registry_ids[player.name][id] = nil
    end
  end
end