
local woodcuttingRecipe = Action()

 
function woodcuttingRecipe.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Woodcutting.OlivePlank) == 1 then
		player:say("You have already learned the recipe of olive plank.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Woodcutting.OlivePlank, 1)
	item:remove(1)
end
end
woodcuttingRecipe:id(26641)
woodcuttingRecipe:register()