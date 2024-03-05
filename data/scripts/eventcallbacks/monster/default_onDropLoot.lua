local ec = EventCallback

ec.onDropLoot = function(self, corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	local mType = self:getType()
	if not player or player:getStamina() > 840 then
		local monsterLevel = self:getMonsterLevel()
		
		local lootMultiplier = 1
		if monsterLevel >= 5 and monsterLevel < 50 then
			lootMultiplier = 1.15
		elseif monsterLevel >= 51 and monsterLevel < 100 then
			lootMultiplier = 1.35
		elseif monsterLevel >= 101 and monsterLevel < 200 then
			lootMultiplier = 1.65
		elseif monsterLevel >= 201 and monsterLevel < 300 then
			lootMultiplier = 1.95
		elseif monsterLevel >= 301 and monsterLevel < 500 then
			lootMultiplier = 2.50
		elseif monsterLevel >= 501 and monsterLevel < 10000 then
			lootMultiplier = 3.00
		end
		local monsterLoot = mType:getLoot()
		for i = 1, #monsterLoot do
			for _ = 1, lootMultiplier do
				local additionalItem = corpse:createLootItem(monsterLoot[i], charmBonus)
				if not additionalItem then
					Spdlog.warn(string.format("[3][Monster:onDropLoot] - Could not add additional loot item to monster: %s, from corpse id: %d.", self:getName(), corpse:getId()))
				end
			end
			local item = corpse:createLootItem(monsterLoot[i])
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
			end
		end

		if player then
			local text = ("Loot of %s: %s"):format(mType:getNameDescription(), corpse:getContentDescription())
			local party = player:getParty()
			if party then
				party:broadcastPartyLoot(text)
			else
				player:sendTextMessage(MESSAGE_LOOT, text)
			end
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
		else
			player:sendTextMessage(MESSAGE_LOOT, text)
		end
	end
end

ec:register()
