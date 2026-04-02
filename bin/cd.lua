local args = {...}

require("string.lua")

if not args[1] then
    print("CD: Changes the current directory.\nUsage: cd <directory name/..>")
end


if args[1] == ".." then
    workingdir = string.sub(workingdir, 1, string.last(workingdir, "/"))
    return
end


if drive.isDirectory(args[1]) then
    workingdir = args[1]
    return
end


if drive.isDirectory(joinpath(workingdir, args[1])) then
    workingdir = joinpath(workingdir, args[1])
    return
end
