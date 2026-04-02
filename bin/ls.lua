local args = {...}

function ls(dir)
    print("List of files in " .. dir)
    files = drive.list(dir)
    for i, v in pairs(files) do
        print(v)
    end
end

local dir = args[1]

if not dir then
    ls(workingdir)
elseif drive.isDirectory(dir) then
    ls(dir)
else
   print("Directory doesnt exist.") 
end