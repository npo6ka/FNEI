Translate = {
  classname = "FNtranslate"
}

require "utils/utf8_tolower"

local TRANSLATE_BATCH_SIZE = 50

-- Translation state lives in storage, not in file-level locals. A client that
-- joins a multiplayer game loads storage from the host's save but starts with
-- fresh locals, so state kept in locals makes the host and the client request
-- different translations and desync.
local function get_state()
  if storage.fnei_translate == nil then
    storage.fnei_translate = {
      registry = {},
      queues = {}
    }
  end

  return storage.fnei_translate
end

local function get_player_registry(player)
  local registry = get_state().registry

  if registry[player.name] == nil then
    registry[player.name] = {
      items = { names = {}, ids = {} },
      fluids = { names = {}, ids = {} }
    }
  end

  return registry[player.name]
end

local function sorted_prototypes(prots)
  local prot_list = {}

  for _, prot in pairs(prots) do
    table.insert(prot_list, prot)
  end

  table.sort(prot_list, function(a, b)
    return a.name < b.name
  end)

  return prot_list
end

local function queue_prot_translations(player_index, prots, prot_type)
  local prot_list = sorted_prototypes(prots)
  local queue = get_state().queues[player_index]

  for i = 1, #prot_list, TRANSLATE_BATCH_SIZE do
    local batch = {
      prot_type = prot_type,
      loc_names = {},
      prot_names = {}
    }

    for j = i, math.min(i + TRANSLATE_BATCH_SIZE - 1, #prot_list) do
      table.insert(batch.loc_names, prot_list[j].localised_name)
      table.insert(batch.prot_names, prot_list[j].name)
    end

    table.insert(queue.batches, batch)
  end
end

function Translate.translate(name, type)
  local player = Player:get()
  local player_registry = get_state().registry[player.name]

  if type == "item" and player_registry then
    return player_registry.items.names[name]
  elseif type == "fluid" and player_registry then
    return player_registry.fluids.names[name]
  end

  return nil
end

function Translate.tolower(str)
  return tolower(str)
end

function Translate.clear_player(player_index)
  local state = get_state()
  local player = game.players[player_index]

  if player and player.valid then
    state.registry[player.name] = nil
  end

  state.queues[player_index] = nil
end

function Translate.reset_translate()
  local state = get_state()
  local player = Player:get()

  state.registry[player.name] = nil
  state.queues[player.index] = nil
  Translate.init_translate()
end

function Translate.ensure_translate_init()
  local player = Player:get()

  if get_state().queues[player.index] == nil then
    Translate.init_translate()
  end
end

function Translate.init_translate()
  local player = Player:get()

  get_player_registry(player)

  get_state().queues[player.index] = {
    batches = {},
    batch_index = 1
  }

  queue_prot_translations(player.index, prototypes.item, "item")
  queue_prot_translations(player.index, prototypes.fluid, "fluid")
end

function Translate.process_queues()
  local queues = get_state().queues

  for player_index, queue in pairs(queues) do
    if queue.batch_index <= #queue.batches then
      local player = game.players[player_index]

      if player and player.valid and player.connected then
        local batch = queue.batches[queue.batch_index]
        local player_registry = get_player_registry(player)
        local registry_prot = batch.prot_type == "item" and player_registry.items or player_registry.fluids
        local ids = player.request_translations(batch.loc_names)

        if ids then
          for i, prot_name in ipairs(batch.prot_names) do
            registry_prot.ids[ids[i]] = prot_name
          end
        end

        queue.batch_index = queue.batch_index + 1
      end
    else
      queues[player_index] = nil
    end
  end
end

function Translate.set_translate_result(id, str)
  local player = Player:get()
  local player_registry = get_state().registry[player.name]

  if player_registry == nil then
    return
  end

  local prot_name = player_registry.items.ids[id]

  if prot_name then
    player_registry.items.names[prot_name] = Translate.tolower(str)
    player_registry.items.ids[id] = nil
  else
    prot_name = player_registry.fluids.ids[id]

    if prot_name then
      player_registry.fluids.names[prot_name] = Translate.tolower(str)
      player_registry.fluids.ids[id] = nil
    end
  end
end
