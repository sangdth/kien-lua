require('helpers')

Object = require('classic')

-- Array of all ants
AntEmpire = {}
Ant = Object:extend()

local iter = 0
local randomPosition = { x = 20, y = 20 }

function Ant:new()
  self.x          = 20
  self.y          = 20
  self.direction  = 0       -- radians
  self.width      = 6
  self.height     = 6
  self.speed      = 80
  self.lastSignal = 0
  self.hasFood    = false
end

function Ant:update(dt)
  Ant.move(self, dt)
end

function Ant:draw()
  love.graphics.setColor(163/255, 15/255, 32/255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

-- Declaration functions here, keep the load/update/draw clean
function Ant:move(d)
  iter = iter + 1

  local currentPosition = {
    x = self.x,
    y = self.y,
    direction = self.direction,
  }

  local w = love.math.random(6)
  if iter >= 10 * w then
    iter = 0
    randomPosition = GetRandomCoordinates(currentPosition)
  end

  local speed = GAME_SPEED * self.speed
  local newPosition = Predict(currentPosition, randomPosition, speed)

  self.x = GetLerp(currentPosition.x, newPosition.x, d)
  self.y = GetLerp(currentPosition.y, newPosition.y, d)
end

-- use this one to born new ant later
function Ant:goOut()
  -- local next = GetRandomCoordinates(0, 0)
end

function Ant:collide()
end
