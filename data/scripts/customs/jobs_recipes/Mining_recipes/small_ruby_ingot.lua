
local ingot = Action()

 
function ingot.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Mining.SmallRubyIngot) == 1 then
		player:say("You have already learned the recipe of small ruby ingot.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Mining.SmallRubyIngot, 1)
	item:remove(1)
end
end
ingot:id(26578)
ingot:register()