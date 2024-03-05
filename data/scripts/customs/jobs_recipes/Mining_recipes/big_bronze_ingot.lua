
local ingot = Action()

 
function ingot.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Mining.BigBronzeIngot) == 1 then
		player:say("You have already learned the recipe of big bronze ingot.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Mining.BigBronzeIngot, 1)
	item:remove(1)
end
end
ingot:id(26582)
ingot:register()