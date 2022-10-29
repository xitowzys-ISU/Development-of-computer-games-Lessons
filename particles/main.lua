require "vector"
require "particle"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    particle = Particle:create(Vector:create(width / 2, height / 2))



end

function love.update(dt)
    if particle:isDead() then
        particle = Particle:create(Vector:create(width / 2, height / 2))
    end
    particle:update()
end

function love.draw()
    particle:draw()

end
