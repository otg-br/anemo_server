
local woodcuttingRecipe = Action()

 
function woodcuttingRecipe.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Woodcutting.BigPieceOfWood) == 1 then
		player:say("You have already learned the recipe of big piece of wood.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Woodcutting.BigPieceOfWood, 1)
	item:remove(1)
end
end
woodcuttingRecipe:id(26638)
woodcuttingRecipe:register()