
local ingot = Action()

 
function ingot.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Mining.SmallSilverIngot) == 1 then
		player:say("You have already learned the recipe of small silver ingot.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Mining.SmallSilverIngot, 1)
	item:remove(1)
end
end
ingot:id(26580)
ingot:register()