
local woodcuttingRecipe = Action()

 
function woodcuttingRecipe.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Woodcutting.ChestnutPlank) == 1 then
		player:say("You have already learned the recipe of chestnut plank.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Woodcutting.ChestnutPlank, 1)
	item:remove(1)
end
end
woodcuttingRecipe:id(26640)
woodcuttingRecipe:register()