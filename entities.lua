require('util.tcopy')

local player = {
    name = 'player',
    isEnabled = true,
    position = { x = 100, y = 100 },
    velocity = { x = 0, y = 0},
    player = {
        accel = 2000,
        decel = 2000,
        speed = 200,
        jumpVel = 400,
        inAir = false,
        onGround = true
    },
    physicsBody = {
    },
    collider = {
        w = 32,
        h = 32,
        events = {}
    },
    animSprite = {
        filename = "sprites/skeleton.png",
        size = { w = 32, h = 32 },
        frames = {
            stand = {1, 1},
            runLeft = {3, 2},
            runRight = {2, 2}
        },
        curFrame = {1, 1},
        image = nil,
        grid = nil,
        animation = nil,
        speed = 1/3,
    },
}

local god = {
    name = "blockSpawner",
    isEnabled = true,
    god = {
        timer = 0,
        platformFreq = RangeFloat(1, 3),
        platformWidth = RangeInt(4, 6),
        platformHeight = 3,
        platformGap = RangeInt(2, 4),
        platformYBound = RangeInt(-4, 4),
        curPlatformFreq = 0
    }
}

local camera = {
    name = "camera",
    camera = {

    }
}

local block = {
    name = "block",
    isEnabled = true,
    position = { x = 200, y = 200 },
    collider = {
        w = 32,
        h = 32
    },
    sprite = {
        filename = "sprites/tile/BrickTiles.png",
        rect = nil,
        image = nil
    },
}

function createBlock(x, y)
    local b = clone(block)
    b.position.x = x
    b.position.y = y
    return b
end

local prefabs = {
    block = block
}

local entities = {
    player,
    camera,
    god,
    createBlock(96, 200),
    createBlock(128, 200),
    createBlock(224, 200),
    toAdd = {},
    add = function(self, entity)
        self.toAdd[#self.toAdd + 1] = entity
    end
}

return function() return entities, prefabs end
