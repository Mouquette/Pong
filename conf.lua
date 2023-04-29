local DEBUG = false

function love.conf(t)
  t.window.title = "Pong"

  if DEBUG then
    t.console = true
    t.window.width = 1024
    t.window.height = 768
  else
    t.console = false
    t.window.width = 1920
    t.window.height = 1080
    t.window.fullscreen = true
  end

  t.modules.data = false
  t.modules.joystick = false
  t.modules.physics = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end
