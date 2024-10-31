Player = {
  classname = "FNPlayer"
}

local cur_player = nil;
local cur_tick = 0

function Player.set(player)
  cur_player = player
  return Player
end

function Player.load(event)
  cur_player = game.players[event.player_index]
  cur_tick = event.tick
  return Player
end

function Player.get()
  return cur_player
end

function Player.get_tick()
  return cur_tick
end

function Player.print(val)
  if cur_player then
    cur_player.print(val)
  end
end

function Player.get_storage()
  if not storage.fnei[cur_player.name] then storage.fnei[cur_player.name] = {} end
  return storage.fnei[cur_player.name]
end

function Player.get_fstorage()
  if cur_player.force then
    local name = cur_player.force.name .. "_force"
    if not storage.fnei[name] then storage.fnei[name] = {} end
    return storage.fnei[name]
  else
    Debug:error("Error in function Player.get_fstorage: force not found")
  end
end

function Player.isAdmin()
  if cur_player == nil then
    Debug:error("Error in function Player.isAdmin: Lua_player == nil")
    return false
  end
  return cur_player.admin
end