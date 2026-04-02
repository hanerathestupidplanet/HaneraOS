boot = component.proxy(computer.getBootAddress())


local krnl = "/boot/krnl.lua"

local krnl = boot.open(krnl, "r")

if not krnl then error("KERNEL NOT FOUND") end
 

local read = ""



while true do
  local KRNLREAD = boot.read(krnl, 1024)
  if not KRNLREAD then break end
  read = read .. KRNLREAD
end

local func = load(read)

local func, err = pcall(func)

if not func then error("SERIOUS ERROR IN KERNEL: " .. err) else func() end
 