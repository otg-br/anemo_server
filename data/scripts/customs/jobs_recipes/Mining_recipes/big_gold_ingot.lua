
local ingot = Action()

 
function ingot.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Mining.BigGoldIngot) == 1 then
		player:say("You have already learned the recipe of big gold ingot.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Mining.BigGoldIngot, 1)
	item:remove(1)
end
end
ingot:id(26584)
ingot:register()