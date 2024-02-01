Translate = {
  classname = "FNtranslate"
}

require "utils/utf8_tolower"

local registry = nil
local is_init = false

function Translate.translate(name, type)
  if is_init == false then
    Translate.reset_translate()
    is_init = true
  end

  local player = Player:get()
  if type == "item" and registry and registry[player.name] then
    return registry[player.name].items.names[name]
  elseif type == "fluid" and registry and registry[player.name] then
    return registry[player.name].fluids.names[name]
  else
    return nil
  end
end

function Translate.tolower(str)
  return tolower(str)
end

function Translate.reset_translate()
  if registry ~= nil then
    registry[Player:get().name] = nil
  end

  Translate.init_translate()
end

function Translate.init_translate()
  local player = Player:get()
  if registry == nil then
    registry = {}
  end
  if registry[player.name] == nil then
    registry[player.name] = {
      items = {},
      fluids = {}
    }
  end
  Translate.init_translate_prot(game.item_prototypes, registry[player.name].items)
  Translate.init_translate_prot(game.fluid_prototypes, registry[player.name].fluids)
end

function Translate.init_translate_prot(prots, registry_prot)
  if registry_prot.names == nil and registry_prot.ids == nil then
    registry_prot.names = {}
    registry_prot.ids = {}

    local loc_names = {}

    for _,prot in pairs(prots) do
      table.insert(loc_names, prot.localised_name)
    end

    local ids = Player.get().request_translations(loc_names)

    local i = 0
    for _,prot in pairs(prots) do
      i = i + 1
      registry_prot.ids[ids[i]] = prot.name
    end
  end
end

function Translate.set_translate_result(id, str)
  local player = Player:get()
  local prot_name = registry[player.name].items.ids[id]

  if prot_name then
    registry[player.name].items.names[prot_name] = Translate.tolower(str)
    registry[player.name].items.ids[id] = nil
  else
    prot_name = registry[player.name].fluids.ids[id]

    if prot_name then
      registry[player.name].fluids.names[prot_name] = Translate.tolower(str)
      registry[player.name].fluids.ids[id] = nil
    end
  end
end