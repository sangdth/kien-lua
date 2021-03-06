local Object = require 'classic'

local Food = Object:extend()

function Food:new(x, y)
  self.name     = 'food'
  self.x        = x
  self.y        = y
  self.width    = 20
  self.height   = 20
  self.density  = 100
  World:add(self, self.x, self.y, self.width, self.height)
end

function Food:update()
end

function Food:draw()
  love.graphics.setColor(200/255, 200/255, 200/255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

return Food
