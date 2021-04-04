
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
  love.graphics.circle("fill", self.x, self.y, self.width)
end
