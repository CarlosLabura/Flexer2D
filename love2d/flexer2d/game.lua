local Game = {}

Object = require 'flexer2d.source.object'
State = require 'flexer2d.source.state'
Camera = require 'flexer2d.source.camera'
Keyboard = require 'flexer2d.source.keyboard'
Ease = require 'flexer2d.source.ease'
Tween = require 'flexer2d.source.tween'

Image = require 'flexer2d.source.sprites.image'
Sparrow = require 'flexer2d.source.sprites.sparrow'
Quad = require 'flexer2d.source.sprites.quad'
Frames = require 'flexer2d.source.sprites.frames'
Square = require 'flexer2d.source.sprites.square'

Number = require 'flexer2d.source.utilities.number'
String = require 'flexer2d.source.utilities.string'
Table = require 'flexer2d.source.utilities.table'
Utils = require 'flexer2d.source.utilities.utils'

Xml = require 'flexer2d.source.parsers.xml'
Json = require 'flexer2d.source.parsers.json'

--[[
    TODO:
    - Text Library
    - Sound Library

    - Rename Json.decode() to Json.parse()
    - Csv Parser

    - Replace shit with Table.indexOf
    - Localize all lua/love functions
]]


function add(obj) 
    camera:add(obj) 
end
function remove(obj) 
    camera:remove(obj) 
end

local startTime = love.timer.getTime()

gameSetting = {}
function Game.new(state, fps, filter)
    gameSetting.state = state or 'game'
    gameSetting.fps = fps or 60
    gameSetting.filter = filter or 'linear'
    gameSetting.width, gameSetting.height, gameSetting.windowFlags = love.window.getMode()

    --add filter mode

    love.graphics.setDefaultFilter(gameSetting.filter, gameSetting.filter)
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15, 1)
    State.switch(gameSetting.state)

    print(string.format("Game loaded in %.4f seconds", love.timer.getTime()-startTime))
end

function love.update(dt) 
    State.__update(dt)
    Keyboard.__update(dt)
end
function love.draw() 
    State.__draw() 
end
function love.keypressed(key) 
    Keyboard.__keyPressed(key)
end
function love.keyreleased(key) 
    Keyboard.__keyReleased(key)
end

return Game