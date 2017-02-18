require 'strict'

System = require 'plugins.knife.system'
anim8 = require 'plugins.anim8'
bump = require 'plugins.bump'
inspect = require 'plugins.inspect'
range = require 'util.range'
entities, prefabs = (require 'entities')()

systems = { load = {}, update = {}, draw = {} }
systemModules = {
    "main_systems", "player_system", "god_system"
}

local systemTypes = {'load', 'update', 'draw'}
for _, moduleName in ipairs(systemModules) do
    for _, systemType in ipairs(systemTypes) do
        local moduleSystems = require("systems/" .. moduleName)
        if moduleSystems[systemType] then
            for name, system in pairs(moduleSystems[systemType]) do
                systems[systemType][name] = system
            end
        end
    end
end

love.graphics.setDefaultFilter('nearest', 'nearest')

local canvas = love.graphics.newCanvas(800, 600)

local SCALE = 1

function love.load()
    for _, entity in ipairs(entities) do
        for _, system in pairs(systems.load) do
            system(entity)
        end
    end
end

function love.update(dt)
    for _, entity in ipairs(entities.toAdd) do
        for _, system in pairs(systems.load) do
            system(entity)
            entities[#entities + 1] = entity
        end
    end
    entities.toAdd = {}
    for _, entity in ipairs(entities) do
        if entity.isEnabled ~= false then
            for _, system in pairs(systems.update) do
                system(entity, dt)
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setCanvas(canvas)
    love.graphics.clear(255, 255, 255, 255)
    for _, entity in ipairs(entities) do
        if entity.isEnabled ~= false then
            for _, system in pairs(systems.draw) do

                system(entity)
            end
        end
    end
    love.graphics.setCanvas()
    love.graphics.draw(canvas, 0, 0, 0, SCALE, SCALE)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "r" then
        -- reload the game
    end
end
