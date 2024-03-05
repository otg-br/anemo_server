local spawnVeins = GlobalEvent("veinsStones7")
local itemsList = { 
    {itemId = 26410, quantity = 7},
}

local STARTUP = {}

STARTUP[#STARTUP + 1] = { 
    action = function()
        local fromPos = {x=421, y=442, z=7}
        local toPos = {x=582, y=511, z=7}
        for _, item in ipairs(itemsList) do
            for i = 1, item.quantity do
                local pos = {x=math.random(fromPos.x,toPos.x), y=math.random(fromPos.y,toPos.y), z=math.random(fromPos.z,toPos.z)}
                local tileInfo = getTileInfo(pos)
                if tileInfo and tileInfo.items == 0 and tileInfo.creatures == 0 then 
                    addEvent(function()doCreateItem(item.itemId, 1, pos)end, 1000)
                end
            end 
        end
    end
}

function spawnVeins.onStartup()
    for _, cmd in pairs(STARTUP) do
        if (cmd.msg) then
            local x = os.clock()
            cmd.action()
        else
            cmd.action()
        end
    end

    STARTUP = nil 
    return true
end

spawnVeins:register()
