require("string.lua")
-- very shitty user system
function hash(str)
    local h = 5381
    for i = 1, #str do
        h = ((h * 33) ~ string.byte(str, i)) % 4294967296
    end
    return tostring(h)
end

fnc = {
    currentusr = "",
    ["list"] = function() -- lists users
        for i, v in pairs(boot.list("/usr/acc")) do
            print(v)
        end
    end,
    ["create"] = function(usr) -- creates a user
        if boot.exists(joinpath("/usr/acc", tostring(usr))) then
            print("User already exists.")
            return
        end
        local usercreate = io.open(joinpath("/usr/acc", tostring(usr)), "w")
        io.close(usercreate)
        boot.makeDirectory(joinpath("/home", usr))
    end,
    ["password"] = function(usr) -- sets a users pass
        if boot.exists(joinpath("/usr/acc", tostring(usr))) then
            io.write("New password: ")
            local pswd = io.read()
            local password = io.open(joinpath("/usr/acc", tostring(usr)), "w")
            io.write(password, hash(pswd) .. "|")
            io.close(password)
            
        else
            print("No such user")
        end

    end,
    ["current"] = function()  -- displays current user
        print("Current user is: " .. fnc.currentusr)
    end,

    ["login"] = function() -- logs into another user
        io.write("Input user: ")
        local usr = io.read()
        io.write("Input password: ")
        local pswd = hash(io.read())
        
        if boot.exists(joinpath("/usr/acc", usr)) then
                local usrfl = io.open(joinpath("/usr/acc", usr), "r")
                local usrpswd = string.split(io.read(usrfl, 1024), "|")
                if usrpswd[1] == pswd then
                    fnc.currentusr = usr
                    return
                else
                print("Bad username or password.")
                fnc["login"]()
            end
        end
        
        print("Bad username or password.")
        fnc["login"]()
    end

}




return fnc







