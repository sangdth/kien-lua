require('helpers')

Object = require('classic')

-- Array of all ants
AntEmpire = {}
local Ant = Object:extend()

local iter = 0

function Ant:new(x, y)
  self.x          = x or 30
  self.y          = y or 30
  self.direction  = 0       -- radians
  self.width      = 6
  self.height     = 6
  self.speed      = 80
  self.lastSignal = 0
  self.hasFood    = false
  self.random     = { x = 30, y = 30, direction = 0 }
end

function Ant:update(d)
  iter = iter + 1
  local speed = GAME_SPEED * self.speed
  local randomFactor = love.math.random(0, iter) * iter
  local currentPosition = { x = self.x, y = self.y, direction = self.direction }

  if iter >= 20 then
    iter = 0 -- reset
    self.random = GetRandomCoordinates(currentPosition, randomFactor)
  end
  local newPosition = Predict(currentPosition, self.random, speed)

  Ant.move(self, newPosition, d)
end

function Ant:draw()
  love.graphics.setColor(163/255, 15/255, 32/255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

-- Declaration functions here, keep the load/update/draw clean
-- LOL The move function applies to ALL ants, this is bad :D
function Ant:move(newPosition, d)
  self.x = GetLerp(self.x, newPosition.x, d)
  self.y = GetLerp(self.y, newPosition.y, d)
end

-- use this one to born new ant later
function Ant:goOut()
  -- local next = GetRandomCoordinates(0, 0)
end

function Ant:collide()
end

return Ant
