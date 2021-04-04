
Ant = {}
Iter = 0

function Ant:load()
  self.x      = 500
  self.y      = love.graphics.getHeight() / 2
  self.width  = 5
  self.height = 5
  self.speed  = 1000
end

function Ant:checkWalls()
  -- Check only the top/left, need to do botto/right
  if self.x < 0 then
    self.x = 0
  elseif self.y < 0 then
    self.y = 0
  end
end

function Ant:move(dt)
  Iter = Iter + dt
  self.x = 100 + math.sin(Iter) * 100
  self.y = 100 + math.sin(Iter / 1.5) * 100
end

function Ant:update(dt)
  Ant:move(dt)
  Ant:checkWalls()
end

function Ant:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
