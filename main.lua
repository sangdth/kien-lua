require('wall')
require('ant')
require('food')

function love.load()
  -- Wall:load()
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

function CheckCollision(a, b)
  if (
    a.x + a.width > b.x and
    a.x < b.x + b.width and
    a.y + a.height > b.y and
    a.y < b.y + b.height
  ) then
    return true
  else
    return false
  end
end
