
local version  = 1
local registry = nil

function translate(name, type)

  -- Initialize translator registry in a pluggable way
  if not registry then
    registry = {}

    for mod, _ in pairs(remote.interfaces) do
      if string.find(mod, '^locale%-search') and remote.call(mod, "version") == version then
        table.insert(registry, mod)
      end
    end

    table.sort(registry)
  end

  -- Ask translator services
  for _, mod in ipairs(registry) do
    local value = remote.call(mod, "translate", name, type)

    if value then
      return value
    end
  end

  -- No translation available
  return nil
end

return translate