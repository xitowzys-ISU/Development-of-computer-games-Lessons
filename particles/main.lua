require "vector"
require "particle"
require "particlesystem"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    system = ParticleSystem:create(Vector:create(width / 2, height / 2), 100)

end

function love.update(dt)
    system:update()
end

function love.draw()
    system:draw()

end
