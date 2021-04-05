

Wall = {}
H = love.graphics.getHeight()
W = love.graphics.getWidth()

function Wall:load()
  self.isStatic = true
end

function Wall:draw()
  love.graphics.setColor(135,62,35)                       -- Brown color
  love.graphics.rectangle('fill', 0, 0, 10, H)            -- Left
  love.graphics.rectangle('fill', W - 10, 0, 10, H)       -- Right
  love.graphics.rectangle('fill', 10, 0, W - 20, 10)      -- Top
  love.graphics.rectangle('fill', 10, H - 10, W - 20, 10) -- Bottom
end
