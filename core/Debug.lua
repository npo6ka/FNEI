Debug = {}

Debug.filename="fnei\\fnei.log"
Debug.limit = 5
Debug.append = false
Debug.mode = true

if Debug.mode then
  Debug.print_tb = {
  --         chat   log    file  
    info =  {true,  true,  true},
    error = {true,  true,  true},
    debug = {false, true,  true},
  }
else
  Debug.print_tb = {
  --         chat   log    file
    info =  {false, false, false},
    error = {false, true,  true },
    debug = {false, false, false},
  }
end

function Debug:info(...)
  local arg = {...}
  self:print("info", self:get_message("[INFO]", unpack(arg)))
end

function Debug:debug(...)
  local arg = {...}
  self:print("debug", self:get_message("[DEBUG]", unpack(arg)))
end

function Debug:error(...)
  local arg = {...}
  self:print("error", self:get_message("[ERROR]", unpack(arg)))
end

function Debug:object_to_string(level, object)
  local function get_tabs(num)
    local msg = ""
    for i = 0, num do  msg = msg .. "  " end
    return msg
  end

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
      message = message .. "\n" .. get_tabs(level) .. "{\n"
      for key, next_object in pairs(object) do
        message = message .. get_tabs(level + 1) .. "\"" .. key .. "\"" .. ":" .. self:object_to_string(level + 1, next_object) .. ",\n";
      end
      message = message .. get_tabs(level) .. "}"
    else
      message = message .. "\"" .. "__table" .. "\""
    end
  end
  return message
end

function Debug:rec_obj_to_string(object, ...)
  arg = {...}
  if #arg > 0 then
    return self:object_to_string(0, object) .. self:rec_obj_to_string(unpack(arg))
  else
    return self:object_to_string(0, object)
  end
end

function Debug:get_message(tag, logClass, ...)
  local arg = {...}
  local message = self:rec_obj_to_string(unpack(arg))

  message = "[FNEI]" .. tag .. " <" .. logClass .. "> " .. message 

  if not self.append then self.append = true end
  return message
end

function Debug:print_to_chat(message)
  if game ~= nil and game.players["npo6ka"] then
    game.players["npo6ka"].print(message)
  end
end

function Debug:print_to_log(message)
  log(message)
end

function Debug:print_to_file(message)
  if game ~= nil then
    if Player then
      message = tostring(Player.get_tick() or "") .. " " .. message
    end
    game.write_file(self.filename, message .. "\n", self.append)
  end
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