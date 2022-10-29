require "vector"
require "particle"
require "particlesystem"
require "repeller"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    system = ParticleSystem:create(Vector:create(width / 2, height / 2), 100)

    repeller = Repeller:create(Vector:create(width / 2, height / 2 + 10))

end

function love.update(dt)
    system:update()
    system:applyRepeller(repeller)
end

function love.draw()
    system:draw()
    repeller:draw()
end
