Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity, weight)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.aVelocity = 0
    mover.angle = 0
    mover.acceleration = Vector:create(0, 0)
    mover.weight = weight or 1
    mover.size = 20 * mover.weight
    return mover
end

function Mover:random()
    local location = Vector:create()
    location.x = love.math.random(0, width)
    location.y = love.math.random(0, height)
    local velocity = Vector:create()
    velocity.x = love.math.random(-2, 2)
    velocity.y = love.math.random(-2, 2)
    local weight = love.math.random(1, 4)
    return Mover:create(location, velocity, weight)
end

function Mover:draw()
    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(self.angle)
    love.graphics.rectangle("fill", -self.size / 2, -self.size / 2, self.size, self.size)
    love.graphics.pop()
end

function Mover:applyForce(force)
    self.acceleration:add(force * self.weight)
end

function Mover:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end

    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = 0
        self.acceleration.y = 1
    end
end

function Mover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.angle = self.angle + self.aVelocity
    self.acceleration:mul(0)
end
