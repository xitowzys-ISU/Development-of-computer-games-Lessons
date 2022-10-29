require "pendulum"
require "vector"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    gravity = 1
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
