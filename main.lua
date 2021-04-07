local Ant  = require 'ant'
local Food = require 'food'
local Nest = require 'nest'
local Wall = require 'wall'
local bump = require 'bump'

-- Global constants
GAME_SPEED  = 2 -- x2 times of game
SPAWN_SPEED = 1 -- looks like it is second
MAX_ANTS    = 100000
TOTAL_FOOD  = 100
NEST_COOR   = { x = WW / 2 - 50, y = WH / 2 - 50}

World = bump.newWorld(10)

-- Entities storage
local Ants = {}
local Foods = {}
local AntTimer = 60
local nest

function love.load()
  nest = Nest(NEST_COOR.x, NEST_COOR.y)
  Wall:load()

  for i = TOTAL_FOOD, 1, -1
  do
    for j = math.sqrt(TOTAL_FOOD), 1, -1
    do
      local x = 60 + (i % math.sqrt(TOTAL_FOOD)) * 21
      local y = 430 + j * 21
      local food = Food(x, y)
      table.insert(Foods, food)
    end
  end
end

function love.update(dt)
  nest:update()

  AntTimer = AntTimer + 1

  local counter = 60 * SPAWN_SPEED
  if AntTimer >= counter and table.maxn(Ants) < MAX_ANTS then
    local babyAnt = Ant(NEST_COOR.x, NEST_COOR.y)
    table.insert(Ants, babyAnt)

    AntTimer = 0
  end

  for _,ant in ipairs(Ants) do
    ant:update(dt)
  end
end

function love.draw()
  nest:draw()
  Wall:draw()

  for _,food in ipairs(Foods) do
    food:draw()
  end

  for _,ant in ipairs(Ants) do
    ant:draw()
  end
end
