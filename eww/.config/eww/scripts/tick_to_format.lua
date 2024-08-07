#!/bin/env lua
---@module 'Utils'
-- require("scripts.formatter")
local tick = tonumber(arg[1])
-- print(tick)
-- if type(tick) ~= "number" then
--   tick = "0"
-- end
Utils.tickToFormat(tick,"v")
