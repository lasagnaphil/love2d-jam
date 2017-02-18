local systems = { update = {} }

systems.update.player = System(
    {'position', 'velocity', 'collider', 'player'},
    function (pos, vel, col, player, dt)
        player.onGround = false
        for _, event in ipairs(col.events) do
            if event.other.name == "block" and pos.y < event.other.position.y then
                player.onGround = true
            end
        end
        if love.keyboard.isDown('left') then
            if (vel.x - player.accel * dt) > -player.speed then
                vel.x = vel.x - player.accel * dt
            end
        elseif love.keyboard.isDown('right') then
            if (vel.x + player.accel * dt) < player.speed then
                vel.x = vel.x + player.accel * dt
            end
        else
            local brake = (vel.x < 0 and player.decel or -player.decel) * dt
            if math.abs(brake) > math.abs(vel.x) then
                vel.x = 0
            else
                vel.x = vel.x + brake
            end
        end
        if love.keyboard.isDown('up') and player.onGround then
            vel.y = -player.jumpVel
        end
    end
)

return systems
