function onLogin(player)
	local serverName = configManager.getString(configKeys.SERVER_NAME)
	local loginStr = "Welcome to " .. serverName .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end
		loginStr = string.format("Your last visit in %s: %s.", serverName, os.date("%d %b %Y %X", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	local BLESSINGS, amount, missing = {"Spiritual Shielding", "Embrace of Tibia", "Fire of the Suns", "Spark of the Phoenix", "Wisdom of Solitude"}, 0, {}
	local bless = {1, 2, 3, 4, 5}
	
	for i = 1, 5 do
	if player:hasBlessing(bless[i]) then amount = (amount+1) else table.insert(missing, BLESSINGS[i]) end
	end
	
	if amount == 1 then s='' else s='s' end
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have "..amount.." blessing"..s.." (".. amount*20 .."%).\nMissing blessings: "..table.concat(missing, ", "))


	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(PlayerStorageKeys.promotion)
		if value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("GameStore")
	player:registerEvent("ModalWindowHelper")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("ancestralTask")
	player:registerEvent("GameExtendedOpcode")
	player:registerEvent("onDeath_randomTierDrops")
	return true
end
