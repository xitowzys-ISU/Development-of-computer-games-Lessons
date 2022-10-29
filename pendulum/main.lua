require "pendulum"
require "vector"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    gravity = 0.2
    pendulum = Pendulum:create(Vector:create(width / 2, 10), 200)
end

function love.update()
    pendulum:update()
end

function love.draw()
    pendulum:draw()

end

function love.keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        pendulum:clicked(x, y)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        pendulum:stopGragging()
    end
end
