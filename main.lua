require('ant')
require('food')

function love.load()
  Ant:load()
  Food:load()
end

function love.update(dt)
  Ant:update(dt)
  Food:update(dt)
end

function love.draw()
  Ant:draw()
  Food:draw()
end
