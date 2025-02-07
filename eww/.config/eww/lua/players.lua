local function execCmd(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return "command error"
  end
  local output = handle:read("*a")
  handle:close()
  return output
end

local players = execCmd("playerctl -l")

print(players)

for index, value in ipairs(players) do
  
end
