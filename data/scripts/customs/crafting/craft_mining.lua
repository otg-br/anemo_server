
local craftMining = Action()

function capAll(str)
    return str:gsub("^(%a)", string.upper):gsub("([^%a]%a)", string.upper)
end

local config = {
	mainTitleMsg = "Mining Craft", 
	mainMsg = "Welcome to the Mining Craft.\nPlease choose a category:", 
 
	craftTitle = "Mining Craft: ",
	craftMsg = "Click on Recipe to see the necessary resources needed to craft a new one.\n\nHere is a list of all resources that can be crafted from Mining craft: ", 
	needItems = "You do not have all the required items to make ",
	system = {
	[1] = {tiers = "Small Ingots", 
			items = {
				[1] = {item = "Small Bronze Ingot", 
						itemID = 26424, 
						reqItems = {
								[1] = {item = 26398, count = 3}, -- 3 Pice of Bronze
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 0,
							storage = Jobs.Mining.SmallBronzeIngot, 
						},
						[2] = {item = "Small Silver Ingot", 
						itemID = 26425, 
						reqItems = {
								[1] = {item = 26399, count = 3}, -- 3 Pice of Silver
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 5,
							storage = Jobs.Mining.SmallSilverIngot, 
						},
						[3] = {item = "Small Sapphire Ingot", 
						itemID = 26430, 
						reqItems = {
								[1] = {item = 26404, count = 3}, -- 3 Piece of Sapphire
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 15,
							storage = Jobs.Mining.SmallSapphireIngot, 
						},
						[4] = {item = "Small Gold Ingot", 
						itemID = 26427, 
						reqItems = {
								[1] = {item = 26401, count = 3}, -- 3 Piece of Gold
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 25,
							storage = Jobs.Mining.SmallGoldIngot, 
						},
						[5] = {item = "Small Amethyst Ingot", 
						itemID = 26400, 
						reqItems = {
								[1] = {item = 26400, count = 3}, -- 3 Piece of Amethyst
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 40,
							storage = Jobs.Mining.SmallAmethystIngot, 
						},
						[6] = {item = "Small Ruby Ingot", 
						itemID = 26402, 
						reqItems = {
								[1] = {item = 26402, count = 3}, -- 3 Piece of Ruby
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 60,
							storage = Jobs.Mining.SmallRubyIngot, 
						},
						[7] = {item = "Small Emerald Ingot", 
						itemID = 26403, 
						reqItems = {
								[1] = {item = 26403, count = 3}, -- 3 Piece of Emerald
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 80,
							storage = Jobs.Mining.SmallEmeraldIngot, 
						},
 
				},
			},
	[2] = {tiers = "Big Ingots", 
			items = {
				[1] = {item = "Big Bronze Ingot", 
						itemID = 26431, 
						reqItems = {
								[1] = {item = 26424, count = 2}, -- 2 Small Bronze Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 0,
							storage = Jobs.Mining.BigBronzeIngot, 
						},
						[2] = {item = "Big Silver Ingot", 
						itemID = 26432, 
						reqItems = {
								[1] = {item = 26425, count = 2}, -- 2 Small Silver Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 5,
							storage = Jobs.Mining.BigSilverIngot, 
						},
						[3] = {item = "Big Sapphire Ingot", 
						itemID = 26437, 
						reqItems = {
								[1] = {item = 26430, count = 2}, -- 2 Samll Sapphire Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 15,
							storage = Jobs.Mining.BigSapphireIngot, 
						},
						[4] = {item = "Big Gold Ingot", 
						itemID = 26434, 
						reqItems = {
								[1] = {item = 26427, count = 2}, -- 2 Small Gold Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 25,
							storage = Jobs.Mining.BigGoldIngot, 
						},
						[5] = {item = "Big Amethyst Ingot", 
						itemID = 26433, 
						reqItems = {
								[1] = {item = 26426, count = 2}, -- 2 Small Amethyst ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 40,
							storage = Jobs.Mining.BigAmethystIngot, 
						},
						[6] = {item = "Big Ruby Ingot", 
						itemID = 26435, 
						reqItems = {
								[1] = {item = 26428, count = 2}, -- 2 Small Ruby Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 60,
							storage = Jobs.Mining.BigRubyIngot, 
						},
						[7] = {item = "Big Emerald Ingot", 
						itemID = 26436, 
						reqItems = {
								[1] = {item = 26429, count = 2}, -- 2 Small Emerald Ingot
							},
							description = "This item can be sold on Npc Elyotrope.",
							skill_required = 80,
							storage = Jobs.Mining.BigEmeraldIngot, 
						},
 
				},
			},
			[3] = {tiers = "Pickaxe's", 
			items = {
				[1] = {item = "Apprentice's Pickaxe", 
						itemID = 26413, 
						reqItems = {
								[1] = {item = 26414, count = 1}, -- Beginner's Pickaxe
								[2] = {item = 26431, count = 5}, -- 5 Big Bronze Ingots
							},
							description = "This pick is used to mine on Bronze and Silver Veins. Doesn't require to learn recipe.",
							skill_required = 5,
							storage = 0, 
						},
						[2] = {item = "Miner's Pickaxe", 
						itemID = 26415, 
						reqItems = {
							[1] = {item = 26413, count = 1}, -- Apprentice's Pickaxe
							[2] = {item = 26432, count = 5}, -- 5 Big Silver Ingots
							},
							description = "This pick is used to mine on Bronze, Silver and Sapphire Veins. Doesn't require to learn recipe.",
							skill_required = 10,
							storage = 0, 
						},
						[3] = {item = "Expert's Pickaxe", 
						itemID = 26416, 
						reqItems = {
							[1] = {item = 26415, count = 1}, -- Miner's Pickaxe
							[2] = {item = 26437, count = 5}, -- 5 Big Sapphire Ingots
							},
							description = "This pick is used to mine on Bronze, Silver, Sapphire and Gold Veins. Doesn't require to learn recipe.",
							skill_required = 20,
							storage = 0, 
						},
						[4] = {item = "Master's Pickaxe", 
						itemID = 26417, 
						reqItems = {
							[1] = {item = 26416, count = 1}, -- Expert's Pickaxe
							[2] = {item = 26434, count = 5}, -- 5 Big Gold Ingots
							},
							description = "This pick is used to mine on all Veins. Doesn't require to learn recipe.",
							skill_required = 30,
							storage = 0, 
						},
 
				},
			},
		},
	}
 
function craftMining.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	
    player:sendMainCraftWindow(config)
    return true
end
craftMining:aid(36455)
craftMining:register()