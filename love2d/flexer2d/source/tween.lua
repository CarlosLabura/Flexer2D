local Tween = {}
Tween.__index = Tween
Tween.__instances = {}

function Tween.new(tag, object, parameters, duration, ease, endCallback)
    twn = setmetatable({}, Tween)

    twn.tag = tag
    twn.object = object
    twn.start = Table.copy(object)
    twn.parameters = parameters
    twn.duration = duration or 1
    twn.ease = Ease[ease] or Ease.linear
    twn.endCallback = endCallback or nil
    twn.elapsed = 0

    if #Tween.__instances > 0 then
        for i = #Tween.__instances, 1, -1 do
            if Tween.__instances[i].tag == twn.tag then
                table.remove(Tween.__instances, i)
            end
        end
    end
    table.insert(Tween.__instances, twn)
    
    return twn
end
function Tween.__update(dt)
    if #Tween.__instances < 1 then
        return
    end

    for i = #Tween.__instances, 1, -1 do
        Tween.__instances[i]:update(dt)

        if Tween.__instances[i]:finished() then
            if Tween.__instances[i].endCallback then
                Tween.__instances[i]:endCallback()
            end
            table.remove(Tween.__instances, i)
        end
    end
end
function Tween.__destroy()
    if #Tween.__instances < 1 then
        return
    end

    for i = #Tween.__instances, 1, -1 do
        Tween.__instances[i]:remove()
        Tween.__instances[i] = nil
    end
end

function Tween:remove()
    self = nil
end
function Tween:finished()
    return (self.elapsed >= self.duration)
end

local min = math.min
function Tween:update(dt)
    self.elapsed = self.elapsed + dt

    local time = min(self.elapsed / self.duration, 1)
    local ease = self.ease
    local start = self.start
    local object = self.object
    
    for k, v in pairs(self.parameters) do
        local st = start[k]
        object[k] = st + (v - st) * ease(time)
    end 
end



return Tween