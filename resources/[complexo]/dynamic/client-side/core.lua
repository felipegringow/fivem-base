-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu",function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true,true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(Data,Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] == "true" then
			TriggerServerEvent(Data["trigger"],Data["param"])
		else
			TriggerEvent(Data["trigger"],Data["param"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SetNuiFocus(false,false)
	menuOpen = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if GetEntityHealth(Ped) > 100 then
			if LocalPlayer["state"]["Premium"] then
				exports["dynamic"]:AddButton("Vestir Premium","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicarpre","wardrobe",true)
				exports["dynamic"]:AddButton("Guardar Premium","Salvar suas vestimentas do corpo.","player:Outfit","salvarpre","wardrobe",true)
			end

			exports["dynamic"]:AddButton("Vestir","Vestir-se com as vestimentas guardadas.","player:Outfit","aplicar","wardrobe",true)
			exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","player:Outfit","salvar","wardrobe",true)
			exports["dynamic"]:SubMenu("Armário","Colocar/Retirar roupas.","wardrobe")

			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:Outfit","Hat","clothes",true)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:Outfit","Mask","clothes",true)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:Outfit","Glasses","clothes",true)
			exports["dynamic"]:AddButton("Camisa","Colocar/Retirar a camisa.","player:Outfit","Shirt","clothes",true)
			exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar a jaqueta.","player:Outfit","Torso","clothes",true)
			exports["dynamic"]:AddButton("Mãos","Ajustas as mãos.","player:Outfit","Arms","clothes",true)
			exports["dynamic"]:AddButton("Colete","Colocar/Retirar o colete.","player:Outfit","Vest","clothes",true)
			exports["dynamic"]:AddButton("Calça","Colocar/Retirar a calça.","player:Outfit","Pants","clothes",true)
			exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar o sapato.","player:Outfit","Shoes","clothes",true)
			exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar roupas.","clothes")

			local Vehicle = vRP.ClosestVehicle(7)
			local LastVehicle = GetLastDrivenVehicle()	
			if IsEntityAVehicle(Vehicle) then
				if not IsPedInAnyVehicle(Ped) then
					if GetEntityModel(LastVehicle) == GetHashKey("flatbed") and not IsPedInAnyVehicle(Ped) then
						exports["dynamic"]:AddButton("Rebocar","Colocar o veículo na prancha.","towdriver:invokeTow","","others",false)
					end

					if vRP.ClosestPed(3) then
						exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","closestpeds",true)
						exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","closestpeds",true)

						exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","closestpeds")
					end
				else
					exports["dynamic"]:AddButton("Sentar no Motorista","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
					exports["dynamic"]:AddButton("Sentar no Passageiro","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
					exports["dynamic"]:AddButton("Sentar em Outros","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
					exports["dynamic"]:AddButton("Mexer nos Vidros","Levantar/Abaixar os vidros.","player:Windows","","vehicle",false)

					exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
				end
			end

			local Exclusivas = vSERVER.Exclusivas()
			if parseInt(#Exclusivas) > 0 then
				for _,v in pairs(Exclusivas) do
					if v["type"] == "backpack" then
						exports["dynamic"]:AddButton(v["name"],"Clique para colocar/remover.","skinshop:toggleBackpack",v["id"].."-"..v["texture"],"Exclusivas",false)
					end
				end

				exports["dynamic"]:SubMenu("Exclusivas","Todas as roupas exclusivas.","Exclusivas")
			end

			local Experience = vSERVER.Experience()
			for Name,Exp in pairs(Experience) do
				exports["dynamic"]:AddButton(Name,"Você possuí <yellow>"..Exp.." pontos</yellow> na classe <yellow>"..ClassCategory(Exp).."</yellow>.","","","Experience",false)
			end

			exports["dynamic"]:AddButton("Propriedades","Marcar/Desmarcar propriedades no mapa.","propertys:Blips","","others",false)
			exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:Injuries","","others",false)
			exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","barbershop:Debug","","others",true)

			exports["dynamic"]:SubMenu("Experiência","Todas as suas habilidades.","Experience")
			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function()
	if (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"]) and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 then

		local Ped = PlayerPedId()
			if GetEntityHealth(Ped) > 100 then
				
				exports["dynamic"]:AddButton("Anunciar","Fazer um anúncio para todos os moradores.","dynamic:EmergencyAnnounce","",false,true)

				exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:Remove","Hat","player",true)
				exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:Remove","Mask","player",true)
				exports["dynamic"]:AddButton("Remover Óculos","Remover da pessoa mais próxima.","skinshop:Remove","Glasses","player",true)

				exports["dynamic"]:AddButton("Carregar","Carregar a pessoa mais próxima.","player:carryPlayer","","player",true)
				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)
				exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","player")

				if LocalPlayer["state"]["Police"] then

					exports["dynamic"]:AddButton("Recruta","Fardamento de oficial.","player:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("Soldado","Fardamento de oficial.","player:presetFunctions","2","prePolice",true)
					exports["dynamic"]:AddButton("Cabo","Fardamento de oficial.","player:presetFunctions","3","prePolice",true)
					exports["dynamic"]:AddButton("Sargento","Fardamento de oficial.","player:presetFunctions","4","prePolice",true)
					exports["dynamic"]:AddButton("Oficial","Fardamento de oficial.","player:presetFunctions","5","prePolice",true)
	
					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:AddButton("Computador","Computador de bordo policial.","police:openSystem","",false,false)
				end
			end

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalSpawn")
AddEventHandler("dynamic:animalSpawn", function(Model)
	if HashAnimal == nil then
		if not SpawnAnimal then
			SpawnAnimal = true

			local Ped = PlayerPedId()
			local Heading = GetEntityHeading(Ped)
			local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.0, 1.0, 0.0)
			local myObject, objNet = vRPS.CreatePed(Model, Coords["x"], Coords["y"], Coords["z"], Heading, 28)
			if myObject then
				local Entity = LoadNetwork(objNet)
				if Entity then
					local SpawnAnimal = 0

					HashAnimal = NetworkGetEntityFromNetworkId(objNet)
					while not DoesEntityExist(HashAnimal) and SpawnAnimal <= 1000 do
						HashAnimal = NetworkGetEntityFromNetworkId(objNet)
						SpawnAnimal = SpawnAnimal + 1
						Wait(1)
					end

					SpawnAnimal = 0
					local PedControl = NetworkRequestControlOfEntity(HashAnimal)
					while not PedControl and SpawnAnimal <= 1000 do
						PedControl = NetworkRequestControlOfEntity(HashAnimal)
						SpawnAnimal = SpawnAnimal + 1
						Wait(1)
					end

					SetPedCanRagdoll(HashAnimal, false)
					SetEntityInvincible(HashAnimal, true)
					SetPedFleeAttributes(HashAnimal, 0, 0)
					SetEntityAsMissionEntity(HashAnimal, true, false)
					SetBlockingOfNonTemporaryEvents(HashAnimal, true)
					SetPedRelationshipGroupHash(HashAnimal, GetHashKey("k9"))
					GiveWeaponToPed(HashAnimal, GetHashKey("WEAPON_ANIMAL"), 200, true, true)

					SetEntityAsNoLongerNeeded(HashAnimal)

					TriggerEvent("dynamic:animalFunctions", "follow")

					vSERVER.RegisterAnimal(objNet)
				end
			end

			SpawnAnimal = false
		end
	else
		vSERVER.ClearAnimal()
		FollowAnimal = false
		HashAnimal = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalFunctions")
AddEventHandler("dynamic:animalFunctions", function(functions)
	if HashAnimal ~= nil then
		local Ped = PlayerPedId()
		if functions == "follow" then
			if not FollowAnimal then
				TaskFollowToOffsetOfEntity(HashAnimal, Ped, 1.0, 1.0, 0.0, 5.0, -1, 2.5, 1)
				SetPedKeepTask(HashAnimal, true)
				FollowAnimal = true
			else
				SetPedKeepTask(HashAnimal, false)
				ClearPedTasks(HashAnimal)
				FollowAnimal = false
			end
		elseif functions == "putvehicle" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				local vehicle = GetVehiclePedIsUsing(Ped)
				if IsVehicleSeatFree(vehicle, 0) then
					TaskEnterVehicle(HashAnimal, vehicle, -1, 0, 2.0, 16, 0)
				end
			end
		elseif functions == "removevehicle" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				TaskLeaveVehicle(HashAnimal, GetVehiclePedIsUsing(Ped), 256)
				TriggerEvent("dynamic:animalFunctions", "follow")
			end
		elseif functions == "destroy" then
			vSERVER.ClearAnimal()
			FollowAnimal = false
			HashAnimal = nil
		end
	end
end)