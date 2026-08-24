local Utils = {}


Utils.defaultBool = function(var, default)
    return (var == nil and default or var)
end
Utils.getFolderFiles = function(folder, includePath)
    local includePath = Utils.defaultBool(includePath, false)

    if includePath then
        local files = love.filesystem.getDirectoryItems(folder)
        for i = 1, #files do
            files[i] = folder..'/'..files[i]
        end
        return files
    end
    return love.filesystem.getDirectoryItems(folder)
end

return Utils