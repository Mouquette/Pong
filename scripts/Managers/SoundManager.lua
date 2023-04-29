local SoundManager = {}

local BGM_SOUND = love.audio.newSource("assets/sounds/music.mp3", "stream")
BGM_SOUND:setLooping(true)

local SFX_SOUNDS = {
  wallBounce = love.audio.newSource("assets/sounds/wall_bounce.wav", "static"),
  playerBounce = love.audio.newSource("assets/sounds/player_bounce.wav", "static"),
  goal = love.audio.newSource("assets/sounds/goal.wav", "static")
}

-- BGM FUNCTIONS

function SoundManager.playBGM()
  BGM_SOUND:play()
end

function SoundManager.stopBGM()
  BGM_SOUND:stop()
end

-- SFX FUNCTIONS

function SoundManager.playWallBounce()
  SFX_SOUNDS.wallBounce:play()
end

function SoundManager.playPlayerBounce()
  SFX_SOUNDS.playerBounce:play()
end

function SoundManager.playGoal()
  SFX_SOUNDS.goal:play()
end

return SoundManager
