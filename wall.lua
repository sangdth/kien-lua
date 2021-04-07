local Wall = {}

function Wall:load()
  self.x = 10
  self.y = 10
  self.width = love.graphics.getWidth() - 20
  self.height = love.graphics.getHeight() - 20
  self.isStatic = true
end

function Wall:draw()
  local count = World:countItems()
  love.graphics.print('Total objects: '..count, WW - 200, WH - 40)
  love.graphics.setColor(120/255, 120/255, 120/255)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

return Wall
