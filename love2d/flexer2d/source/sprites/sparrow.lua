local Sparrow = setmetatable({}, {__index = Image})
Sparrow.__index = Sparrow

function Sparrow.new(x,y,image)
    local spa = setmetatable(Image.new(x,y,image), Sparrow)

    spa.xml = nil

    spa.animations = {}
    spa.animationController = {
        name = '',
        offsets = {0,0},

        startFrame = 1,
        maxFrames = 1,
        curFrame = 1,

        curAnimation = nil,
        timer = 0,
        fps = 1,

        paused = false,
        loop = false,
        finished = false
    }

    spa:setXml(image)
    
    return spa
end

function Sparrow:setXml(file)
    local xmlFile = Paths.images(file, 'xml')
    if not love.filesystem.getInfo(xmlFile) then
        return
    end
    self.xml = Xml.parse(love.filesystem.read(xmlFile), false) 
    self:setHitbox(self.xml.children[1].children[1].attrs.frameWidth or self.xml.children[1].children[1].attrs.width, 
                self.xml.children[1].children[1].attrs.frameHeight or self.xml.children[1].children[1].attrs.height
    )
    self:setOrigin(self.width/2, self.height/2)
end

function Sparrow:addAnimation(anim_name, anim_prefix, anim_offsets, anim_fps, anim_loop)
    local anim_offsets = anim_offsets or {0,0}
    self.animations[anim_name] = {
        name = anim_name,
        prefix = anim_prefix, 
        offsets = {x = anim_offsets[1], y = anim_offsets[2]},
        fps = anim_fps or 24,
        loop = Utils.defaultBool(anim_loop, true)
    }
    self:playAnimation(anim_name)
end

function Sparrow:playAnimation(anim_name, force)
    local force = Utils.defaultBool(force, true)

    if not force and not self.animationProperties.finished then
        return
    end

    local animation = self.animations[anim_name]

    self.animationController.name = animation.name
    self.animationController.offsets[1] = animation.offsets.x
    self.animationController.offsets[2] = animation.offsets.y
    self.animationController.fps = animation.fps

    self.animationController.loop = animation.loop
    self.animationController.paused = false
    self.animationController.finished = false
    
    self.animationController.maxFrames = 1

    for i = 1, #self.xml.children[1].children do
        if string.sub(self.xml.children[1].children[i].attrs.name, 1, string.len(animation.prefix)) == animation.prefix then
            self.animationController.startFrame = i
            break
        end
    end

    for i = self.animationController.startFrame, #self.xml.children[1].children do
        if string.sub(self.xml.children[1].children[i].attrs.name, 1, string.len(animation.prefix)) == animation.prefix then
            self.animationController.maxFrames = self.animationController.maxFrames + 1
        else 
            break 
        end
    end
    self.animationController.curFrame = self.animationController.startFrame
end

function Sparrow:update(dt)
    if not self.active then
        return
    end

    Object.update(self, dt)

    self.animationController.timer = self.animationController.timer + love.timer.getDelta()

    if self.animationController.finished or self.animationController.paused then
        return
    end
    if self.animationController.timer < 1 / self.animationController.fps then
        return
    end

    self.animationController.timer = 0
    if self.animationController.curFrame < self.animationController.startFrame + self.animationController.maxFrames - 2 then 
        self.animationController.curFrame = self.animationController.curFrame + 1 
    else
        if self.animationController.loop then
            self.animationController.curFrame = self.animationController.startFrame
        else 
            self.animationController.finished = true
        end
    end
end
function Sparrow:draw()
    if not self.visible then
        return 
    end

    local xmlContent = self.xml.children[1].children[self.animationController.curFrame].attrs
    self.curAnimation = love.graphics.newQuad(
        xmlContent.x, 
        xmlContent.y, 
        xmlContent.width, 
        xmlContent.height, 
        self.image
    )

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
    love.graphics.draw(self.image, self.curAnimation, 
        self.x + self.origin.x * self.scale.x - self.camera.x * self.scroll.x - self.animationController.offsets[1] - (xmlContent.frameX or 0),
        self.y + self.origin.y * self.scale.y - self.camera.y * self.scroll.y - self.animationController.offsets[2] - (xmlContent.frameY or 0),
        math.rad(self.angle), self.scale.x, self.scale.y, self.origin.x, self.origin.y
    )
    love.graphics.setColor(1, 1, 1, 1)

    Object.draw(self)
end

return Sparrow