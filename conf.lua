local DEBUG = false

function love.conf(t)
  t.window.title = "Pong"
  t.window.width = 1024
  t.window.height = 768

  t.console = DEBUG

  t.modules.data = false
  t.modules.joystick = false
  t.modules.physics = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end
