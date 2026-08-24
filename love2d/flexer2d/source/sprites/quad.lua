local Quad = setmetatable({}, {__index = Image})
Quad.__index = Quad

function Quad.new(x,y,image)
    local qud = setmetatable(Image.new(x,y,image), Quad)

    qud.curQuad = {}
    qud.quads = {}

    return qud
end

function Quad:addQuad(quad_id, quads)
    local quadd = quads or {0,0,0,0}

    self.quads[quad_id] = {
        id = quad_id,
        quad = quadd
    }
    self:drawQuad(quad_id)
end
function Quad:drawQuad(quad_id)
    self.curQuad = self.quads[quad_id].quad
end

function Quad:update(dt)
    Object.update(self, dt)
end
function Quad:draw()
    local currentQuad = self.curQuad
    if #currentQuad < 1 then
        Image.draw(self)
        return
    end

    if not self.visible then
        return 
    end

    local quadDisplay = love.graphics.newQuad(currentQuad[1], currentQuad[2], currentQuad[3], currentQuad[4], self.image)

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
    love.graphics.draw(self.image, quadDisplay, 
        self.x + self.origin.x * self.scale.x - self.camera.x * self.scroll.x,
        self.y + self.origin.y * self.scale.y - self.camera.y * self.scroll.y,
        math.rad(self.angle), self.scale.x, self.scale.y, self.origin.x, self.origin.y
    )
    self:setHitbox(currentQuad[3]*self.scale.x, currentQuad[4]*self.scale.y)
    self:setOrigin(self.width/2, self.height/2)  
    love.graphics.setColor(1, 1, 1, 1)

    Object.draw(self)
end

return Quad