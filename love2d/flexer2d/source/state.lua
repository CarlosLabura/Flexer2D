local State = {}

State.current = nil
State.name = nil

function State.switch(stateString)
    local state = require("states."..stateString:lower())
    
    State.__destroy()

    State.current = state
    State.name = stateString:lower()

    State.__create()
end

function State.__create()
    camera = Camera.new(0, 0, 1280, 720)
    if State.current and State.current.create then
        State.current.create()
    end
    print('State.lua: '..State.name..'.lua State Loaded')
end
function State.__update(dt)
    Camera.__update(dt)
    Tween.__update(dt)
    if State.current and State.current.update then
        State.current.update(dt)
    end
end
function State.__draw()
    Camera.__draw()
    if State.current and State.current.draw then
        State.current.draw()
    end
end
function State.__destroy()
    Camera.__destroy()
    Tween.__destroy()
    if State.current and State.current.destroy then
        State.current.destroy()
    end
    collectgarbage()
end

return State