local Wall = require 'wall'
local Ant = require 'ant'
local Food = require 'food'
local bump = require 'bump'

GAME_SPEED  = 2
SPAWN_SPEED = 1 -- looks like it is second
MAX_ANTS    = 10000

World = bump.newWorld(10)

-- Entities storage
local Ants = {}
local AntTimer = 0

function love.load()
  Wall:load()
  Food:load()
end

function love.update(dt)
  Food:update(dt)
  AntTimer = AntTimer + 1

  Counter = 60 * SPAWN_SPEED
  if AntTimer >= Counter and table.maxn(Ants) < MAX_ANTS then
    local babyAnt = Ant(30, 30)
    table.insert(Ants, babyAnt)

    World:add(babyAnt, 30, 30, 10, 10)
    AntTimer = 0
  end

  for i,ant in ipairs(Ants) do
    ant:update(dt)

    -- if ant.life <= 0 then
    --   world:remove(ant)
    -- end
  end
end

function love.draw()
  Wall:draw()
  Food:draw()

  for i,ant in ipairs(Ants) do
    ant:draw()
  end
end
