-- Simple functions for HaneraOS.

osver = "0.5"

local krnlok, krnlerr = pcall(function()
    -- variable init
drive = boot
workingdir = "/home"




-- filesystem and io

    os = {}
    os.lib = {}
        -- io
        io = {}
        io.write = function(handle, a)
            if not a then 
                gpu.kprint(handle)
                return
            end
            drive.write(handle, a)
        end
        io.read = function(file, size)
            if (not file) and (not size) then
                local a = ""    -- this sucks this fucking sucks i hate it
                local LAST = computer.uptime()
                while true do
                    local now = computer.uptime()
                    if now - LAST >= 0.5 then
                        LAST = now
                        visible = not visible
                    end
                    if visible then
                        gpucomp.set(gpu.cursorx, gpu.cursory, "_")
                    else
                        gpucomp.set(gpu.cursorx, gpu.cursory, " ")
                    end
                    local event,address,ascii,unicode = computer.pullSignal(0.1)
                    gpucomp.set(gpu.cursorx, gpu.cursory, "_")
                    if event == "key_down" then
                        gpucomp.set(gpu.cursorx, gpu.cursory, " ")
                        if ascii == string.byte("\r") then
                            break
                        elseif ascii == string.byte("\b") and #a > 0 then
                            a = string.sub(a, 1, #a - 1)
                            if gpu.cursorx ~= 0 then 
                                gpu.cursorx = gpu.cursorx - 1

                            else
                                gpu.cursorx = gpu.resx
                                gpu.cursory = gpu.cursory - 1
                            end
                            gpucomp.set(gpu.cursorx, gpu.cursory, " ")
                        elseif ascii <= 126 and ascii >= 32 then
                            a = a .. string.char(ascii)
                            io.write(string.char(ascii)) 
                        end
                    end
                end
                io.write("\n")
                return a
            else
                return drive.read(file, size)
            end
        end
        io.open = function(file, mode) 
            return drive.open(file, mode)
        end
        io.close = function(handle)
            drive.close(handle)
        end
        -- io

        function loadfile(file, drv)
            local read = "" -- VERY bad and slow way of doing ts
            if not drv then
                local file = io.open(file, "r") -- opens file handle
                if not file then return nil end -- idk why im returning nil here but it works so fuck it
                while true do -- loads the whole file
                    local fl = io.read(file, 1024)
                    if not fl then break end
                    read = read .. fl
                end
            else -- worls the same as above but uses drive specified
                local file = drv.open(file, "r")
                if not file then return nil end
                while true do
                    local fl = drv.read(file, 1024)
                    if not fl then break end
                    read = read .. fl
                end
            end

            local func, err = load(read) -- returns the file as a function
            if func then  else io.write("\n" .. err .. "\n") return end
            return func
        end
        
    function require (module, disk)
        if not disk then disk = drive end -- yeah yeah
        

        if module:sub(1, 1) ~= "/" then -- just checks if the module is a literal path
            module = "/usr/lib/" .. module
        end

        if os.lib[module] then return os.lib[module] end -- checks if the module was already required

        local file = loadfile(module, disk) -- loads file
        if not file then print("Module not found") return end -- self explanatory


        local loaded, result = pcall(file) -- pcalls the module so that it doesnt fucking crash the whole system
        
        if not loaded then print("Error loading module: " .. loaded) return end
        
        if not result then result = true end


        os.lib[module] = result -- returns the omdule
        return result

    end


    -- filesystem and io



    function print(...)
        local strs = {...}
        for i = 1, #strs do
            gpu.kprint(strs[i] .. "\n")
        end
    end


    function stop()
        while true do
            computer.pullSignal()
        end
    end



    function os.crash(msg) -- eh way of making an error message
        gpu.cls()
        gpucomp.setForeground(0xff0000)
        print("HaneraOS Has encountered a fatal error and needs to restart.\n")

        print("Error: " .. msg)

        for i = 1, 3 do
            computer.beep(1000, 0.3)
            computer.pullSignal(0.1)
        end
        print("\nRestaring in 3 seconds...")
        computer.pullSignal(3)
        computer.shutdown(1)
    end


    -- loading drivers
    for i, v in pairs(drive.list("/boot/drivers")) do -- i could have just used require but fuck you
        local driver = loadfile("/boot/drivers/" .. v)
        local ok, err = pcall(driver) 
        if not ok then os.crash("DRIVER ERROR. " .. err .. "\nDRIVER PATH: " .. "/boot/drivers/" .. v) end
    end
    gpu.cls()
end)

if not krnlok then
    os.crash("\n!KERNEL PANIC!\n" .. krnlerr .. "\n!KERNEL PANIC!") -- self explanatory
end

local shell = loadfile("/home/shell.lua", boot) -- again

if not shell then
    print("Shell not found or shell has had an error in compilation. Defaulting to lua shell...") -- checks if shell exists iohdoijsoifoiesdjig
    local lua = loadfile("/bin/lua.lua", boot)
    if not lua then os.crash("SHELL NOT FOUND") else lua() end

else
    local ok, err = pcall(shell)
    if not ok then
        print("Shell has errored! " .. err)
        print("Defaulting to lua shell...")
        local lua = loadfile("/bin/lua.lua", boot)
        if not lua then os.crash("SHELL NOT FOUND") else lua() end
    end
end

-- finally done

stop()
