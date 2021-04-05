require('wall')
require('ant')
require('food')

function love.load()
  Wall:load()
  Ant:load()
  Food:load()
end

function love.update(dt)
  Ant:update(dt)
  Food:update(dt)
end

function love.draw()
  Wall:draw()
  Ant:draw()
  Food:draw()
end
