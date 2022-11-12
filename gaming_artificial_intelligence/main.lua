require "vector"
require "boid"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()


    boid = Boid:create(width / 2, height / 2)
    boid:applyForce(Vector:create(2, 1))

end

function love.update()
    boid:boundaries()
    boid:update()
end

function love.draw()
    boid:draw()
end
