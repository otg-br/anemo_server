local ancestralSystem = CreatureEvent("ancestralTask")
function ancestralSystem.onKill(player, target)
	if target:isPlayer()  or target:getMaster() then
		return true
	end

	local mon_name = target:getName():lower()

	local ret_t = getTaskInfos(player)
	if ret_t then
		if mon_name == ret_t.name or isInArray(ret_t.mons_list, mon_name) then
		local sto_value = player:getStorageValue(ret_t.storage)
			if sto_value < ret_t.amount then
				sto_value = sto_value + 1
				player:setStorageValue(ret_t.storage, sto_value)
				if sto_value < ret_t.amount then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[Normal Ancestral Task] Killed ['..(sto_value)..'/'..ret_t.amount..'] '..mon_name..'.')
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[Normal Ancestral Task] You finished your '..mon_name..' task.')
				end
			end
		end
	end

	local ret_td = getTaskDailyInfo(player)
	if ret_td then
		if mon_name == ret_td.name or isInArray(ret_td.mons_list, mon_name) then
			local sto_value = player:getStorageValue(ret_td.storage)
			if sto_value < ret_td.amount then
				sto_value = sto_value + 1
				player:setStorageValue(ret_td.storage, sto_value)
				if sto_value < ret_td.amount then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[Daily Ancestral Task] Killed ['..(sto_value)..'/'..ret_td.amount..'] '..mon_name..'.')
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[Daily Ancestral Task] You finished your '..mon_name..' task.')
				end
			end
		end
	end

	return true
end
ancestralSystem:register()
