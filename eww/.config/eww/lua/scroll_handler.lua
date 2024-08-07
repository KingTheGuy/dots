-- local skip_amount = 3
-- if arg[1] == "up" then
--   os.execute(string.format("light -A %s",skip_amount))
-- elseif arg[1] == "down" then
--   os.execute(string.format("light -U %s",skip_amount))
-- end
-- local who = arg[1]
if #arg < 3 then
  print("need at least 3 params")
  print("up or down")
  print("coomands to run")
end

if arg[1] == "up" then
  -- os.execute(string.format("light -A %s",skip_amount))
  os.execute(arg[2])
elseif arg[1] == "down" then
  os.execute(arg[3])
  -- os.execute(string.format("light -U %s",skip_amount))
end

if #arg >= 4 then
	-- local widget = arg[1]
	local handle = io.popen(arg[4])
	local output = handle:read("*a")
	handle:close()
	-- print(output)
	-- print(output)
  os.execute(string.format("eww update %s='%s'",arg[5],tonumber(output)))
end
