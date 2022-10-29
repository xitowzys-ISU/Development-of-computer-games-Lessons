Pendulum = {}
Pendulum.__index = Pendulum

function Pendulum:create(origin, length)
    local pendulum = {}
    setmetatable(pendulum, Pendulum)
    pendulum.origin = origin
    pendulum.length = length
    pendulum.position = Vector:create(0, 0)
    pendulum.aVelocity = 0
    pendulum.aAcceleration = 0
    pendulum.damping = 0.995
    pendulum.angle = math.pi / 4
    pendulum.r = 20
    pendulum.dragging = false
    return pendulum
end

function Pendulum:draw()
    self.position.x = self.length * math.sin(self.angle)
    self.position.y = self.length * math.cos(self.angle)

    love.graphics.circle("line", self.origin.x, self.origin.y, 5)
    love.graphics.line(self.origin.x, self.origin.y, self.position.x, self.position.y)

    love.graphics.circle("fill", self.position.y, self.position.y, self.r)
end
