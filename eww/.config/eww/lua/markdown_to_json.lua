local file = io.open("test.md", "r")
if file == nil then
  print("file not found")
  os.exit()
end

-- check if line starts with "-"
-- do not print the lines till the next lien also contains "-"

local blocks = "[]" -- these are all the tasks
---@class time_block
---@field start string
---@field end string
---@field text string

---@class time_block
local task = {}

function task:to_string()
  return string.format('["%s","%s","%s","%s"]',self["time"],self["start"], self["end"], self["text"])
end

-- [] TODO: make sure time_frame is included

local lines = 0
for v in file:lines() do
  if string.find(v, "^-") then
    v = string.gsub(v, "^-", "")
    if task ~= nil then
      -- table.insert(blocks,task:to_string())
      -- if lines > 1 then
      if task["time"] ~= nil then
        blocks = string.format("%s,%s", blocks, task:to_string())
      end
      -- end
      -- print(task:to_string())
      lines = lines + 1
    end

    local block_start = string.match(v, "%d+:%d+")
    local start_hours = string.match(block_start, "%d+")
    local start_minutes = string.gsub(string.match(block_start, ":%d+"),":","")
    local time_frame = (start_hours * 60) + start_minutes
    v = string.gsub(v, block_start, "")
    task["start"] = block_start

    local block_end= string.match(v, "%d+:%d+")
    local end_hours = string.match(block_end, "%d+")
    local end_minutes = string.gsub(string.match(block_end, ":%d+"),":","")
    local time_frame_end = (end_hours* 60) + end_minutes
    v = string.gsub(v, block_end, "")
    task["end"] = block_end

    task["time"] = time_frame_end - time_frame

    -- task["time_dif"] =

    -- v = string.gsub(v,"^-",string.format("[%s - %s]:\n",block_start,bloack_end))
    task["text"] = v
  else
    task["text"] = string.format("%s%s", task["text"], v)
  end
end
file:close()
print(string.format('[%s]', blocks))
-- print('[["crap","ass"],"mas","ass"]')
