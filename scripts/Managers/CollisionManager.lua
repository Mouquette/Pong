local CollisionManager = {}

-- MODULES

local EventManager = require("scripts.Managers.EventManager")

local function touchPlayer(player, ball, ballColliderX)
  local onPlayerX = ballColliderX > player.x and ballColliderX < player.x + player.width / 2
  local onPlayerY = ball.y > player.y and ball.y < player.y + player.height

  return onPlayerX and onPlayerY
end

function CollisionManager.update(ball, player1, player2)
  local windowWidth, windowHeight = love.graphics.getDimensions()

  -- WALLS

  local touchUpWall = ball.y < 0 and ball.direction.y < 0
  local touchDownWall = ball.y + ball.width > windowHeight and ball.direction.y > 0
  if touchUpWall or touchDownWall then
    EventManager.trigger("touchWall", touchUpWall and "up" or "down")
    return
  end

  -- PLAYERS

  local touchPlayer1 = touchPlayer(player1, ball, ball.x) and ball.direction.x < 0
  local touchPlayer2 = touchPlayer(player2, ball, ball.x + ball.width) and ball.direction.x > 0
  if touchPlayer1 or touchPlayer2 then
    EventManager.trigger("touchPlayer", touchPlayer1 and player1 or player2)
    return
  end

  -- GOAL

  local touchRedGoal = ball.x < 0
  local touchBlueGoal = ball.x + ball.width > windowWidth
  if touchRedGoal then
    EventManager.trigger("touchGoal", 1)
  elseif touchBlueGoal then
    EventManager.trigger("touchGoal", 2)
  end
end

return CollisionManager
