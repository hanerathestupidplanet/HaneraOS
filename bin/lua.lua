local args = {...}

if args[1] == nil then
    while true do
        io.write(">")
        local command = io.read()
        if command == "exit" then return end
        local func, err = load(command)
        if func then
            
        local ok, err = pcall(func)
        if not ok then
            print(err)
            return
        end
        
        else print(err) end
    end
else
    local func, err = load(args[1])
    if func then  

        local ok, err = pcall(func)
        if not ok then
            print(err)
            return
        end
        
        else print(err) end
end