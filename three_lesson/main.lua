require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    mover = Mover:random()
    mover2 = Mover:random()
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

    x, y = love.mouse.getPosition()
    mouse = Vector:create(x, y)
    dir = mouse - mover2.location
    acceleration = dir:norm() * 0.4
    mover2.acceleration = acceleration
    angle = math.atan2(mover2.velocity.y, mover2.velocity.x)
    mover2.angle = angle
    mover2.active = true

    mover2:update()
    mover2:checkBoundaries()
end

function love.draw()
    mover:draw()
    mover2:draw()
end
