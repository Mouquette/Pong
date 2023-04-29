local ParticlesManager = {}
ParticlesManager.color = { 1, 1, 1, 1 }

local _particles

function ParticlesManager.create(ball)
  local canvas = love.graphics.newCanvas(ball.width, ball.height)
  love.graphics.setCanvas(canvas)
  love.graphics.rectangle("fill", 0, 0, ball.width, ball.height)
  love.graphics.setCanvas()

  _particles = love.graphics.newParticleSystem(canvas, 150)
  _particles:setParticleLifetime(0.1, 0.6) -- (min, max)
  _particles:setLinearAcceleration(-200, -200, 200, 200) -- (minX, minY, maxX, maxY)
  _particles:setColors(0.8, 0.8, 0.8, 0.6, 0, 0, 0, 0) -- (r1, g1, b1, a1, r2, g2, b2, a2 ...)
  _particles:setEmissionRate(10000)
end

function ParticlesManager.update(ball, dt)
  _particles:setPosition(ball.x + ball.width / 2, ball.y + ball.height / 2)
  _particles:update(dt)
end

function ParticlesManager.draw()
  love.graphics.setColor(ParticlesManager.color)
  love.graphics.draw(_particles)
end

return ParticlesManager

