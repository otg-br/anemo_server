
local woodcuttingRecipe = Action()

 
function woodcuttingRecipe.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Woodcutting.CherryPlank) == 1 then
		player:say("You have already learned the recipe of cherry plank.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Woodcutting.CherryPlank, 1)
	item:remove(1)
end
end
woodcuttingRecipe:id(26642)
woodcuttingRecipe:register()