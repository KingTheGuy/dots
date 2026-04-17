Utils = {}

function Utils.CMD(command)
  local handle = io.popen(command)
  if handle == nil then
    return "err"
  end
  local output = handle:read("*a")
  handle:close()
  return output
end

