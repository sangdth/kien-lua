local Object = require 'classic'

local Pheromone = Object:extend()

local FADING_RATE = 0.1

function Pheromone:new(x, y)
  self.name     = 'pheromone'
  self.x        = x
  self.y        = y
  self.radius   = 5
  self.life     = 100
end

function Pheromone:update()
  self.life = self.life - FADING_RATE
end

function Pheromone:draw()
  love.graphics.setColor(20/255, 100/255, 255/255, self.life / self.life * 2)
  love.graphics.circle('fill', self.x + 5, self.y + 5, self.radius)
  love.graphics.setColor(1, 1, 1)
end

return Pheromone
