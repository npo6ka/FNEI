List = {
  classname = "FNList",
}

function List:new( list_name )
  local obj = {
    name = list_name,
  }

  function obj:get_list()
    local gl = Player.get_global()
    if not gl["list_" .. self.name] then gl["list_" .. self.name] = {} end
    return gl["list_" .. self.name]
  end

  function obj:add( elem )
    local list = obj:get_list()
    table.insert(list, elem)
  end

  function obj:clear()
    Player.get_global()["list_" .. self.name] = {}
  end

  function obj:contains_elem( elem )
    local list = obj:get_list()

    if elem == nil then
      return nil
    end

    if type(elem) ~= "table" then
      for i,j in pairs(list) do
        if j == elem then
          return true
        end
      end
    else
      for i,j in pairs(list) do
        if type(j) == "table" and #j == #elem then
          local flag = true

          for ind,val in pairs(j) do
            if elem[ind] ~= val then
              flag = false
            end
          end

          if flag then
            return true
          end
        end
      end
    end

    return false
  end

  function obj:remove()
    local list = obj:get_list()
    if #list > 0 then
      table.remove(list, #list)
    end
  end

  function obj:debug()
    for i,j in pairs(self:get_list()) do
      out(i,j)
    end
  end

  function obj:get()
    local list = obj:get_list()
    if #list > 0 then
      return list[#list]
    end
  end

  function obj:is_empty()
    return #obj:get_list() == 0
  end

  setmetatable(obj, self)
  self.__index = self; return obj
end

return List