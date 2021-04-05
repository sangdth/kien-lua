
Food = {}

function Food:load()
  self.x      = 900
  self.y      = love.graphics.getHeight() / 2
  self.width  = 100
  self.height = 100
  self.speed  = 0
end


function Food:update(dt)
end

function Food:draw()
  love.graphics.setColor(63/255, 165/255, 32/255)
  love.graphics.circle("fill", self.x, self.y, self.width)
  love.graphics.setColor(1, 1, 1)
end
