local Image = setmetatable({}, {__index = Object})
Image.__index = Image

function Image.new(x,y,image)
    local img = setmetatable(Object.new(x,y), Image)

    img.image = nil
    img.frame = nil

    img.angle = 0
    img.alpha = 1

    img.color = {1,1,1}

    img.scale = {
        x = 1,
        y = 1
    }
    img.scroll = {
        x = 0,
        y = 0
    }

    img:setImage(image)
    
    return img
end

function Image:setScale(x,y,update_hitbox)
    local update_hitbox = Utils.defaultBool(update_hitbox, true)
    self.scale.x, self.scale.y = x, y
    if update_hitbox then
        self:setHitbox(self.image:getWidth() * self.scale.x, self.image:getHeight() * self.scale.y)
        self:setOrigin(self.width/2, self.height/2)  
    end
end

function Image:setScroll(x,y)
    self.scroll.x, self.scroll.y = x, y
end

function Image:setImage(image)
    local imageFile = Paths.images(image)
    if not love.filesystem.getInfo(imageFile) then
        self.image = love.graphics.newImage('engine/source/sprites/noimage.png')
        return
    end
    self.image = love.graphics.newImage(imageFile)
    self:setScale(self.scale.x,self.scale.y)
end

function Image:update(dt)
    Object.update(self, dt)
end

function Image:draw()
    if not self.visible then
        return
    end    

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
    love.graphics.draw(self.image, self.x + self.origin.x * self.scale.x - self.camera.x * self.scroll.x, 
        self.y + self.origin.y * self.scale.y - self.camera.y * self.scroll.y, 
        math.rad(self.angle), self.scale.x, self.scale.y, self.origin.x, self.origin.y
    )
    love.graphics.setColor(1, 1, 1, 1)

   Object.draw(self) 
end

return Image