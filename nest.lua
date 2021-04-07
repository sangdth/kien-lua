local Object = require 'classic'

local Nest = Object:extend()

function Nest:new(x, y)
  self.name     = 'nest'
  self.x        = x
  self.y        = y
  self.width    = 100
  self.height   = 100
  self.radius   = 30
  World:add(self, self.x, self.y, self.width, self.height)
end

function Nest:update()
end

function Nest:draw()
  love.graphics.setColor(20/255, 60/255, 160/255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

return Nest
