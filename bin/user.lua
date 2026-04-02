local args = {...}
local usr = require("usr.lua")

local func = args[1]
table.remove(args, 1)
if not usr[func] then  else usr[func](table.concat(args, " ")) return end



print("HaneraOS User Account Management Tool\n")
print("list - Lists users")
print("create - Creates a user")
print("delete - Deletes a user")
print("login - Logs into a user with a password")
print("password - Changes the password of a user")
print("current - Displays current user.")
return