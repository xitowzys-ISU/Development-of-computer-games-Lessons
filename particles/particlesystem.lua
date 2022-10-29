ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n, cls)
    local system = {}
    setmetatable(system, ParticleSystem)

    system.origin = origin
    system.n = n or 10
    system.particles = {}
    system.cls = cls or Particle

    return system
end

function ParticleSystem:createParticle()
    return self.cls:create(self.origin:copy())
end

function ParticleSystem:createParticles()
    for i = 1, self.n, 1 do
        self.particles[i] = self.cls:create(self.origin:copy())
    end
end

function ParticleSystem:draw()
    for i = 1, self.n, 1 do
        self.particles[i]:draw()
    end
end

function ParticleSystem:update()

    if #self.particles < self.n then
        self.particles[self.index] = self:createParticle()
        self.index = self.index + 1
    end

    -- for i = 1, self.n, 1 do
    --     self.particles[i]:update()
    -- end

    for k, v in pairs(self.particles) do
        if v:isDead() then
            v = self:createParticle()
            self.particles[k] = self:createParticle()
        end
        v:update()
    end
end
