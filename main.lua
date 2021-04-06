local Wall = require 'wall'
local Ant = require 'ant'
local Food = require 'food'
local bump = require 'bump'

-- Global constants
GAME_SPEED  = 2
SPAWN_SPEED = 1 -- looks like it is second
MAX_ANTS    = 100000
TOTAL_FOOD  = 400

World = bump.newWorld(10)

-- Entities storage
local Ants = {}
local Foods = {}
local AntTimer = 60

function love.load()
  Wall:load()

  for i = TOTAL_FOOD, 1, -1
  do
    for j = math.sqrt(TOTAL_FOOD), 1, -1
    do
      local x = WW / 4 + (i % math.sqrt(TOTAL_FOOD)) * 11
      local y = WH / 4 + j * 11
      local food = Food(x, y)
      table.insert(Foods, food)
    end
  end
end

function love.update(dt)
  AntTimer = AntTimer + 1

  Counter = 60 * SPAWN_SPEED
  if AntTimer >= Counter and table.maxn(Ants) < MAX_ANTS then
    local babyAnt = Ant(30, 30)
    table.insert(Ants, babyAnt)

    AntTimer = 0
  end

  for i,ant in ipairs(Ants) do
    ant:update(dt)
  end
end

function love.draw()
  Wall:draw()

  for i,food in ipairs(Foods) do
    food:draw()
  end

  for i,ant in ipairs(Ants) do
    ant:draw()
  end
end
