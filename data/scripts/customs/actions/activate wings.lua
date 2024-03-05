local config = {
    [7215] = {wingId = 1, effect = CONST_ME_FIREWORK_RED, storage = 2929}, -- ItemID in [8888]
    [8887] = {wingId = 2, effect = CONST_ME_FIREWORK_RED, storage = 2930},
}

local addWingsSystem = Action()

function addWingsSystem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local wings = config[item.itemid]
    if not wings then
        return true
    end
    if player:getStorageValue(wings.storage) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You alredy received those wings!')
        return true
    end
    player:addWings(wings.wingId)
    player:setStorageValue(wings.storage, 1)
    player:getPosition():sendMagicEffect(wings.effect)
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You received new wings!')
    player:removeItem()
    return true
end

for v, _ in pairs(config) do
    addWingsSystem:id(v)
end
addWingsSystem:register()