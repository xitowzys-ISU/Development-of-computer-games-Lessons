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
    self.position.x = self.length * math.sin(self.angle) + self.origin.x
    self.position.y = self.length * math.cos(self.angle) + self.origin.y

    love.graphics.circle("line", self.origin.x, self.origin.y, 5)
    love.graphics.line(self.origin.x, self.origin.y, self.position.x, self.position.y)

    love.graphics.circle("fill", self.position.x, self.position.y, self.r)
end

function Pendulum:update()
    self.aAcceleration = (-1 * gravity / self.length) * math.sin(self.angle)
    self.aVelocity = self.aVelocity + self.aAcceleration
    self.aVelocity = self.aVelocity * self.damping
    self.angle = self.angle + self.aVelocity
end
