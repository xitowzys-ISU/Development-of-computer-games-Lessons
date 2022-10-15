function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    ampl = 20
    angleVel = 0.001
    angle = 0
end

function love.draw()
    for x = 0, width, 8 do
        y = ampl * math.sin((angle + x / 120) * 4)
        y = y + ampl * math.sin((angle + x / 120) * 7)
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("line", x, y + height / 2, 10)
        love.graphics.setColor(181 / 255, 179 / 255, 179 / 255, 0.5)
        love.graphics.circle("fill", x, y + height / 2, 10)

    end

    angle = angle + angleVel
end
