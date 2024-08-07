require("scripts/formatter")
-- print("hello %s",arg[1])
local direction = arg[1]
local is_running = arg[2]

local function the_file(file_name)
	local file
	-- file = io.open("/tmp/clock_timer","r+")
	file = io.open(file_name,"r+")
	if file == nil then
		file = io.open(file_name,"w")
		if file ~= nil then
			file:write(0)
		end
	end
	local last
	if file ~= nil then
		for line in file:lines() do
				last = line
		end
		-- local tick = file:lines()
		-- print(tick)
	end
	return file,last
end

-- local function formatTimer(interval)
-- 	os.execute("./tick_format.sh "..interval)
-- end
local file,last = the_file("/tmp/tick")
local file_f,_ = the_file("/tmp/formatted_tick")

local function you(incremental)

	if file ~= nil then
		-- print("its not nil")
		local number
		if incremental == true then
			number = tonumber(last)+1
			elseif incremental == false then
			number = tonumber(last)-1
		end
		-- os.execute("eww update clock_timer_left_display="..formatTimer(number))
		os.execute(string.format("eww update clock_timer_left_display='%s'",Utils.tickToFormat(number,"v")))
		-- os.execute(string.format("eww update current_timer='%s'",Utils.tickToFormat(number,"v")))

		if file_f ~= nil then
			file_f:write(string.format("%s\n",Utils.tickToFormat(number,"v")))
			-- file_f:write("ok\n")
			file_f:close()
		end
		-- os.execute("scripts/formatter.lua "..number)
		-- print(Utils.tickToFormat(number))
		-- print(string.format("new value: %s",number))
		-- print(number)
		file:write(string.format("%s\n",number))
		-- file:write(Utils.tickToFormat(number,"v"))
		file:close()
	end
end

if is_running == "true" then
	-- print("we is running")
	if direction == "up" then
		os.execute("eww update clock_timer_cancel='false'")
	elseif direction == "down" then
		-- print("since scrolling down, cancel the timer")
		os.execute("eww update clock_timer_cancel='true'")
		os.execute("eww update clock_timer_left_display='ca\nnc\nel'")
		-- print("ca\ncc\nel")
		-- os.execute("./scripts/timer eww 0 cancel")
	end
	return
end

if direction == "up" then
	you(true)
	elseif direction == "down" then
	if tonumber(last) > 0 then
		you(false)
	end
end

-- os.execute("scripts/tick_format.sh")
