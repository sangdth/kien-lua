WW = love.graphics.getWidth()
WH = love.graphics.getHeight()

function GetDistance(source, target)
  if not source or not target then
    return nil
  end

  local x = target.x - source.x
  local y = target.y - source.y

  local value = math.sqrt(x * x + y * y)

  return { x = x, y = y, value = value }
end

function GetLerp(v0, v1, t)
  return (1 - t) * v0 + t * v1
end

function GetAngularLerp(a0, a1, t)
  local max = math.pi * 2
  local da = (a1 - a0) % max
  local shortestAngle = ((2 * da) % max) - da
  return a0 + (shortestAngle * t)
end

function Predict(current, destination)
  local distance = GetDistance(current,  destination)

  if distance == nil then
    return current
  end

  local direction = math.atan2(distance.y, distance.x)
  local dx = SPEED * math.cos(direction)
  local dy = SPEED * math.sin(direction)

  if distance.value < 50 then
    dx = dx * distance.value / 50
    dy = dy * distance.value / 50
  end

  return {
    x = current.x + dx,
    y = current.y + dy,
    direction = direction
  }
end

function CheckCollision(a, b)
  if (
    a.x + a.width > b.x and
    a.x < b.x + b.width and
    a.y + a.height > b.y and
    a.y < b.y + b.height
  ) then
    return true
  else
    return false
  end
end

function GetBounded(o)
  local newX = o.x
  local newY = o.y

  if newX < 10 then
    newX = 10
  elseif newX >= WW - 20 then
    newX = WW - 20
  end

  if newY < 10 then
    newY = 10
  elseif newY >= WH - 20 then
    newY = WH - 20
  end

  return { x = newX, y = newY }
end

function GetRandomCoordinates(o)
  local step = love.math.random(-10, 10)
  local newX = love.math.random(o.x - 10 * step, o.x + 10 * step)
  local newY = love.math.random(o.y - 10 * step, o.y + 10 * step)

  return GetBounded({ x = newX, y = newY })
end
