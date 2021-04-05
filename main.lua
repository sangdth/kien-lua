require('wall')
require('food')
require('ant')

-- Object = require 'classic'

GAME_SPEED = 2
MAX_ANTS = 100

-- Entities storage
Ants = {}

function love.load()
  Wall:load()
  Food:load()
end

function love.update(dt)
  Food:update(dt)

  for i,ant in ipairs(Ants) do
    ant:update(dt)
  end
end

function love.draw()
  Wall:draw()
  Food:draw()

  for i,ant in ipairs(Ants) do
    ant:draw()
  end
end
