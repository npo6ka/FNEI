Array = {
  classname = "FNArray",
}

function Array:new( array_name )
  local obj = {
    name = array_name,
  }

  function obj:get_array( )
    local gl = Player.get_global()
    if not gl["a" .. self.name] then gl["a" .. self.name] = {} end
    return gl["a" .. self.name]
  end

  function obj:size( )
    return #obj:get_array()
  end

  function obj:insert( elem, pos )
    if pos then
      local array = obj:get_array()
      table.insert(array, pos, elem)
    end
  end

  function obj:insert_head( elem )
    obj:insert(elem, 1)
  end

  function obj:insert_tail( elem )
    local array = obj:get_array()
    table.insert(array, elem);
  end

  function obj:replace_elem( elem, pos )
    if pos then
      local array = obj:get_array()
      array[pos] = elem
    end
  end

  function obj:swap_element( src_pos, dst_pos )
    if src_pos and dst_pos then
      local val = obj:get( dst_pos )
      obj:replace_elem(obj:get(src_pos), dst_pos)
      obj:replace_elem(val, src_pos)
    end
  end

  function obj:clear( )
    Player.get_global()["a" .. self.name] = {}
  end

  function obj:remove( pos )
    if pos and obj:size() >= pos then
      local array = obj:get_array()
      return table.remove(array, pos)
    end
  end

  function obj:get_first_free_slot( )
    local array = obj:get_array()
    local i = 1

    while array[i] ~= nil do
      i = i + 1 
    end

    return i
  end

  function obj:get_elem_pos( elem )
    local array = obj:get_array()
    local size = obj:size()

    if elem == nil then 
      return nil
    end

    if type(elem) ~= "table" then 
      for i,j in pairs(array) do
        if j == elem then
          return i
        end
      end
    else
      for i,j in pairs(array) do
        if type(j) == "table" and #j == #elem then
          local flag = true
          
          for ind,val in pairs(j) do
            if elem[ind] ~= val then
              flag = false
            end
          end

          if flag then
            return i
          end
        end
      end
    end

    return nil
  end

  function obj:debug( )
    for i,j in pairs(self:get_array()) do
      out(i,j)
    end
  end

  function obj:get( pos )
    if pos and obj:size() >= pos then
      return obj:get_array()[pos]
    end
  end

  function obj:is_empty( )
    return obj:size() == 0
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end

return Array