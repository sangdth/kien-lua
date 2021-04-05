require('wall')
require('ant')
require('food')

SPEED = 100
MAX_ANTS = 100

function love.load()
  Wall:load()
  -- ant1 = Ant()
  Ant:load()
  Food:load()
end

function love.update(dt)
  -- ant1:update(dt)
  Ant:update(dt)
  Food:update(dt)
end

function love.draw()
  Wall:draw()
  Ant:draw()
  -- ant1:draw()
  Food:draw()
end
