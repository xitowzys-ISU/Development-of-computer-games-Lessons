Boid = {} -- "bird-oid object"
Boid.__index = Boid

function Boid:create(x, y)
    local boid = {}
    setmetatable(boid, Boid)
    boid.acceleration = Vector:create(0, 0)
    boid.velocity = Vector:create(0, 0)
    boid.location = Vector:create(x, y)
    boid.r = 5
    boid.vertices = { 0, -boid.r * 2, -boid.r, boid.r * 2, boid.r, 2 * boid.r }
    boid.maxSpeed = 4
    boid.maxForce = 0.1
    boid.wtheta = 0

    return boid
end

function Boid:boundaries()
    local desired = nil
    local d = 100
    if self.location.x < d then
        desired = Vector:create(self.maxSpeed, self.velocity.y)
    elseif self.location.x > width - d then
        desired = Vector:create(-self.maxSpeed, self.velocity.y)
    end

    if self.location.y < d then
        desired = Vector:create(self.velocity.x, self.maxSpeed)
    elseif self.location.y > height - d then
        desired = Vector:create(self.velocity.x, -self.maxSpeed)
    end

    if desired then
        desired:norm()
        desired:mul(self.maxSpeed)
        local steer = desired - self.velocity
        steer:limit(self.maxSpeed)
        self:applyForce(steer)
    end

end

function Boid:update()
    self.velocity:add(self.acceleration)
    self.velocity:limit(self.maxSpeed)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
end

function Boid:applyForce(force)
    self.acceleration:add(force)
end

function Boid:draw()
    local theta = self.velocity:heading() + math.pi / 2
    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(theta)
    love.graphics.polygon("fill", self.vertices)
    love.graphics.pop()
end
