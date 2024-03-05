local config = {
    bossName = "prince skeletal",
    bossPosition = Position(639, 930, 8), 
    bossArea = {
        fromPos = Position(598, 912, 8), 
        toPos = Position(648, 950, 8), 
    },
}

local transformationEvent = nil

function transformTiles(fromPos, toPos)
    for x = fromPos.x, toPos.x do
        for y = fromPos.y, toPos.y do
            local tile = Tile({x = x, y = y, z = fromPos.z})
            if tile then
                local item = tile:getItemById(26671)
                if item then
                    item:transform(26659)
                end
            end
        end
    end

    addEvent(function()
        for x = fromPos.x, toPos.x do
            for y = fromPos.y, toPos.y do
                local tile = Tile({x = x, y = y, z = fromPos.z})
                if tile then
                    local item = tile:getItemById(26659)
                    if item then
                        item:transform(26671)
                    end
                end
            end
        end
    end, 6000)
end

local princeSkeletal = GlobalEvent("princeSkeletalTiles")

function princeSkeletal.onThink(creature, interval)

    local boss = Tile(config.bossPosition):getBottomCreature()
    if not boss or not boss:isMonster() or boss:getName():lower() ~= config.bossName then
        return true
    end
    transformTiles(config.bossArea.fromPos, config.bossArea.toPos)
    return true
end

princeSkeletal:interval(25000)
princeSkeletal:register()