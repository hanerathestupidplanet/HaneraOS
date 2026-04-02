local args = {...}

require("string.lua")
local file
if table.concat(args, " "):sub(1, 1) == "/" then
     file = io.open(table.concat(args, " "), "r")
else
     file = io.open(joinpath(workingdir, table.concat(args, " ")), "r")
end

if not file then print("File not specified or doesnt exist.") return end

local read = {}

while true do
    local data
    data = io.read(file, 1024)
    if not data then break end
    table.insert(read, data)
end

print(table.concat(read))

io.close(file)