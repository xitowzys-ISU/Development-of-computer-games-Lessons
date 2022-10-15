require("vector")
require("mover")
require("attractor")

function love.load()
    movers = {}

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    G = 2.0
    local location = Vector:create(width / 2 + 100, height / 2)

    attractor = Attractor:create(location, 20)

    local location = Vector:create(300, 350)
    local velocity = Vector:create(0.1, 0.1)
    mover = Mover:create(location, velocity)

    for i = 0, 9, 1 do
        local location = Vector:create(love.math.random(300, 350), love.math.random(300, 350))
        local velocity = Vector:create(love.math.random(0.0, 3), love.math.random(0.0, 3))
        movers[i] = Mover:create(location, velocity)
    end

end

function love.update(dt)
    -- mover:update()
    -- attractor:attract(mover)

    for i = 0, 9, 1 do
        movers[i]:update()
        movers[i]:checkBoundaries()
        for j = 0, 9, 1 do
            movers[i]:attract(movers[j])
        end
    end


end

function love.draw()
    -- mover:draw()
    -- attractor:draw()

    for i = 0, 9, 1 do
        movers[i]:draw()
    end
end

function love.keypressed(key)
end
