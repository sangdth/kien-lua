require('helpers')

Object = require('classic')

-- Array of all ants
AntEmpire = {}
Ant = {}
-- Ant = Object.extend(Object)

local iter = 0
local randomPosition = { x = 20, y = 20 }

function Ant:load()
  self.x          = 20
  self.y          = 20
  self.direction  = 0       -- radians
  self.width      = 4
  self.height     = 4
  self.speed      = 90
  self.lastSignal = 0
  self.hasFood    = false
end

function Ant:update(dt)
  Ant:move(dt)
end

function Ant:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

-- Declaration functions here, keep the load/update/draw clean
function Ant:move(d)
  iter = iter + 1

  local currentPosition = { x = self.x, y = self.y, direction = self.direction }
  print(currentPosition)

  local w = love.math.random(6)
  if iter >= 10 * w then
    iter = 0
    randomPosition = GetRandomCoordinates(currentPosition)
  end

  local newPosition = Predict(currentPosition, randomPosition)

  self.x = GetLerp(currentPosition.x, newPosition.x, d)
  self.y = GetLerp(currentPosition.y, newPosition.y, d)
end

-- use this one to born new ant later
function Ant:goOut()
  -- local next = GetRandomCoordinates(0, 0)
end

function Ant:collide()
end
