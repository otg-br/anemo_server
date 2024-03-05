local config = {
    actionId = 32148,
    delay = 60 * 10, -- 10 min
    delayPersistent = false,
    bosses = {
        { name = "bone berserker", pos = Position(505, 962, 8) },
        { name = "bone archer", pos = Position(506, 962, 8) },
        { name = "bone mage", pos = Position(506, 963, 8) },
        { name = "bone slicer", pos = Position(507, 963, 8) },
        { name = "bone master", pos = Position(508, 963, 8) }
    }
}

local movInSecond = MoveEvent()

function movInSecond.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    local playerId = player:getId()
    local ground = Tile(position):getGround()
    if ground then
        local now = os.time()
        local delay = config.delayPersistent and ground:getCustomAttribute("delay") or config.time
        if not delay or delay <= now then
            position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            for _, info in pairs(config.bosses) do
                Game.createMonster(info.name, info.pos)
            end
            if not config.delayPersistent then
                config.time = now + config.delay
            else
                ground:setCustomAttribute("delay", now + config.delay)
            end
        else
        end
    end
    return true
end

movInSecond:aid(config.actionId)
movInSecond:register()