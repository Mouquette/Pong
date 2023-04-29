local Ball = {}
Ball.__index = Ball

local ParticlesManager = require("scripts.Managers.ParticlesManager")

local BALL_SPEED = { INITIAL = 350, MAXIMUM = 1000, INCREMENT = 25 }

function Ball:new(x, y)
  self = setmetatable({}, Ball)

  self.x = x
  self.y = y
  self.width = 20
  self.height = 20
  self.color = { 1, 1, 1, 1 }

  self.direction = { x = 1, y = 1 }
  self.speed = BALL_SPEED.INITIAL
  ParticlesManager.create(self)

  return self
end

function Ball:move(dt)
  self.x = self.x + self.direction.x * self.speed * dt
  self.y = self.y + self.direction.y * self.speed * dt
  ParticlesManager.update(self, dt)
end

function Ball:setDirection(x, y)
  self.direction.x = x
  self.direction.y = y
end

function Ball:reset()
  local width, height = love.graphics.getDimensions()

  self.x = (width - self.width) / 2
  self.y = (height - self.width) / 2
  self.speed = BALL_SPEED.INITIAL
end

function Ball:increaseSpeed()
  if self.speed < BALL_SPEED.MAXIMUM then
    self.speed = self.speed + BALL_SPEED.INCREMENT
  end
end

function Ball:draw()
  ParticlesManager.draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Ball
