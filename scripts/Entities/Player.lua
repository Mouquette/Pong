local Player = {}
Player.__index = Player

function Player:new(x, y, color)
  self = setmetatable({}, Player)

  self.x = x
  self.y = y
  self.width = 20
  self.height = 150
  self.speed = 600
  self.color = color
  self.score = 0

  return self
end

function Player:setPosition(x, y)
  self.x = x
  self.y = y
end

function Player:move(direction, dt)
  local width, height = love.graphics.getDimensions()
  self.y = self.y + self.speed * direction * dt

  if self.y < 0 then
    self.y = 0
  elseif self.y > height - self.height then
    self.y = height - self.height
  end
end

function Player:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
