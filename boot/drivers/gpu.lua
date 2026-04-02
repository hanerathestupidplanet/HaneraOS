gpu = {}
gpucomp = component.proxy(component.list("gpu")())
gpu.cursorx, gpu.cursory = 1, 1
gpu.resx, gpu.resy = gpucomp.getResolution()

function gpu.setchar (char)
    if gpu.cursorx > gpu.resx then
        gpu.cursorx = 1
        gpu.cursory = gpu.cursory + 1
    end
    if gpu.cursory > gpu.resy then
        gpucomp.copy(1, 2, gpu.resx, gpu.resy - 1, 0, -1)
        gpucomp.fill(1, gpu.resy, gpu.resx, 1, " ")
        gpu.cursory = gpu.resy
    end
    if char == "\n" then
        gpu.cursorx = 1
        gpu.cursory = gpu.cursory + 1
    else
        gpucomp.set(gpu.cursorx, gpu.cursory, tostring(char))
        gpu.cursorx = gpu.cursorx + 1
    end
end

function gpu.res(x, y)
    gpucomp.setResolution(x, y)
end

function gpu.cls()
    gpucomp.fill(1, 1, gpu.resx, gpu.resy, " ")
    gpu.cursorx, gpu.cursory = 1, 1
end

function gpu.kprint(...)
    local strs = {...}
    for i = 1, #strs do
        for j = 1, #strs[i] do
            gpu.setchar(string.sub(strs[i], j, j))
        end
    end
end

return gpu