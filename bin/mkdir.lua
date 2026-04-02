local args = {...}


if not args then
    print("MKDIR: Creates a directory.\nUsage: mkdir <directory name>")
end

if args[1]:sub(1,1) == "/" then
    drive.makeDirectory(args[1])
    return
end
drive.makeDirectory(joinpath(workingdir, args[1]))