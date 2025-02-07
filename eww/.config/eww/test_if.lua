local function execCommand(command)
    local handle = io.popen(command .. " 2>&1") -- Run command and capture both stdout and stderr
    if handle == nil then
      return "failed to execute"
    end
    local result = handle:read("*a") -- Read all output
    handle:close()
    return result
end

local output = execCommand("playerctl metadata mpris:artUrl") -- Replace with your command
print(output) -- Print the output (including errors)

if string.find(output,"file") then
  print("ok")
end


-- Ok and then making this eww call is kinda slower

local new_output = execCommand("eww get all_players")

print(new_output)
