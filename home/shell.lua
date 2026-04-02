print("HaneraOS")

require("string.lua")
local usr = require("usr.lua")

shell = {}


function shell.command(cmd)
    local command = string.split(cmd, " ")
    local file = command[1]
    table.remove(command, 1)
    local fl = loadfile("/bin/" .. file .. ".lua", boot)
    if not fl then
        print("Not a valid command.")
        return
    end
    local ok, err = pcall(fl, table.unpack(command))
    if not ok then
        print("Error while running application: " .. err)
        return
    end
end

local function nouser()
    print("No user account found. Please create a new one.")
    io.write("User name: ")
    local name = io.read()
    usr["create"](name)
    usr["password"](name)
    shell.command("cls")
end

currentusr = ""

local hasuser = false

for i, v in pairs(boot.list("/usr/acc")) do
    hasuser = true
    break
end

if not hasuser then
    nouser()
end


usr["login"]()



print("Welcome to HaneraOS! Type in help for a list of commands, then type in those commands to learn how to use them.")
print("Current user is: " .. usr.currentusr)
workingdir = joinpath("/home", usr.currentusr)
while true do
    io.write("[" .. workingdir .. "] # ")
    local command = string.split(io.read(), " ") -- simple stuff


    -- Simple file execution
    if command[1] == nil or command[1] == "" then
         print("Not valid command.")
    elseif drive.exists(command[1]) then -- Checks if there is a file path that exists in the working drive
        local file = command[1]
        table.remove(command, 1)

        local fl = loadfile(file, drive)
        if not fl then
            print("Error in application starting.")
        end
        local ok, err = pcall(fl, table.unpack(command))
        if not ok then
            print("Error while running application: " .. err)
        end
    elseif drive.exists(joinpath(workingdir, command[1])) then -- Checks if there is a file in the working directory with that name
        local file = command[1]
        table.remove(command, 1)


        local fl = loadfile(joinpath(workingdir, file), drive)
        if not fl then
            print("Error in application starting.")
        end
        local ok, err = pcall(fl, table.unpack(command))
        if not ok then
            print("Error while running application: " .. err)
        end
    else
        shell.command(table.concat(command, " "))
    end
end