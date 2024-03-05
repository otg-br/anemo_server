
local craftWoodcutting = Action()

function capAll(str)
    return str:gsub("^(%a)", string.upper):gsub("([^%a]%a)", string.upper)
end

local config = {
	mainTitleMsg = "Woodcutter's Craft", 
	mainMsg = "Welcome to the Woodcutter's Craft.\nPlease choose a category:", 
 
	craftTitle = "Woodcutter's Craft: ",
	craftMsg = "Click on Recipe to see the necessary resources needed to craft a new one.\n\nHere is a list of all resources that can be crafted from Woodcutter craft: ", 
	needItems = "You do not have all the required items to make ",
	system = {
	[1] = {tiers = "Planks", 
			items = {
				[1] = {item = "Big Piece of Wood", 
						itemID = 26599, 
						reqItems = {
								[1] = {item = 26594, count = 3}, -- 3 Piece of wood
							},
							description = "This item can be sold on Npc Rostock.",
							skill_required = 0,
							storage = Jobs.Woodcutting.BigPieceOfWood, 
						},
						[2] = {item = "Ash Plank", 
						itemID = 26600, 
						reqItems = {
								[1] = {item = 26595, count = 3}, -- 3 Ash Wood
							},
							description = "This item can be sold on Npc Rostock.",
							skill_required = 10,
							storage = Jobs.Woodcutting.AshPlank, 
						},
						[3] = {item = "Chestnut Plank", 
						itemID = 26601, 
						reqItems = {
								[1] = {item = 26596, count = 3}, -- 3 Chestnut Wood
							},
							description = "This item can be sold on Npc Rostock.",
							skill_required = 25,
							storage = Jobs.Woodcutting.ChestnutPlank, 
						},
						[4] = {item = "Olive Plank", 
						itemID = 26603, 
						reqItems = {
								[1] = {item = 26598, count = 3}, -- 3 Olive Wood
							},
							description = "This item can be sold on Npc Rostock.",
							skill_required = 40,
							storage = Jobs.Woodcutting.OlivePlank, 
						},
						[5] = {item = "Cherry Plank", 
						itemID = 26602, 
						reqItems = {
								[1] = {item = 26597, count = 3}, -- 3 Cherry Wood
							},
							description = "This item can be sold on Npc Rostock.",
							skill_required = 60,
							storage = Jobs.Woodcutting.CherryPlank, 
						},
 
				},
			},
			[2] = {tiers = "Axe's", 
			items = {
				[1] = {item = "Apprentice's axe", 
						itemID = 26589, 
						reqItems = {
								[1] = {item = 26588, count = 1}, -- Beginner's axe
								[2] = {item = 26600, count = 5}, -- 5 Ash Plank
							},
							description = "This axe is used to cut on Ash Tree. Doesn't require to learn recipe.",
							skill_required = 5,
							storage = 0, 
						},
						[2] = {item = "Lumberjack's axe", 
						itemID = 26590, 
						reqItems = {
							[1] = {item = 26589, count = 1}, -- Apprentice's axe
							[2] = {item = 26601, count = 5}, -- 5 Chestnut Planks
							},
							description = "This axe is used to cut on Ash Tree and Chestnut Tree. Doesn't require to learn recipe.",
							skill_required = 10,
							storage = 0, 
						},
						[3] = {item = "Expert's axe", 
						itemID = 26591, 
						reqItems = {
							[1] = {item = 26590, count = 1}, -- Lumberjack's axe
							[2] = {item = 26598, count = 5}, -- 5 Olive Planks
							},
							description = "This axe is used to cut on Ash Tree, Chestnut Tree and Olive Tree. Doesn't require to learn recipe.",
							skill_required = 20,
							storage = 0, 
						},
						[4] = {item = "Master's axe", 
						itemID = 26592, 
						reqItems = {
							[1] = {item = 26591, count = 1}, -- Expert's axe
							[2] = {item = 26597, count = 5}, -- 5 Cherry Planks
							},
							description = "This axe is used to cut on Ash Tree, Chestnut Tree, Olive and Cherry Tree. Doesn't require to learn recipe.",
							skill_required = 30,
							storage = 0, 
						},
 
				},
			},
		},
	}
 
function craftWoodcutting.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	
    player:sendMainCraftWindow(config)
    return true
end
craftWoodcutting:aid(36456)
craftWoodcutting:register()