require('helpers')

local Object = require 'classic'

-- Some default settings for Ants
LIFE_COST_IDLE  = 0.1
LIFE_COST_WORK  = 0.2
LIFE_COST_FIGHT = 1

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
  self.life       = 1000
  self.random     = { x = 30, y = 30, direction = 0 }
end

function Ant:update(d)
  iter = iter + 1
  local speed = GAME_SPEED * self.speed
  local randomFactor = love.math.random(0, iter) * iter
  local currentPosition = { x = self.x, y = self.y, direction = self.direction }

  -- Ants at work die faster than idle
  if self.hasFood and self.life > 0 then
    self.life = self.life - LIFE_COST_WORK
  else
    self.life = self.life - LIFE_COST_IDLE
  end

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
  local x = GetLerp(self.x, newPosition.x, d)
  local y = GetLerp(self.y, newPosition.y, d)

  self.x = x
  self.y = y
end

-- use this one to born new ant later
function Ant:goOut()
  -- local next = GetRandomCoordinates(0, 0)
end

function Ant:checkCollide(obj)
  local isCollided = CheckCollision(self, obj)
  if isCollided then
    local x,y
    if self.x < obj.x + obj.width then
      x = self.x - 10
    else
      x = self.x + 10
    end
    if self.y < obj.y + obj.height then
      y = self.y - 10
    else
      y = self.y + 10
    end
    Ant:move({ x = x, y = y }, 0.1)
  end
end

return Ant
