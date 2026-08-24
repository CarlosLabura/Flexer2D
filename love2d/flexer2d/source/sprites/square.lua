local Square = setmetatable({}, {__index = Object})
Square.__index = Square

function Square.new(x,y,width,height)
    local sqr = setmetatable(Object.new(x,y,width,height), Square)

    sqr.angle = 0
    sqr.alpha = 1

    sqr.color = {1,1,1}

    sqr.mode = 'fill'

    sqr.roundness = {
        x = 0,
        y = 0
    }
    sqr.scale = {
        x = 1,
        y = 1
    }
    sqr.scroll = {
        x = 0,
        y = 0
    }

    sqr:setScale(1,1)
    
    return sqr
end

function Square:setScale(x,y,update_hitbox)
    local update_hitbox = Utils.defaultBool(update_hitbox, true)
    self.scale.x, self.scale.y = x, y
    if update_hitbox then
        self:setHitbox(self.width * self.scale.x, self.height * self.scale.y)
        self:setOrigin(self.width/2, self.height/2)  
    end
end

function Square:setScroll(x,y)
    self.scroll.x, self.scroll.y = x, y
end
function Square:setRoundness(x,y)
    self.roundness.x, self.roundness.y = x, y
end

function Square:update(dt)
    Object.update(self, dt)
end

function Square:draw()
    if not self.visible then
        return
    end    

    love.graphics.push()

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
    love.graphics.translate(self.origin.x, self.origin.y)
    love.graphics.rotate(math.rad(self.angle))
    love.graphics.rectangle(self.mode, 
        self.x - self.origin.x * self.scale.x - self.camera.x * self.scroll.x, 
        self.y - self.origin.y * self.scale.y - self.camera.y * self.scroll.y, 
    self.width*self.scale.x, self.height*self.scale.y, self.roundness.x, self.roundness.y)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.pop()

   Object.draw(self) 
end

return Square