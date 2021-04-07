local Ant  = require 'ant'
local Food = require 'food'
local Nest = require 'nest'
local Wall = require 'wall'
local bump = require 'bump'

-- Global constants
GAME_SPEED  = 2 -- x2 times of game
SPAWN_SPEED = 1 -- looks like it is second
MAX_ANTS    = 100000
TOTAL_FOOD  = 81
NEST_COOR   = { x = WW / 2 - 50, y = WH / 2 - 50}

World = bump.newWorld(10)
Pheromones = {}   -- FIXME: Find a better way

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
    local ant = Ant(NEST_COOR.x, NEST_COOR.y)
    table.insert(Ants, ant)
    World:add(ant, ant.x, ant.y, ant.width, ant.height)

    AntTimer = 0
  end

  -- FIXME: Loop from table is not good when add/remove
  --        on huge number, it might has problem, or isn't it?
  for i,ant in ipairs(Ants) do
    ant:update(dt)
    if World:hasItem(ant) and ant.life <= 0 then
      World:remove(ant)
      table.remove(Ants, i)
    end
  end

  for i,p in ipairs(Pheromones) do
    p:update()
    if World:hasItem(p) and p.life <= 0 then
      World:remove(p)
      table.remove(Pheromones, i)
    end
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

  for _,p in ipairs(Pheromones) do
    p:draw()
  end
end
