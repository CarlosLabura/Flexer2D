local Keyboard = {}

Keyboard.keysPressed = {}
Keyboard.keysReleased = {}

Keyboard.pressed = function(key)
    return love.keyboard.isDown(key)
end
Keyboard.justPressed = function(key)
    return Keyboard.keysPressed[key]
end
Keyboard.justReleased = function(key)
    return Keyboard.keysReleased[key]
end

Keyboard.__update = function(dt)
    Keyboard.keysPressed = {}
    Keyboard.keysReleased = {}
end
Keyboard.__keyPressed = function(key)
    Keyboard.keysPressed[key] = true
end
Keyboard.__keyReleased = function(key)
    Keyboard.keysReleased[key] = true
end

return Keyboard