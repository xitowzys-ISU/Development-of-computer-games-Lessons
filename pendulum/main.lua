require "pendulum"
require "vector"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    gravity = 0.4
    pendulum = Pendulum:create(Vector:create(width / 2, 10), 200)
end

function love.update()
end

function love.draw()
    pendulum:draw()

end

function love.keypressed(key)
end
