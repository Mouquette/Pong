local UIManager = {}

local Player = require("scripts.Entities.player")

local FONTS = {
  SCORE = love.graphics.newFont("assets/font/poxel-font.ttf", 40),
  BODY_1 = love.graphics.newFont("assets/font/poxel-font.ttf", 26),
  BODY_2 = love.graphics.newFont("assets/font/poxel-font.ttf", 36),
  CAPTION = love.graphics.newFont("assets/font/poxel-font.ttf", 18)
}

local player1Color
local player2Color

local spaceTime = 0
local ShowSpaceText = true

function UIManager.load(color1, color2)
  player1Color = color1
  player2Color = color2
end

function UIManager.update(dt)
  spaceTime = spaceTime + dt
  if spaceTime > 0.3 then
    ShowSpaceText = not ShowSpaceText
    spaceTime = 0
  end
end

local function Overlay()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  love.graphics.setColor({ 0, 0, 0, 0.7 })
  love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
end

local function SpaceText()
  local windowWidth, windowHeight = love.graphics.getDimensions()

  love.graphics.setColor({ 1, 1, 1, 1 })
  if ShowSpaceText then
    love.graphics.setFont(FONTS.BODY_2)
    local StartText = "Appuyez sur ESPACE pour commencer la partie"
    love.graphics.print(StartText, (windowWidth - FONTS.BODY_2:getWidth(StartText)) / 2, windowHeight / 2 + 100, 0)
  end
end

function UIManager.drawMenu()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  Overlay()

  love.graphics.setFont(FONTS.BODY_1)
  love.graphics.setColor({ 1, 1, 1, 1 })

  local player1Text = "Joueur 1 : Touche A pour monter, touche Q pour descendre"
  love.graphics.print(player1Text, (windowWidth - FONTS.BODY_1:getWidth(player1Text)) / 2, windowHeight / 2 - 50, 0)

  local player2Text = "Joueur 2 : Touche Haut pour monter, touche Bas pour descendre"
  love.graphics.print(player2Text, (windowWidth - FONTS.BODY_1:getWidth(player2Text)) / 2, windowHeight / 2, 0)

  SpaceText()

  love.graphics.setFont(FONTS.CAPTION)
  local caption = "Game By Mouky"
  love.graphics.print(caption, (windowWidth - FONTS.CAPTION:getWidth(caption)) / 2, windowHeight - 50, 0)
end

function UIManager.drawEndScreen(player1Score, player2Score)
  local windowWidth, windowHeight = love.graphics.getDimensions()
  Overlay()

  love.graphics.setFont(FONTS.BODY_2)

  if player1Score > player2Score then
    love.graphics.setColor(player1Color)

    local player1WinText = "Joueur 1 gagne la partie"
    local textX = (windowWidth - FONTS.BODY_2:getWidth(player1WinText)) / 2
    love.graphics.print(player1WinText, textX, windowHeight / 2 - 40)
  else
    love.graphics.setColor(player2Color)

    local player2WinText = "Joueur 2 gagne la partie"
    local textX = (windowWidth - FONTS.BODY_2:getWidth(player2WinText)) / 2
    love.graphics.print(player2WinText, textX, windowHeight / 2 - 40)
  end

  SpaceText()
end

function UIManager.drawScore(player1Score, player2Score)
  local windowWidth, windowHeight = love.graphics.getDimensions()
  love.graphics.setFont(FONTS.SCORE)

  love.graphics.setColor(player1Color)
  love.graphics.print(tostring(player1Score), windowWidth / 2 - 60, 10, 0)

  love.graphics.setColor(player2Color)
  love.graphics.print(tostring(player2Score), windowWidth / 2 + 30, 10, 0)
end

return UIManager
