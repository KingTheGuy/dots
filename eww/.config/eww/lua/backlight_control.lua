require("lua_utils")

if arg[1] == nil then
  print("add some args")
  return
end

local function update(force)
  force = force or false
  local max = Utils.CMD("brightnessctl m")
  local cur = Utils.CMD("brightnessctl g")
  local cur_per =  math.ceil((cur / max) * 100)
  if force == true then
    Utils.CMD(string.format("eww update cur_backlight_level=%s",cur_per))
  else
    print(cur_per)
  end
end

if arg[2] == nil then
  update()
  return
end

local backlight_level = arg[2]
if arg[1] == "up" then
  Utils.CMD(string.format("brightnessctl set +%s%%",backlight_level))
else
  Utils.CMD(string.format("brightnessctl set %s%%- -n 960 ",backlight_level))
end

update(true)
