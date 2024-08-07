Utils = {}
-- Utils.tickToFormat = function(input,f)
---@param input integer
---@param f string
function Utils.tickToFormat(input,f)
	-- print("this is the input: "..input)

	local tick = tonumber(input) 
	-- local tick = tonumber(input) * 60
	-- print("tick is: "..tick)
	local H = 0
	local M = 0
	local S = 0
	if tick >= 3600 then
		H = math.floor(tick / 3600)
		H = H % 99
	end
	if tick >= 60 then
		M = math.floor(tick / 60)
		M = M % 60
		if M == 0 then
			M = 00
		end
	end
	if tick >= 0 then
		S = math.floor(tick % 60)
		if S == 0 then
			S = 00
		end
	end

	local ticks = ""

	if f == "h" then
		ticks = string.format("%02d:%02d:%02d", tonumber(H), tonumber(M), tonumber(S))
	else
		ticks = string.format("%02d\n%02d\n%02d", tonumber(H), tonumber(M), tonumber(S))
	end
	-- local ticks = string.format("%s\n%s\n%s\n",tonumber(H),tonumber(M),tonumber(S))

	-- print("what is this ", tostring(ticks))
	return(ticks)
end

if #arg >= 1 then
	-- print("ok")
	print("ok: ",Utils.tickToFormat(arg[1],arg[2]))
end
