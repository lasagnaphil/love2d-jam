local systems = { update = {} }

systems.update.god = System(
    {"god"},
    function(data, dt)
        data.timer = data.timer - dt
        if data.timer < 0 then
            local width = data.platformWidth:random()
            local height = data.platformHeight
            for i = 1, width do
                local block = clone(prefabs.block)
                block.position.x = 0
                block.position.y = 240 + data.platformYBound:random() * block.collider.w
                entities:add(block)
            end
            data.timer = data.platformFreq:random()
        end
    end
)

return systems
