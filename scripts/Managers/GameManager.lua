local GameManager = {}

local EventManager = require("scripts.Managers.EventManager")
local SoundManager = require("scripts.Managers.SoundManager")
local ParticlesManager = require("scripts.Managers.ParticlesManager")
local CollisionManager = require("scripts.Managers.CollisionManager")

local SCORE_TO_WIN = 5

-- BALL

local Ball = require("scripts.Entities.Ball")
local ball = Ball:new(0, 0)

-- PLAYERS

local Player = require("scripts.Entities.Player")

local player1 = Player:new(0, 0, { 0.87, 0.34, 0.27 })
local player2 = Player:new(0, 0, { 0.18, 0.01, 0.87 })

-- GAME LOOP

function GameManager.load()
  local windowWidth, windowHeight = love.graphics.getDimensions()

  player1:setPosition(player1.width, (windowHeight - player1.height) / 2)
  player2:setPosition(windowWidth - player2.width * 2, (windowHeight - player2.height) / 2)

  player1.score = 0
  player2.score = 0

  ball:reset()
end

EventManager.addEventListener("touchWall", function(wallPosition)
  local windowHeight = love.graphics.getHeight()
  ball.direction.y = ball.direction.y * -1

  if wallPosition == "up" then
    ball.y = 0
  elseif wallPosition == "down" then
    ball.y = windowHeight - ball.height
  end

  SoundManager.playWallBounce()
end)

EventManager.addEventListener("touchPlayer", function(player)
  local windowWidth = love.graphics.getWidth()
  ball.direction.x = ball.direction.x * -1
  ball:increaseSpeed()

  if player == player1 then
    ball.x = player1.x + player1.width
    ParticlesManager.color = player1.color
  elseif player == player2 then
    ball.x = player2.x - ball.width
    ParticlesManager.color = player2.color
  end

  SoundManager.playPlayerBounce()
end)

EventManager.addEventListener("touchGoal", function(player_number)
  if player_number == 1 then
    player2.score = player2.score + 1
  elseif player_number == 2 then
    player1.score = player1.score + 1
  end

  SoundManager.playGoal()
  ball:reset()

  if player1.score == SCORE_TO_WIN or player2.score == SCORE_TO_WIN then
    EventManager.trigger("gameOver", player1.score == SCORE_TO_WIN and 1 or 2)
  end
end)

function GameManager.update(dt)
  dt = math.min(0.02, dt)

  -- Player 1 Movement
  local p1MoveUp = love.keyboard.isDown('a')
  local p1MoveDown = love.keyboard.isDown('q')
  if p1MoveUp or p1MoveDown then
    player1:move(p1MoveUp and -1 or 1, dt)
  end

  -- Player 2 Movement
  local p2MoveUp = love.keyboard.isDown('up')
  local p2MoveDown = love.keyboard.isDown('down')
  if p2MoveUp or p2MoveDown then
    player2:move(p2MoveUp and -1 or 1, dt)
  end

  -- Ball Movement
  ball:move(dt)

  -- Collision
  CollisionManager.update(ball, player1, player2)
end

function GameManager.draw()
  player1:draw()
  player2:draw()
  ball:draw()
end

function GameManager.getPlayersColor()
  return player1.color, player2.color
end

function GameManager.getPlayersScore()
  return player1.score, player2.score
end

return GameManager
