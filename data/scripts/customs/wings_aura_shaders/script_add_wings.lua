local config = {
    [26644] = {wingId = 1, effect = CONST_ME_FIREWORK_RED, storage = 76543, name = "Fiery"}, 
    [26648] = {wingId = 2, effect = CONST_ME_FIREWORK_RED, storage = 76544, name = "Lullaby"},
    [26646] = {wingId = 3, effect = CONST_ME_FIREWORK_RED, storage = 76545, name = "Falanaar"},
    [26645] = {wingId = 4, effect = CONST_ME_FIREWORK_RED, storage = 76546, name = "Vampire"},
    [26647] = {wingId = 5, effect = CONST_ME_FIREWORK_RED, storage = 76547, name = "Bark"},
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
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You received '..wings.name..' wings!')
    item:remove(1)
    return true
end

for v, _ in pairs(config) do
    addWingsSystem:id(v)
end
addWingsSystem:register()