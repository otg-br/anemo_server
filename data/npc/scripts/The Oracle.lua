local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	if level < 20 then
		npcHandler:say("Child, come back when you grow up. To leave Kindernia you need at least level 20.", cid)
		return false
	elseif level > 1000 then
		npcHandler:say(player:getName() .. ", I Can't let you leave, you are too strong and have reached an incredible level. You will be the protector of Kindernia.", cid)
		return false
	elseif player:getVocation():getId() > 0 then
		npcHandler:say("Seems you already have a vocation and you are on Kindernia, if this was not intended, please contact administrator, otherwise, if you are the administrator, you can only choice a vocation if you are a none vocation character.", cid)
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, "yes") and npcHandler.topic[cid] == 0 then
		npcHandler:say("In Which town do you want to live: {Mordragor},{Dolwatha},{Freewind},{Falanaar}? As i recommend {Mordragor} for new players, others cities may be difficult for starting.", cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "mordragor") then
			town[cid] = 2
			destination[cid] = Position(1093, 411, 5)
			npcHandler:say("On Mordragor, the medieval city! And what profession have you chosen: {Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, "dolwatha") then
			town[cid] = 2
			destination[cid] = Position(374, 326, 7)
			npcHandler:say("On Dolwatha, warning to the sandstorms! And what profession have you chosen: {Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, "freewind") then
			town[cid] = 2
			destination[cid] = Position(1217, 1028, 5)
			npcHandler:say("On Freewind, the Ice City! And what profession have you chosen: {Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, "falanaar") then
			town[cid] = 2
			destination[cid] = Position(668, 423, 7)
			npcHandler:say("On Falanaar, in a middle of the forest! And what profession have you chosen: {Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
			npcHandler.topic[cid] = 2
		else
			npcHandler:say("In which town do you want to live: {Mordragor},{Dolwatha},{Freewind},{Falanaar}?", cid)
		end
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, "sorcerer") then
			npcHandler:say("You want become a {sorcerer}, strong mage, are you sure ? This decision is irreversible!", cid)
			npcHandler.topic[cid] = 3
			vocation[cid] = 1
		elseif msgcontains(msg, "druid") then
			npcHandler:say("You want become a {druid}, healing and attacking a distance with powerful magic spells, are you sure ? This decision is irreversible!", cid)
			npcHandler.topic[cid] = 3
			vocation[cid] = 2
		elseif msgcontains(msg, "paladin") then
			npcHandler:say("You want become a {paladin}, a hunter of the wild, are you sure ? This decision is irreversible!", cid)
			npcHandler.topic[cid] = 3
			vocation[cid] = 3
		elseif msgcontains(msg, "knight") then
			npcHandler:say("You want become a {knight}, the strong of a warrior, are you sure ? This decision is irreversible!", cid)
			npcHandler.topic[cid] = 3
			vocation[cid] = 4
		else
			npcHandler:say("{Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
		end
	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "yes") then
			local player = Player(cid)
			npcHandler:say("Your adventure starts here.", cid)
			player:setVocation(Vocation(vocation[cid]))
			player:setTown(Town(town[cid]))

			local destination = destination[cid]
			npcHandler:releaseFocus(cid)
			player:teleportTo(destination)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			destination:sendMagicEffect(CONST_ME_TELEPORT)
		else
			npcHandler:say("Then What? {Knight}, {Paladin}, {Sorcerer}, or {Druid}?", cid)
			npcHandler.topic[cid] = 2
		end
	end
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
	destination[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
	destination[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
