require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    mover = Mover:random()
    mover2 = Mover:random()

    -- mover.aVelocity = 0.2
    -- mover2.aVelocity = -0.3
end

function love.update(dt)

    if love.keyboard.isDown("left") then
        mover:rotate(-0.05)
    end

    if love.keyboard.isDown("right") then
        mover:rotate(0.05)
    end

    if love.keyboard.isDown("up") then
        local x = 0.1 * math.cos(mover.angle)
        local y = 0.1 * math.sin(mover.angle)
        mover:applyForce(Vector:create(x, y))
        mover.active = true
    else
        mover.active = false
    end

    mover:update()
    mover.velocity = mover.velocity:limit(5)
    mover:checkBoundaries()

    mover2:update()
    mover2:checkBoundaries()
end

function love.draw()
    mover:draw()
    mover2:draw()
end
