local systems = {
    load = {},
    update = {},
    draw = {},
    globals = {}
}

systems.globals.world = bump.newWorld(32)

systems.update.movement = System(
    {'position', 'velocity', '!physicsBody'},
    function (p, v, dt)
        p.x = p.x + v.x * dt
        p.y = p.y + v.y * dt
    end)

systems.draw.sprite = System(
    {'position', 'sprite'},
    function (pos, sprite)
        love.graphics.draw(sprite.image, pos.x, pos.y)
    end
)

systems.load.sprite = System(
    {'sprite'},
    function (sprite)
        sprite.image = love.graphics.newImage(sprite.filename)
    end
)

systems.update.animSprite = System(
    {'position', 'animSprite'},
    function (pos, sprite, dt)
        sprite.animation:update(dt)
    end
)

systems.load.animSprite = System(
    {'animSprite'},
    function (sprite)
        sprite.image = love.graphics.newImage(sprite.filename)
        sprite.grid = anim8.newGrid(sprite.size.w, sprite.size.h, sprite.image:getWidth(), sprite.image:getHeight())
        sprite.animation = anim8.newAnimation(sprite.grid(unpack(sprite.curFrame)), 1/(30*sprite.speed))
    end
)

systems.draw.animSprite = System(
    {'position', 'animSprite'},
    function (pos, sprite)
        sprite.animation:draw(sprite.image, pos.x, pos.y)
    end
)

local gravAccel = 500
local world = systems.globals.world

systems.load.collider = System(
    {'position', 'collider', '_entity'},
    function (pos, col, entity)
        world:add(entity, pos.x, pos.y, col.w, col.h)
    end
)
systems.update.physics = System(
    {'position', 'velocity', 'physicsBody', 'collider', '_entity'},
    function (pos, vel, body, col, entity, dt)
        vel.y = vel.y + gravAccel * dt
        world:update(entity, pos.x, pos.y, col.w, col.h)
        local actualX, actualY, cols, len =
            world:move(entity, pos.x + vel.x * dt, pos.y + vel.y * dt)

        col.events = cols
        pos.x, pos.y = actualX, actualY
    end
)

return systems
