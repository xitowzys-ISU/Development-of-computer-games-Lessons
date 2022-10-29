require "vector"
require "mover"
require "spring"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    gravity = 1
    mover = Mover:create(100, 100, 100)
    mover2 = Mover:create(400, 400, 20)
    spring = Spring:create(Vector:create(500, 500), 100)


    
end

function love.update(dt)
    mover:update()
    mover2:update()
    spring:apply(mover)

end

function love.draw()
    mover:draw()
    mover2:draw()
    spring:draw()

    spring:drawLine(mover)

end

function love.keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        mover:clicked(x, y)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        mover:stopGrabbing()
    end
end