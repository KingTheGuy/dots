-- local s = 1
-- local m = 60
-- local h = 3600

if #arg ~= 2 then
	print("-Specify {time} {start|cancel}-")
	return
end
local Time = tonumber(arg[1])
local Action = arg[2]

print(type(Action))
if type(Time) ~= "number" then
 return print("time must be numerical")
end
-- if type(Action) ~= "string" then
-- 	return print("")
-- end

print(string.format("TIME: %s",Time))
print(string.format("ACTION: %s",Action))
