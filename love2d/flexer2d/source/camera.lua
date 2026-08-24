
local Camera = setmetatable({}, {__index = Object})
Camera.__index = Camera
Camera.__instances = {}

function Camera.new(x, y, width, height, zoom)
    local cmr = setmetatable(Object.new(x,y,width,height), Camera)

    cmr.zoom = zoom or 1
    cmr.angle = 0
    cmr.objects = {}

	table.insert(Camera.__instances, cmr)
    
    return cmr
end
function Camera.__update(dt)
	for i = 1, #Camera.__instances do
		Camera.__instances[i]:update(dt)
	end
end
function Camera.__draw()
	for i = 1, #Camera.__instances do
		Camera.__instances[i]:draw()
	end
end
function Camera.__destroy()
    for i = #Camera.__instances, 1,-1 do
        Camera.__instances[i]:destroy()
        Camera.__instances[i] = nil
    end
end

function Camera:add(object)
    object.camera = self
    table.insert(self.objects, object)
end
function Camera:remove(object)
  	for i = #self.objects, 1, -1 do
    	if self.objects[i] == object then
            self.objects[i]:destroy()
    	end
  	end
end
function Camera:clean()
  	for i = #self.objects, 1, -1 do
    	self:remove(self.objects[i])
  	end
end

function Camera:update(dt)
    if not self.active then
        return
    end

    if #self.objects > 0 then
        for i = 1, #self.objects do
            self.objects[i]:update(dt)
        end
    end

    Object.update(self, dt)
end
function Camera:draw()
    if not self.visible then
        return
    end

    local screenX, screenY, screenWidth, screenHeight = love.graphics.getScissor()
    love.graphics.setScissor(self.x, self.y, self.width, self.height)

    love.graphics.push()

    love.graphics.scale(self.zoom)
    love.graphics.translate(self.width*0.5 / self.zoom, self.height*0.5 / self.zoom)

    love.graphics.rotate(math.rad(-self.angle))
    love.graphics.translate(self.x - self.width*0.5, self.y - self.height*0.5)

    if #self.objects > 0 then
        for i = 1, #self.objects do
            self.objects[i]:draw()
        end
    end

    Object.draw(self)

    love.graphics.pop()
    love.graphics.setScissor(screenX, screenY, screenWidth, screenHeight)
end

return Camera
