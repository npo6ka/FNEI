

local Player = {
  classname = "FNPlayer"
}

local cur_player = nil;

function Player.set(player)
  cur_player = player
  return Player
end

function Player.load(event)
  cur_player = game.players[event.player_index]
  return Player
end

function Player.get()
  return cur_player
end

function Player.isAdmin()
  if Lua_player == nil then
    out("Error in function Player.isAdmin: Lua_player == nil")
    return false
  end
  return Lua_player.admin
end

return Player