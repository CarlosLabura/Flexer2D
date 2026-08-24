local Object = {}
Object.__index = Object

function Object.new(x,y,width,height)
    local obj = setmetatable({}, Object)

    obj.x = x or 0
    obj.y = y or 0

    obj.origin = {
        x = 0,
        y = 0
    }

    obj.width = width or 1
    obj.height = height or 1

    obj.active = true
    obj.visible = true
    obj.debug = false

    obj.camera = nil

    obj.updateCallback = nil
    obj.drawCallback = nil
    obj.destroyCallback = nil

    return obj
end

function Object:setPosition(x,y)
    self.x, self.y = x, y
end
function Object:setHitbox(width,height)
    self.width, self.height = width, height
end
function Object:setOrigin(x,y)
    self.origin.x, self.origin.y = x, y
end

function Object:destroy()
    if self.destroyCallback then
        self:destroyCallback()
    end

    self.active = false
    self = nil
end
function Object:update(dt)
    if not self.active then
        return
    end

    if self.updateCallback then
        self:updateCallback(dt)
    end
end
function Object:draw()
    if not self.visible then
        return
    end

    if self.debug then
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.circle('fill', self.x + self.origin.x, self.y + self.origin.y, 1)
    end

    if self.drawCallback then
        self:drawCallback()
    end
end



return Object