local args = {...}

require("string.lua")


local function writefile(filename, filedata)
    filename = io.open(filename, "w")
    io.write(filename, filedata)
    io.close(filename)
end




if (not args[1]) then
  print("echo [data] [file (optional)]")
end


for i, v in pairs(args) do
  if v == ">" then
      local data = {}
      for j = 1, i - 1 do
          table.insert(data, args[j])
      end

      if args[i + 1] == nil then
        print("Specify a filename.")
        return
      end

      if args[i + 1]:sub(1, 1) == "/" then
        writefile(args[i + 1], table.concat(data, " "))
      else
        writefile(joinpath(workingdir, args[i + 1]), table.concat(data, " "))      
      end
      return
  end
end
print(table.concat(args, " "))
return
