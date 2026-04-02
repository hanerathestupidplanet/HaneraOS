local args = {...}

if not args then
    print("DEL - Deletes a file/directory\nUsage: del <file/directory>")
    return
end

if drive.exists(args[1]) then
    drive.remove(args[1])
    return
end
if drive.exists(joinpath(workingdir, args[1])) then
    drive.remove(joinpath(workingdir, args[1]))
    return
end
print("File/directory doesnt exist")