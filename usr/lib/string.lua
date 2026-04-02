function string.split(text, sep) 
    local result = {} 
    text = tostring(text) 
    local i = 1
    while true do 
        local space = string.find(text, sep, i) 
        if space then 
            table.insert(result, string.sub(text, i, space-1)) 
            i = space + 1 
        else 
            table.insert(result, string.sub(text, i, #text)) 
            break 
        end 
    end 
    return result 
end 

function string.last(text, item) 
    for i = #text, 1, -1 do 
        if string.sub(text, i, i) == item then 
            return i - 1                 
        end
     end 
     return 1 
end
function joinpath(a,b)
    if a:sub(-1) ~= "/" then
        a = a .. "/"
    end
    if b:sub(1,1) == "/" then
        b = b:sub(2)
    end
    return a .. b
end