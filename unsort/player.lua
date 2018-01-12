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


function Player.get_global()
  if not global.fnei[cur_player.name] then global.fnei[cur_player.name] = {} end
  return global.fnei[cur_player.name]
end

function Player.isAdmin()
  if Lua_player == nil then
    out("Error in function Player.isAdmin: Lua_player == nil")
    return false
  end
  return Lua_player.admin
end