
Ant = {}
Iter = 0
MaxWallRight = love.graphics.getWidth()
MaxWallBottom = love.graphics.getHeight()

function Ant:load()
  self.x      = love.graphics.getWidth() / 2
  self.y      = love.graphics.getHeight() / 2
  self.width  = 5
  self.height = 5
  self.speed  = 1000
end

function Ant:checkWalls()
  if self.x < 0 then
    self.x = 1
  elseif self.x >= 800 then
    self.x = 800
  elseif self.y < 0 then
    self.y = 1
  elseif self.y > 600 then
    self.y = 600
  else
    self.x = 1
    self.y = 1
  end
end

function Ant:move(dt)
  Iter = Iter + dt
  self.x = math.sin(Iter) * love.graphics.getWidth()
  self.y = math.sin(Iter / 1.5) * love.graphics.getHeight()
end

function Ant:update(dt)
  Ant:move(dt)
  Ant:checkWalls()
end

function Ant:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
