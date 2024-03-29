local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local shop = {
	{id=25177, buy=100, sell=0, name='earthheart cuirass'},
	{id=25178, buy=100, sell=0, name='earthheart hauberk'},
	{id=25179, buy=100, sell=0, name='earthheart platemail'},
	{id=25191, buy=100, sell=0, name='earthmind raiment'},
	{id=25187, buy=100, sell=0, name='earthsoul tabard'},
	{id=25174, buy=100, sell=0, name='fireheart cuirass'},
	{id=25175, buy=100, sell=0, name='fireheart hauberk'},
	{id=25176, buy=100, sell=0, name='fireheart platemail'},
	{id=25190, buy=100, sell=0, name='firemind raiment'},
	{id=25186, buy=100, sell=0, name='firesoul tabard'},
	{id=25183, buy=100, sell=0, name='frostheart cuirass'},
	{id=25184, buy=100, sell=0, name='frostheart hauberk'},
	{id=25185, buy=100, sell=0, name='frostheart platemail'},
	{id=25193, buy=100, sell=0, name='frostmind raiment'},
	{id=25189, buy=100, sell=0, name='frostsoul tabard'},
	{id=25180, buy=100, sell=0, name='thunderheart cuirass'},
	{id=25181, buy=100, sell=0, name='thunderheart hauberk'},
	{id=25182, buy=100, sell=0, name='thunderheart platemail'},
	{id=25192, buy=100, sell=0, name='thundermind raiment'},
	{id=25188, buy=100, sell=0, name='thundersoul tabard'},
}

local function setNewTradeTable(table)
	local items, item = {}
	for i = 1, #table do
		item = table[i]
		items[item.id] = {id = item.id, buy = item.buy, sell = item.sell, subType = 0, name = item.name}
	end
	return items
end

local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local itemsTable = setNewTradeTable(shop)
	if not ignoreCap and player:getFreeCapacity() < ItemType(itemsTable[item].id):getWeight(amount) then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough cap.")
	end
	if itemsTable[item].buy then
		if player:removeItem(25172, amount * itemsTable[item].buy) then
			if amount > 1 then
				currencyName = ItemType(25172):getPluralName():lower()
			else
				currencyName = ItemType(25172):getName():lower()
			end
			player:addItem(itemsTable[item].id, amount)
			return player:sendTextMessage(MESSAGE_INFO_DESCR,
						"Bought "..amount.."x "..itemsTable[item].name.." for "..itemsTable[item].buy * amount.." "..currencyName..".")
		else
			return player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough Silver Tokens.")
		end
	end

	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	return true
end


local function greetCallback(cid)
    return true
end

local voices = {
	{ text = 'Trading tokens! First-class bargains!' },
	{ text = 'Bespoke armor for all vocations! For the cost of some tokens only!' },
	{ text = 'Tokens! Bring your tokens!' }
}

npcHandler:addModule(VoiceModule:new(voices))

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if not player then
		return false
	end
	if msgcontains(msg, 'token') or msgcontains(msg, 'tokens') then
		npcHandler:say("If you have any {silver} tokens with you, let's have a look! Maybe I can offer you something in exchange.", cid)
	elseif msgcontains(msg, 'information') then
		npcHandler:say("With pleasure. <bows> I trade {token}s. There are several ways to obtain the {token}s I am interested in - killing certain bosses, for example. In exchange for a certain amount of tokens, I can offer you some first-class items.", cid)
	elseif msgcontains(msg, 'silver') then
		openShopWindow(cid, shop, onBuy, onSell)
		npcHandler:say({"Here's the deal, " .. player:getName() .. ". For 100 of your silver tokens, I can offer you some first-class torso armor. These armors provide a solid boost to your main attack skill, as well as ...",
		"some elemental protection of your choice! I also sell a magic shield potion for one silver token. So these are my offers."}, cid)
	elseif msgcontains(msg, 'addon') then
		if player:hasOutfit(846, 0) or player:hasOutfit(845, 0) then
			npcHandler:say("Ah, very good. Now choose your addon: {first} or {second}.", cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say("Sorry, friend, but one good turn deserves another. You need to obtain the rift warrior outfit first.", cid)
		end
	elseif isInArray({'first', 'second'}, msg:lower()) and npcHandler.topic[cid] == 3 then
		if msg:lower() == 'first' then
			if not(player:hasOutfit(846, 1)) and not(player:hasOutfit(845, 1)) then
				if player:removeItem(25172, 100) then
					npcHandler:say("Ah, excellent. Obtain the first addon for your rift warrior outfit.", cid)
					player:addOutfitAddon(846, 1)
					player:addOutfitAddon(845, 1)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough ".. ItemType(25172):getPluralName():lower() .." and it's a deal.", cid)
				end
			else
				npcHandler:say("Sorry, friend, you already have the first Rift Warrior addon.", cid)
			end
		elseif msg:lower() == 'second' then
			if not(player:hasOutfit(846, 2)) and not(player:hasOutfit(845, 2)) then
				if player:removeItem(25172, 100) then
					npcHandler:say("Ah, excellent. Obtain the second addon for your rift warrior outfit.", cid)
					player:addOutfitAddon(846, 2)
					player:addOutfitAddon(845, 2)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough ".. ItemType(25172):getPluralName():lower() .." and it's a deal.", cid)
				end
			else
				npcHandler:say("Sorry, friend, you already have the second Rift Warrior addon.", cid)
			end
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
