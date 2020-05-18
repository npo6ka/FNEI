Debug = {}

d_limit = 5

function object_to_string(level, object)
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
    if level <= d_limit then
      message = message .. "\n" .. get_tabs(level) .. "{\n"
      for key, next_object in pairs(object) do
        message = message .. get_tabs(level + 1) .. "\"" .. key .. "\"" .. ":" .. object_to_string(level + 1, next_object) .. ",\n";
      end
      message = message .. get_tabs(level) .. "}"
    else
      message = message .. "\"" .. "__table" .. "\""
    end
  end
  return message
end

function rec_obj_to_string(object, ...)
  arg = {...}
  if #arg > 0 then
    return object_to_string(0, object) .. rec_obj_to_string(...)
  else
    return object_to_string(0, object)
  end
end

function get_message(tag, logClass, ...)
  local message = rec_obj_to_string(...)

  message = "[FNEI]" .. tag .. " <" .. logClass .. "> " .. message 

  return message
end

function print_to_console(message)
  __DebugAdapter.print(message)
end

function print_to_log(message)
  log(message)
end

function d_print(type, message)
  print_to_console(message)
  print_to_log(message)
end

function Debug:debug(...)
  if __DebugAdapter then
    print_to_console(get_message("[DEBUG]", ...))
  end
end

function Debug:error(...)
  msg = get_message("[ERROR]", ...)
  print_to_console(msg)
  print_to_log(msg)
end

return Debug