Ant = {}

function Ant:load()
  self.x      = 50
  self.y      = love.graphics.getHeight() / 2
  self.width  = 5
  self.height = 5
  self.speed  = 10
end

function Ant:update(dt)
  
end

function Ant:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
