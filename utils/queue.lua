Queue = {
  classname = "FNQueue",
}

function Queue:new( queue_name )
  local obj = {
    name = queue_name,
  }

  function obj:get_queue()
    local gl = Player.get_global()
    if not gl["queue_" .. self.name] then gl["queue_" .. self.name] = {} end
    return gl["queue_" .. self.name]
  end

  function obj:add( elem )
    local queue = obj:get_queue()
    table.insert(queue, elem)
  end

  function obj:clear()
    Player.get_global()["queue_" .. self.name] = {}
  end

  function obj:remove()
    local queue = obj:get_queue()
    if #queue > 0 then
      table.remove(queue, #queue)
    end
  end

  function obj:debug()
    for i,j in pairs(self:get_queue()) do
      out(i,j)
    end
  end

  function obj:get()
    local queue = obj:get_queue()
    if #queue > 0 then
      return queue[#queue]
    end
  end

  function obj:is_empty()
    return #obj:get_queue() == 0
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end

return Queue