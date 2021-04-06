require('helpers')

local Object = require 'classic'

-- Some default settings for Ants
local LIFE_COST_IDLE  = 1
local LIFE_COST_WORK  = 0.2
-- local LIFE_COST_FIGHT = 1

-- Array of all ants
local Ant = Object:extend()

local iter = 0

function Ant:new(x, y)
  self.name       = 'ant'
  self.x          = x or 30
  self.y          = y or 30
  self.direction  = 0       -- radians
  self.width      = 10
  self.height     = 10
  self.speed      = 4
  self.lastSignal = 0
  self.hasFood    = false
  self.life       = 100
  self.goNext     = { x = 30, y = 30, direction = 0 }
  World:add(self, self.x, self.y, self.width, self.height)
end

function Ant:update(d)
  iter = iter + 1
  local speed = GAME_SPEED * self.speed
  local randomFactor = love.math.random(0, iter)
  local currentPosition = { x = self.x, y = self.y, direction = self.direction }

  -- Ants at work die faster than idle
  if self.hasFood and self.life > 0 then
    self.life = self.life - LIFE_COST_WORK
  elseif self.life > 0 then
    self.life = self.life - LIFE_COST_IDLE
  elseif self.life == 0 then
    Ant:die()
  end

  if iter >= 20 then
    iter = 0 -- reset
    self.goNext = GetRandomCoordinates(currentPosition, randomFactor)
  end
  local newPosition = Predict(currentPosition, self.goNext, speed)

  Ant.move(self, newPosition, d)
end

function Ant:draw()
  love.graphics.setColor(163/255, 15/255, 32/255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

-- Declaration functions here, keep the load/update/draw clean
-- LOL The move function applies to ALL ants, this is bad :D
function Ant:move(p, d)
  local actualX, actualY, cols, len = World:move(self, p.x, p.y, AntFilter)

  -- check cols with food and stick with it for 300ms // collectFood
  -- after taking food, change hasFood status of self
  -- and start release food signals after trigger bringFoodHome action
  -- after that trigger the goToFood until can not get food within a timer
  -- after that timer running out, start the roamingFindFood
  -- repeat

  for i=1,len do
    -- print('collided with ' .. tostring(cols[i].other))
  end

  self.x = actualX
  self.y = actualY
end

-- use this one to born new ant later
function Ant:goOut()
  -- local next = GetRandomCoordinates(0, 0)
end

function Ant:die()
  if World:hasItem(self) then
    print('removed item'..self)
    World:remove(self)
  end
end

function Ant:leaveSignal()

end

function AntFilter(item, other)
  return 'slide'
  -- if     other.isCoin   then return 'cross'
  -- elseif other.isWall   then return 'slide'
  -- elseif other.isExit   then return 'touch'
  -- elseif other.isSpring then return 'bounce'
  -- end
end

return Ant
