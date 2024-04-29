-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("routes",Creative)
vCLIENT = Tunnel.getInterface("routes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Collect = {}
local Payment = {}
local Delivery = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {
	["Families"] = {
		["coords"] = { -162.79,-1617.83,33.658 },
		["perm"] = "Families",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "weedleaf",
	},
	["SV"] = {
		["coords"] = { 1794.32,446.1,172.54 },
		["perm"] = "SV",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "box2",
	},
	["Ballas"] = {
		["coords"] = { -0.6,-1809.11,29.15 },
		["perm"] = "Ballas",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "cokeleaf",
	},
	["Pedreira"] = {
		["coords"] = { 2664.49,2735.19,41.65 },
		["perm"] = "Pedreira",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "box4",
	},
	["Bloods"] = {
		["coords"] = { 222.33,-1759.92,25.24 },
		["perm"] = "Bloods",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "box6",
	},
	["Aztecas"] = {
		["coords"] = { 524.35,-1822.15,28.49 },
		["perm"] = "Aztecas",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "box6",
	},
	["Sinaloa"] = {
        ["coords"] = { 1402.71,1134.37,114.33 },
        ["perm"] = "Mafia",
        ["upgradeStress"] = 1,
        ["routeCollect"] = true,
        ["routeDelivery"] = false,
        --["collectVehicle"] = nill,
        ["usingVehicle"] = false,
        ["collectRandom"] = false,
        ["collectText"] = "COLETAR",
        ["deliveryText"] = "ENTREGAR",
        ["collectButtonDistance"] = 15,
        ["collectShowDistance"] = 100,
        ["collectConsume"] = {
            ["min"] = 1,
            ["max"] = 2
        },
        ["collectCoords"] = {
            { 773.81,-149.74,75.62 },
            { 315.14,-128.38,69.98 },
            { -274.1,28.53,54.74 },
            { 66.52,-255.81,52.35 },
            { -1224.36,-711.28,22.34 },
            { -1309.0,-931.25,13.36 },
            { -1256.3,-1331.03,4.08 },
            { -1107.3,-1480.32,4.92 },
            { -1257.52,-1149.95,7.77 },
            { -1314.72,-602.83,29.39 },
            { -1468.28,-387.04,38.81 },
            { -1622.8,-379.88,43.71 },
            { -1487.93,-207.53,50.85 },
            { -1235.8,378.95,76.41 },
            { -721.78,490.48,109.62 },
            { -348.83,515.04,120.64 },
            { 189.86,309.14,105.38 },
            { 246.23,-677.92,37.74 },
            { 278.63,-1071.62,29.44 },
            { 833.71,-1074.71,28.14 },
            { 780.68,-1278.54,27.03 }
        },
		["deliveryItem"] = "box1",
    },
	["Mafia"] = {
		["coords"] = { 1403.93,1150.19,114.33 },
		["perm"] = "Mafia",
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		--["collectVehicle"] = nill,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 2
		},
		["collectCoords"] = {
			{ 773.81,-149.74,75.62 },
			{ 315.14,-128.38,69.98 },
			{ -274.1,28.53,54.74 },
			{ 66.52,-255.81,52.35 },
			{ -1224.36,-711.28,22.34 },
			{ -1309.0,-931.25,13.36 },
			{ -1256.3,-1331.03,4.08 },
			{ -1107.3,-1480.32,4.92 },
			{ -1257.52,-1149.95,7.77 },
			{ -1314.72,-602.83,29.39 },
			{ -1468.28,-387.04,38.81 },
			{ -1622.8,-379.88,43.71 },
			{ -1487.93,-207.53,50.85 },
			{ -1235.8,378.95,76.41 },
			{ -721.78,490.48,109.62 },
			{ -348.83,515.04,120.64 },
			{ 189.86,309.14,105.38 },
			{ 246.23,-677.92,37.74 },
			{ 278.63,-1071.62,29.44 },
			{ 833.71,-1074.71,28.14 },
			{ 780.68,-1278.54,27.03 }
		},
		["deliveryItem"] = "box1",
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Collect(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Works[Service]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""
			local randomItem = math.random(#Works[Service]["deliveryItem"])
			selectItem = Works[Service]["deliveryItem"][randomItem]
			amountItem = math.random(Works[Service]["collectConsume"]["min"],Works[Service]["collectConsume"]["max"])

			if (vRP.InventoryWeight(Passport) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.GetWeight(Passport) then
				vRP.GenerateItem(Passport,selectItem,amountItem,true)

				if Works[Service]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,Works[Service]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		else
			local deliveryItem = Works[Service]["deliveryItem"]
			Collect[Passport] = math.random(Works[Service]["collectConsume"]["min"],Works[Service]["collectConsume"]["max"])

			if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(Collect[Passport]))) <= vRP.GetWeight(Passport) then
				vRP.GenerateItem(Passport,deliveryItem,Collect[Passport],true)

				if deliveryItem == "dollars" then
					if vRP.UserPremium(Passport) then
						vRP.GenerateItem(Passport,deliveryItem,Collect[Passport] * 0.10,true)
					end
				end

				if Works[Service]["upgradeStress"] > 0 then
					vRP.upgradeStress(Passport,Works[Service]["upgradeStress"])
				end

				Collect[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delivery(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local deliveryItem = Works[Service]["deliveryPayment"]["item"]
		Delivery[Passport] = math.random(Works[Service]["deliveryConsume"]["min"],Works[Service]["deliveryConsume"]["max"])
		Payment[Passport] = math.random(Works[Service]["deliveryPayment"]["min"],Works[Service]["deliveryPayment"]["max"])

		if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(Payment[Passport]))) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Works[Service]["deliveryItem"],Delivery[Passport]) then
				local paymentPrice = parseInt(Payment[Passport] * Delivery[Passport])

				vRP.GenerateItem(Passport,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" then
					if vRP.UserPremium(Passport) then
						vRP.GenerateItem(Passport,deliveryItem,paymentPrice * 0.10,true)
					end
				end

				Delivery[Passport] = nil
				Payment[Passport] = nil

				if Works[Service]["upgradeStress"] > 0 then
					vRP.upgradeStress(Passport,Works[Service]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..parseFormat(Delivery[Passport]).."x "..itemName(Works[Service]["deliveryItem"]).."</b> para entregar.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Works[Service]["perm"] == nil then
			return true
		end

		if vRP.HasGroup(Passport,Works[Service]["perm"]) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	vCLIENT.Update(source,Works)
end)