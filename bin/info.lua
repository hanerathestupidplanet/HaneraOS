print("HaneraOS " .. osver)
print("Architecture: " .. computer.getArchitecture())
print("Memory: " )


for i, v in pairs(computer.getDeviceInfo())[1] do
    print(v)
end
