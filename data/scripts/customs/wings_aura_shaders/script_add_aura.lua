local config = {
    [26651] = {auraId = 1, effect = CONST_ME_FIREWORK_RED, storage = 82302, name = "Blue Essence"}, 
    [26650] = {auraId = 2, effect = CONST_ME_FIREWORK_RED, storage = 82303, name = "Blue Sphere"}, 
    [26653] = {auraId = 3, effect = CONST_ME_FIREWORK_RED, storage = 82304, name = "Fireflies"}, 
    [26649] = {auraId = 4, effect = CONST_ME_FIREWORK_RED, storage = 82305, name = "Power"}, 
    [26652] = {auraId = 5, effect = CONST_ME_FIREWORK_RED, storage = 82306, name = "Gray Skulls"}, 
}

local addAuraSystem = Action()

function addAuraSystem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local aura = config[item.itemid]
    if not aura then
        return true
    end
    if player:getStorageValue(aura.storage) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You alredy received this aura!')
        return true
    end
    player:addAura(aura.auraId)
    player:setStorageValue(aura.storage, 1)
    player:getPosition():sendMagicEffect(aura.effect)
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You received ' ..aura.name..' aura!')
    item:remove(1)
    return true
end

for v, _ in pairs(config) do
    addAuraSystem:id(v)
end
addAuraSystem:register()