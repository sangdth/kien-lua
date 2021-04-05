

Wall = {}

function Wall:load()
  self.x = 10
  self.y = 10
  self.width = love.graphics.getWidth() - 20
  self.height = love.graphics.getHeight() - 20
  self.isStatic = true
end

function Wall:draw()
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
