print("how does this work then")

os.exit()

local function execCommand(cmd)

  local handle = io.popen(cmd)
  if handle == nil then
    return "error"
  end

  local output = handle:read("*a")
  handle:close()

  return output
end

local function sleep(amount)
  os.execute("sleep " .. tonumber(amount))
end

print(execCommand("eww update refresh=false"))
sleep(2)
print(execCommand("eww update refresh=true"))
print("done sleeping")

