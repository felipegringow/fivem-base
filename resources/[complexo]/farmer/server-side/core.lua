-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRUITMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruitman")
AddEventHandler("farmer:Fruitman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Amount = math.random(3,5)
					local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
						TriggerClientEvent("Progress",source,"Colhendo",11000)
						Objects[Number]["Time"] = GlobalState["Work"] + 25
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.","Atenção",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local List = { "sapphire_ore","emerald_ore","ruby_ore","gold_ore","iron_ore","lead_ore","sulfur_ore","tin_ore","diamond_ore","copper_ore" }
				local RandomList = math.random(#List)
				local Selected = List[RandomList]
				if vRP.ConsultItem(Passport,"WEAPON_PICKAXE",1) then
					local Amount = math.random(2)
					if (vRP.InventoryWeight(Passport) + itemWeight(Selected) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.createObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
						TriggerClientEvent("Progress",source,"Mineirando",10000)
						Objects[Number]["Time"] = GlobalState["Work"] + 7
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 10

						repeat
							Wait(1000)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(1000)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,"coal",Amount,true)
						vRP.GenerateItem(Passport,Selected,Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,2)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
					end
				elseif vRP.ConsultItem(Passport,"WEAPON_PICKAXE_PLUS",1) then
					local PlusAmount = math.random(2,4)
					if (vRP.InventoryWeight(Passport) + itemWeight(Selected) * PlusAmount) <= vRP.GetWeight(Passport) then
						vRPC.createObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
						TriggerClientEvent("Progress",source,"Mineirando",5000)
						Objects[Number]["Time"] = GlobalState["Work"] + 5
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 5

						repeat
							Wait(1000)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(1000)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,"coal",PlusAmount,true)
						vRP.GenerateItem(Passport,Selected,PlusAmount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Picareta</b> não encontrada.","Atenção",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Amount = math.random(3,5)
					if (vRP.InventoryWeight(Passport) + itemWeight("woodlog") * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
						TriggerClientEvent("Progress",source,"Cortando",11000)
						Objects[Number]["Time"] = GlobalState["Work"] + 15
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,"woodlog",Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.","Atenção",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				if (vRP.InventoryWeight(Passport) + itemWeight("pouch")) <= vRP.GetWeight(Passport) then
					vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
					TriggerClientEvent("Progress",source,"Coletando",1000)
					Objects[Number]["Time"] = GlobalState["Work"] + 10
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					Wait(1000)

					TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRP.GenerateItem(Passport,"pouch",1,true)
					vRP.UpgradeStress(Passport,1)
					vRPC.removeObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("farmer:Table",source,Objects)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)