require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    local location = Vector:create(300, 350)
    local velocity = Vector:create(0.1, 0.1)
    mover = Mover:create(location, velocity)
end

function love.update(dt)
    mover:update()
end

function love.draw()
    mover:draw()
end

function love.keypressed(key)
end

