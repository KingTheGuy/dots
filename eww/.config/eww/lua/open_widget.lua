--NOTE: maybe just do all this in go
if #arg >= 1 then
	local widget = arg[1]
	local var = arg[2]
	if var ~= nil then
		os.execute(string.format(var))
	end
	local handle = io.popen(string.format("eww active-windows",widget))
	local output = handle:read("*a")
	handle:close()
	-- print(output)
	if string.find(output,arg[1]) == nil then
		os.execute(string.format("eww open %s",widget))
		return
	end
	os.execute(string.format("eww close %s",widget))
	-- print("it is already open")
	-- os.execute(string.format("eww active-windows",widget))
	-- print("done")
end
