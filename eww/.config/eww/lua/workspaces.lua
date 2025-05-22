local function execCmd(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return "command error"
  end
  local output = handle:read("*a")
  handle:close()
  return output
end

-- local workspaces = execCmd('hyprctl workspaces -j | jq -c "[.[] | {id:.id,focused:false}]"')
-- local active_workspace = execCmd('hyprctl activeworkspace -j | jq -c "[{id:.id}]"')
local active_workspace = execCmd('hyprctl activeworkspace -j | jq -c ".id"')
local workspaces = execCmd('hyprctl workspaces -j | jq -c "[.[] | {id:.id,focused:false}]" | jq "map(if .id == '..active_workspace..' then .focused = true else . end)" | jq "sort_by(.id)"')
-- local workspaces = execCmd('hyprctl workspaces -j | jq -c "[.[] | .id]"')
-- local active_workspace = execCmd('hyprctl activeworkspace -j | jq -c "[.id]"')

print(workspaces)
-- print(active_workspace)

-- there are 9 workspaces, so display 9 workspaces?
-- if workspace contains something change the icon otherwise show as empty
-- if workspace is active/focused change the icon


