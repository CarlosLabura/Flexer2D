local Frames = setmetatable({}, {__index = Image})
Frames.__index = Frames

function Frames.new(x,y,image)
    local fra = setmetatable(Image.new(x,y,image), Frames)

    fra.animations = {}
    fra.animationController = {
        name = '',
        offsets = {0,0},

        maxFrames = 1,
        curFrame = 1,

        frames = nil,
        timer = 0,
        fps = 1,

        paused = false,
        loop = false,
        finished = false
    }

    return fra
end

function Frames:addAnimation(anim_name, anim_frames, anim_offsets, anim_fps, anim_loop)
    local anim_offsets = anim_offsets or {0,0}

    local animFrames = {}
    for i = 1, #anim_frames do
        table.insert(animFrames, love.graphics.newImage(anim_frames[i]))
    end

    self.animations[anim_name] = {
        name = anim_name,
        frames = animFrames, 
        offsets = {x = anim_offsets[1], y = anim_offsets[2]},
        fps = anim_fps or 24,
        loop = Utils.defaultBool(anim_loop, true)
    }
    self:playAnimation(anim_name)
end
function Frames:playAnimation(anim_name, force)
    local force = Utils.defaultBool(force, true)

    if not force and not self.animationController.finished then
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

    self.animationController.curFrame = 1
    self.animationController.maxFrames = #self.animations[anim_name].frames
    self.animationController.frames = self.animations[anim_name].frames
end

function Frames:update(dt)
    if not self.active then
        return
    end

    Object.update(self, dt)

    if self.animations == {} then
        return
    end

    self.animationController.timer = self.animationController.timer + love.timer.getDelta()

    if self.animationController.finished or self.animationController.paused then
        return
    end
    if self.animationController.timer < 1 / self.animationController.fps then
        return
    end

    self.animationController.timer = 0
    if self.animationController.curFrame < self.animationController.maxFrames then 
        self.animationController.curFrame = self.animationController.curFrame + 1 
    else
        if self.animationController.loop then
            self.animationController.curFrame = 1
        else 
            self.animationController.finished = true
        end
    end
end

function Frames:draw()
    if self.animations == {} then
        Image.draw(self)
        return
    end

    if not self.visible then
        return 
    end

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
    love.graphics.draw(self.animationController.frames[self.animationController.curFrame], 
        self.x + self.origin.x * self.scale.x - self.camera.x * self.scroll.x - self.animationController.offsets[1],
        self.y + self.origin.y * self.scale.y - self.camera.y * self.scroll.y - self.animationController.offsets[2],
        math.rad(self.angle), self.scale.x, self.scale.y, self.origin.x, self.origin.y
    )
    love.graphics.setColor(1, 1, 1, 1)

    Object.draw(self)
end

return Frames