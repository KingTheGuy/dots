local skip_amount = 5
if arg[1] == "up" then
  os.execute(string.format("playerctl position %s+",skip_amount))
elseif arg[1] == "down" then
  os.execute(string.format("playerctl position %s-",skip_amount))
end
