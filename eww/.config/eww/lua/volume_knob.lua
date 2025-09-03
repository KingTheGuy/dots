if #arg <= 0 then
  print("maybe pass an arg")
  os.exit()
end
-- local time = os.time()
-- print(time)

local function cmd_output(cmd)
  local handle = io.popen(cmd)
  if handle ~= nil then
    local file = handle:read('*a')
    handle:close()
    return file
  end
end

local limit = 1.3
local amount = 0.02
if #arg >= 2 then
  if arg[2] == "scroll" then
    amount = 0.01
  end
  if arg[2] == "popup" then
  	io.popen("exec ~/.config/eww/bash/delay.sh 'reveal_knob' &")
  end
end

local volume = cmd_output("tail -n1 /tmp/eww_volume")
if (arg[1] == "mute") then
	cmd_output("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
	cmd_output("eww poll volume_muted")
else
  if (arg[1] == "up") then
    volume = volume + amount
  end
  if (arg[1] == "down") then
    volume = volume - amount
  end
  if volume < 0 then
    volume = 0
  end
  if volume > limit then
    volume = limit
  end

  local set_volume = io.open("/tmp/eww_volume","a")
  if set_volume ~= nil then
    set_volume:write(string.format("%s\n",volume))
    set_volume:close()
  end
end
-- print(volume)
