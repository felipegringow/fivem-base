-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	-- ["Priv"] = {
	-- 	["Parent"] = {
	-- 		["Priv"] = true
	-- 	},
	-- 	["Hierarchy"] = { "Administrador" },
	-- 	["Service"] = {}
	-- },
	["HeliPriv"] = {
		["Parent"] = {
			["HeliPriv"] = true
		},
		["Hierarchy"] = { "Piloto" },
		["Service"] = {}
	},
	["Creator"] = {
		["Parent"] = {
			["Creator"] = true
		},
		["Hierarchy"] = { "Staff","Creators" },
		["Salary"] = { 1,1500 },
		["Service"] = {},
		["Type"] = "Work"
	},
    -- Groups
    ["Emergency"] = {
		["Parent"] = {
			["Police"] = true,
			["Comanf"] = true,
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Restaurants"] = {
		["Parent"] = {
			["Pearls"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
    -- Framework
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
		["Service"] = {}
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Platina","Ouro","Prata","Bronze" },
		["Salary"] = { 2500,2250,2000,1750 },
		["Service"] = {}
	},
	["Spotify"] = {
		["Parent"] = {
			["Spotify"] = true
		},
		["Hierarchy"] = { "Ouvinte" },
		["Salary"] = {},
		["Service"] = {}
	},
    -- Public
	["OAB"] = {
		["Parent"] = {
			["OAB"] = true
		},
		["Hierarchy"] = { "Juridico" },
		["Salary"] = { 1750 },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 4500,4250,4000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 4500,4250,4000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Comanf"] = {
		["Parent"] = {
			["Comanf"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 4500,4250,4000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["APH"] = {
		["Parent"] = {
			["APH"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	------------------------------
	["Harmony"] = {
		["Parent"] = {
			["Harmony"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 3500,3250,3000 },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Ottos"] = {
		["Parent"] = {
			["Ottos"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 3500,3250,3000 },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Dk"] = {
		["Parent"] = {
			["Dk"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = { 3500,3250,3000 },
		["Service"] = {},
		["Type"] = "Work"
	},
    -- Restaurants
	["Pearls"] = {
		["Parent"] = {
			["Pearls"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    -- Contraband Sul
	["BackpackSell"] = {
		["Parent"] = {
			["BackpackSell"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Chiliad"] = {
		["Parent"] = {
			["Chiliad"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Highways"] = {
		["Parent"] = {
			["Highways"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	-- Contraband North
	["GasStation"] = {
		["Parent"] = {
			["GasStation"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Hookies"] = {
		["Parent"] = {
			["Hookies"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["RoadKill"] = {
		["Parent"] = {
			["RoadKill"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Union"] = {
		["Parent"] = {
			["Union"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Fishing"] = {
		["Parent"] = {
			["Fishing"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Resort"] = {
		["Parent"] = {
			["Resort"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["YellowJack"] = {
		["Parent"] = {
			["YellowJack"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Blarneys"] = {
		["Parent"] = {
			["Blarneys"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Training"] = {
		["Parent"] = {
			["Training"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    -- Favelas
    ["Barragem"] = {
		["Parent"] = {
			["Barragem"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Barragem2"] = {
		["Parent"] = {
			["Barragem2"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Barragem3"] = {
		["Parent"] = {
			["Barragem3"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Farol"] = {
		["Parent"] = {
			["Farol"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Parque"] = {
		["Parent"] = {
			["Parque"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Sandy"] = {
		["Parent"] = {
			["Sandy"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Petroleo"] = {
		["Parent"] = {
			["Petroleo"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Praia-1"] = {
		["Parent"] = {
			["Praia-1"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Praia-2"] = {
		["Parent"] = {
			["Praia-2"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Zancudo"] = {
		["Parent"] = {
			["Zancudo"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    -- Mafias
	["Bahamas"] = {
		["Parent"] = {
			["Bahamas"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["FuriousRecords"] = {
		["Parent"] = {
			["FuriousRecords"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Madrazzo"] = {
		["Parent"] = {
			["Madrazzo"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Michael"] = {
		["Parent"] = {
			["Michael"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Playboy"] = {
		["Parent"] = {
			["Playboy"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Nashi"] = {
		["Parent"] = {
			["Nashi"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["TheSouth"] = {
		["Parent"] = {
			["TheSouth"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
    ["Vineyard"] = {
		["Parent"] = {
			["Vineyard"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	}
}