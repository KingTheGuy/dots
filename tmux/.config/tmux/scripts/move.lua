-- i dont know the fuck this shit is, i dont really know the syntax and things aint making sense.

local direction = arg[1]
if direction == nil then
  return
end

local function cmd_output(cmd)
  local handle = io.popen(cmd)
  if handle ~= nil then
    local file = handle:read('a')
    handle:close()
    return file
  end
end

local current_pane = cmd_output("tmux display-message -p '#{pane_id}'")

-- local window_width=cmd_output("tmux display-message -p '#{window_width}'")
-- window_width=window_width-1

local next_pane=cmd_output(string.format("tmux display-message -p -t %s '#{pane_id}'",direction))
if next_pane == current_pane then
  if direction == "left" then
    cmd_output(string.format("tmux select-window -t -"))
  else
    cmd_output(string.format("tmux select-window -t +"))
  end
else
  cmd_output(string.format("tmux select-pane -t {%s-of}",direction))
end

-- local function sleep(n)
--   os.execute("sleep " .. tonumber(n))
-- end

-- cmd_output(string.format("tmux set window-style 'fg=#44e3c6'"))
-- sleep(0.1)
-- cmd_output(string.format("tmux set window-style 'fg=#121311'"))

