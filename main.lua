local EventManager = require("scripts.Managers.EventManager")
local SoundManager = require("scripts.Managers.SoundManager")
local GameManager = require("scripts.Managers.GameManager")
local UIManager = require("scripts.Managers.UIManager")

local SCENE_STATE = { MENU = "Menu", GAME = "Game", END = "End" }
local currentScene = SCENE_STATE.MENU

local redAlpha = 0.15
local blueAlpha = 0.15

function love.load()
  GameManager.load()

  local player1Color, player2Color = GameManager.getPlayersColor()
  UIManager.load(player1Color, player2Color)
end

EventManager.addEventListener("touchGoal", function(player_number)
  if player_number == 1 then
    redAlpha = 0.5
  elseif player_number == 2 then
    blueAlpha = 0.5
  end
end)

EventManager.addEventListener("gameOver", function(player_number)
  SoundManager.stopBGM()
  currentScene = SCENE_STATE.END
end)

function love.update(dt)
  UIManager.update(dt)

  if currentScene == SCENE_STATE.GAME then
    GameManager.update(dt)
  end

  if redAlpha > 0.15 then
    redAlpha = redAlpha - 0.01
  end
  if blueAlpha > 0.15 then
    blueAlpha = blueAlpha - 0.01
  end
end

function love.draw()
  local windowWidth, windowHeight = love.graphics.getDimensions()

  -- Background
  love.graphics.setColor({ 1, 0, 0, redAlpha })
  love.graphics.rectangle("fill", 0, 0, windowWidth / 2, windowHeight)
  love.graphics.setColor({ 0, 0, 1, blueAlpha })
  love.graphics.rectangle("fill", windowWidth / 2, 0, windowWidth / 2, windowHeight)
  love.graphics.setColor({ 1, 1, 1, 0.5 })
  love.graphics.rectangle("fill", windowWidth / 2 - 2, 0, 4, windowHeight)
  love.graphics.setColor({ 1, 1, 1, 1 })

  GameManager.draw()

  local player1Score, player2Score = GameManager.getPlayersScore()
  UIManager.drawScore(player1Score, player2Score)

  if currentScene == SCENE_STATE.MENU then
    UIManager.drawMenu()
  elseif currentScene == SCENE_STATE.END then
    UIManager.drawEndScreen(player1Score, player2Score)
  end
end

-- KEY PRESS

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if key == "space" then
    if currentScene == SCENE_STATE.MENU or currentScene == SCENE_STATE.END then
      GameManager.load()
      SoundManager.playBGM()
      currentScene = SCENE_STATE.GAME
    end
  end
end
