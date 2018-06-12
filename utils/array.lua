Array = {
  classname = "FNArray",
}

function Array:new( array_name )
  local obj = {
    name = array_name,
  }

  function obj:get_array( )
    local gl = Player.get_global()
    if not gl["array_" .. self.name] then gl["array_" .. self.name] = {} end
    return gl["array_" .. self.name]
  end

  function obj:size( )
    return #obj:get_array()
  end

  function obj:insert( elem, pos )
    local array = obj:get_array()
    table.insert(array, pos, elem)
  end

  function obj:insert_head( elem )
    obj:insert(elem, 1)
  end

  function obj:insert_tail( elem )
    local array = obj:get_array()
    table.insert(array, elem);
  end

  function obj:replace_elem( elem, pos )
    local array = obj:get_array()
    array[pos] = elem
  end

  function obj:swap_element( src_pos, dst_pos )
    local val = obj:get( dst_pos )
    obj:replace_elem(obj:get(src_pos), dst_pos)
    obj:replace_elem(val, src_pos)
  end

  function obj:clear( )
    Player.get_global()["array_" .. self.name] = {}
  end

  function obj:remove( pos )
    local array = obj:get_array()
    if pos and obj:size() >= pos then
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
  end

  function obj:debug( )
    for i,j in pairs(self:get_array()) do
      out(i,j)
    end
  end

  function obj:get( pos )
    local array = obj:get_array()
    if obj:size() >= pos then
      return array[pos]
    end
  end

  function obj:is_empty( )
    return obj:size() == 0
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end

return Array