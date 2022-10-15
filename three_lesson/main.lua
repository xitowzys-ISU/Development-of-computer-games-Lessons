require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()


    local location = Vector:create(width / 2 + 100, height / 2)

    attractor = Attractor:create(location, 20)

    local location = Vector:create(300, 350)
    local velocity = Vector:create(0.1, 0.1)
    mover = Mover:create(location, velocity)
end

function love.update(dt)
    mover:update()
end

function love.draw()
    mover:draw()
    attractor:draw()
end

function love.keypressed(key)
end
