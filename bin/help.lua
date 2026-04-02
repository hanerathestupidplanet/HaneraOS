        for i, v in pairs(drive.list("/bin")) do
            print(v:sub(1, #v - 4))
        end