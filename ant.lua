
Ant = {}
Iter = 0

function Ant:load()
  self.x      = 500
  self.y      = love.graphics.getHeight() / 2
  self.width  = 5
  self.height = 5
  self.speed  = 1000
end

function Ant:update(dt)
  Iter = Iter + dt
  self.x = 200 + math.sin(Iter) * 100
  self.y = 200 + math.sin(Iter / 1.5) * 100

  if self.y < 0 then
    self.y = 0
  end
end

function Ant:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
