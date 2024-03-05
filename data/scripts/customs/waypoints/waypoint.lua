
local waypointList = {
    [1] = {
        name = "Mordragor", 
        actionId = 7000,
        position = Position(1120, 428, 7),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
    [2] = {
        name = "Dolwatha",
        actionId = 7001,
        position = Position(436, 319, 7),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
    [3] = {
        name = "Falanaar",
        actionId = 7002,
        position = Position(621, 446, 7),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
    [4] = {
        name = "Death Valley",
        actionId = 7003,
        position = Position(1395, 429, 7),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
    [5] = {
        name = "Freewind",
        actionId = 7004,
        position = Position(1236, 1062, 6),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
    [6] = {
        name = "Arkeron",
        actionId = 7005,
        position = Position(1445, 1233, 7),
        requireQuest = {check = false, storage = 0, value = 0},
        cost = {check = false, itemId = 0, amount = 0}
    },
}

local cooldowns = {}

local waypoints = MoveEvent()
function waypoints.onStepIn(player,item,position,fromPosition)
    if not player:isPlayer() then
        return false
    end
        if cooldowns[player:getName()] ~= nil then
            if cooldowns[player:getName()] > os.time() - 2 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to wait ".. cooldowns[player:getName()] - (os.time() - 2) .."seconds before traveling again.")
                    return false
            end
        end

        local unlockedWaypoints = 0

        for i = 1, #waypointList do
            if player:getStorageValue(waypointList[i].actionId) == 1 then
                unlockedWaypoints = unlockedWaypoints + 1
            end
        end
    
        if unlockedWaypoints == 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to unlock another waypoint in order to use waypoints.")
        end
    local waypoint = false

    for i=1,#waypointList do
        if waypointList[i].actionId == item.actionid then
            waypoint = waypointList[i]
        end
    end

    if waypoint then
        if waypoint.requireQuest.Check then
            if player:getStorageValue(waypoint.requireQuest.storage) < waypoint.requireQuest.value then
                player:teleportTo(fromPosition)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not completed the prerequisite Quest, to unlock waypoint to ".. waypoint.name ..".")
                return false
            end
        end
        if player:getStorageValue(waypoint.actionId) ~= 1 then
            player:setStorageValue(waypoint.actionId,1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have unlocked waypoint to ".. waypoint.name ..".")
            return true
        end

        player:registerEvent("revWaypoints")
        local window = ModalWindow(5000, "Waypoints", "Waypoint: " .. waypoint.name .. "\n")

        local unlockedWps = 0

        for i=1,#waypointList do
            if player:getStorageValue(waypointList[i].actionId) == 1 then
                if waypointList[i].actionId ~= item.actionid then
                    unlockedWps = unlockedWps+1
                    window:addChoice(i, waypointList[i].name)
                end
            end
        end

        window:addButton(110,"Select")
        window:addButton(111,"Cancel")
        window:setDefaultEnterButton(110)
        window:setDefaultEscapeButton(111)
        if unlockedWps ~= 0 then
            window:sendToPlayer(player)
        end
      
        return true
    end
end

for j=1,#waypointList do
    waypoints:aid(waypointList[j].actionId)
end

waypoints:type("stepin")
waypoints:register()

local wpWindow = CreatureEvent("revWaypoints")
wpWindow:type("modalwindow")

function wpWindow.onModalWindow(player,modalWindowId,buttonId,choiceId)
    if modalWindowId == 5000 then
        if buttonId == 110 then
            local travel = true
            if waypointList[choiceId].cost.check then
                        if not player:removeItem(waypointList[choiceId].cost.itemId,waypointList[choiceId].cost.amount) then
                                    travel = false
                        end
            end
            if travel then
                cooldowns[player:getName()] = os.time()
                player:unregisterEvent("revWaypoints")
                player:teleportTo(waypointList[choiceId].position)
                player:getPosition():sendMagicEffect(15)
            else
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You cant afford to travel to ".. waypointList[choiceId].name ..".")
            end
          
            return true
        end
    end
end

wpWindow:register()