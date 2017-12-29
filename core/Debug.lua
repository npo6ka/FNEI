Debug = {}

Debug.filename="fnei\\fnei.log"
Debug.limit = 5
Debug.append = false

Debug.print_tb = {
--         chat  log   file  
  info =  {true,  true,  true},
  error = {true,  true,  true},
  debug = {false, false, true},
}

function Debug:info(...)
  local arg = {...}
  self:print("info", self:get_message("[INFO]", 2, unpack(arg)))
end

function Debug:debug(...)
  local arg = {...}
  self:print("debug", self:get_message("[DEBUG]", 3, unpack(arg)))
end

function Debug:error(...)
  local arg = {...}
  self:print("error", self:get_message("[ERROR]", 3, unpack(arg)))
end

function Debug:object_to_string(level, object)
  if level == nil then level = 0 end

  local message = " "

  if object == nil then
    message = message .. "nil"
  elseif type(object) == "boolean" or type(object) == "number" then
    message = message .. tostring(object) end
  if type(object) == "string" then
    message = message..object end
  if type(object) == "function" then
    message = message.."\"__function\"" end
  if type(object) == "table" then
    if level <= self.limit then
      local first = true
      message = message.."{"
      for key, next_object in pairs(object) do
        if not first then message = message.."," end
        message = message.."\""..key.."\""..":"..self:object_to_string(level + 1, next_object);
        first = false
      end
      message = message.."}"
    else
      message = message.."\"".."__table".."\""
    end
  end
  return message
end

function Debug:rec_obj_to_string(level, object, ...)
  arg = {...}
  if #arg > 0 then
    return self:object_to_string(level, object) .. self:rec_obj_to_string(level, unpack(arg))
  else
    return self:object_to_string(level, object)
  end
end

function Debug:get_message(tag, level, logClass, ...)
  local arg = {...}
  local message = self:rec_obj_to_string(nil, unpack(arg))

  message = "[FNEI]" .. tag .. " <" .. logClass .. "> " .. message 

  if not self.append then self.append = true end
  return message
end

function Debug:print_to_chat(message)
  if game.players["npo6ka"] then
    game.players["npo6ka"].print(message)
  end
end

function Debug:print_to_log(message)
  log(message)
end

function Debug:print_to_file(message)
  game.write_file(self.filename, message .. "\n", self.append)
end

function Debug:print(type, message)
  if self.print_tb[type][1] then
    self:print_to_chat(message)
  end
  if self.print_tb[type][2] then
    self:print_to_log(message)
  end 
  if self.print_tb[type][3] then
    self:print_to_file(message)
  end
end