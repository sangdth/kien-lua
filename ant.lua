require('helpers') -- global helpers/funcs/constants

local Object = require 'classic'
local Pheromone = require 'pheromone'

-- Some default settings for Ants
local LIFE_COST_IDLE  = 0.1
local LIFE_COST_WORK  = 0.2
-- local LIFE_COST_FIGHT = 1

-- Extend Ant class from Object
local Ant = Object:extend()

local iterator = {
  random = 0,
  pheromone = 0,
}

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
  self.harvesting = false
  self.timer      = 0
  self.life       = 1000
  self.goNext     = { x = 30, y = 30, direction = 0 }
end

function Ant:update()
  -- Start counting the iterator
  iterator.random = iterator.random + 1
  iterator.pheromone = iterator.pheromone + 1

  local speed = GAME_SPEED * self.speed
  local randomFactor = love.math.random(0, iterator.random)
  local currentPosition = { x = self.x, y = self.y, direction = self.direction }
  local newPosition

  -- Ants at work die faster than idle
  if self.hasFood and self.life > 0 then
    self.life = self.life - LIFE_COST_WORK
  elseif self.life > 0 then
    self.life = self.life - LIFE_COST_IDLE
  end

  if iterator.random >= 20 then
    iterator.random = 0 -- reset the random move

    if self.hasFood then
      self.goNext = NEST_COOR
    else
      self.goNext = GetRandomCoordinates(currentPosition, randomFactor)
    end
  end

  -- FIXME: The ant speed makes the release of pheromone
  --        not consistent any more. Still don't know why
  --        sometimes it just disappear :D
  if iterator.pheromone >= 10 then
    iterator.pheromone = 0 -- reset the pheromone

    if self.hasFood and not self.harvesting then
      local p = Pheromone(self.x, self.y)
      World:add(p, p.x, p.y, p.radius * 2, p.radius * 2)
      table.insert(Pheromones, p)
    end
  end

  newPosition = Predict(currentPosition, self.goNext, speed)

  if self.harvesting and not self.hasFood then
    if self.timer > 0 then
      newPosition = currentPosition
      self.timer = self.timer - 1     -- keep harvesting
    else
      self.hasFood = true
      self.harvesting = false
      self.speed = self.speed / 2
      self.goNext = { x = 20, y = 20 } -- has food, bring back to nest
    end
  end

  if self.life > 10 then
    Ant.move(self, newPosition)
  end
end

function Ant:draw()
  if self.harvesting or self.hasFood then
    love.graphics.setColor(160/255, 100/255, 30/255)
  elseif self.life <= 10 then
    love.graphics.setColor(180/255, 30/255, 30/255)
  elseif self.life <= 0 then
    love.graphics.setColor(100/255, 90/255, 90/255)
  else
    love.graphics.setColor(60/255, 160/255, 30/255)
  end
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 1, 1)
end

function Ant:move(p)
  local actualX, actualY, cols, len = World:move(self, p.x, p.y, AntFilter)

  for i=1,len do
    local other = cols[i].other
    if other.name == 'food' and self.timer == 0 then
      self.harvesting = true
      self.timer = 30
    elseif other.name == 'nest' and self.hasFood then
      self.hasFood = false
    end
  end

  self.x = actualX
  self.y = actualY
end

  -- return 'touch', 'bounce', 'cross', 'slide'
function AntFilter(_, other) -- it is (item, other)
  local m = other.name
  if     m == 'pheromone'   then  return 'cross'
  elseif m == 'nest'        then  return 'cross'
  elseif m == 'food'        then  return 'slide'
  else                            return 'slide'
  end
end

return Ant
