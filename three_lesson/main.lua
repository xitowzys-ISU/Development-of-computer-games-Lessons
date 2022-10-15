require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    mover = Mover:random()
    mover2 = Mover:random()

    mover.aVelocity = 0.2
    mover2.aVelocity = -0.3
end

function love.update(dt)
    mover:update()
    mover:checkBoundaries()

    mover2:update()
    mover2:checkBoundaries()
end

function love.draw()
    mover:draw()
    mover2:draw()
end
