-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("garages", Creative)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECORATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("PlayerVehicle", 3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Opened = "1"
local Searched = nil
local Hotwired = false
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local blipRegistry = {}
local blipRefs = {}
local actualGaragesNumber = nil
local closed = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMods(Vehicle, Customize)
	if Customize then
		SetVehicleModKit(Vehicle, 0)

		if Customize["wheeltype"] ~= nil then
			SetVehicleWheelType(Vehicle, Customize["wheeltype"])
		end

		if Customize["mods"] then
			for i = 0, 16 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end

			for i = 17, 22 do
				if Customize["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end

			for i = 23, 24 do
				if Customize["mods"][tostring(i)] ~= nil then
					if not Customize["var"] then
						Customize["var"] = {}
						Customize["var"][tostring(i)] = 0
					end

					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)], Customize["var"][tostring(i)])
				end
			end

			for i = 25, 48 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end
		end

		if Customize["neon"] ~= nil then
			for i = 0, 3 do
				SetVehicleNeonLightEnabled(Vehicle, i, Customize["neon"][tostring(i)])
			end
		end

		if Customize["extras"] ~= nil then
			for i = 1, 12 do
				local onoff = tonumber(Customize["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(Vehicle, i, 0)
				else
					SetVehicleExtra(Vehicle, i, 1)
				end
			end
		end

		if Customize["liverys"] ~= nil and Customize["liverys"] ~= 24 then
			SetVehicleLivery(Vehicle, Customize["liverys"])
		end

		if Customize["plateIndex"] ~= nil and Customize["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(Vehicle, Customize["plateIndex"])
		end

		SetVehicleXenonLightsColour(Vehicle, Customize["xenonColor"])
		SetVehicleColours(Vehicle, Customize["colors"][1], Customize["colors"][2])
		SetVehicleExtraColours(Vehicle, Customize["extracolors"][1], Customize["extracolors"][2])
		SetVehicleNeonLightsColour(Vehicle, Customize["lights"][1], Customize["lights"][2], Customize["lights"][3])
		SetVehicleTyreSmokeColor(Vehicle, Customize["smokecolor"][1], Customize["smokecolor"][2],
			Customize["smokecolor"][3])

		if Customize["tint"] ~= nil then
			SetVehicleWindowTint(Vehicle, Customize["tint"])
		end

		if Customize["dashColour"] ~= nil then
			SetVehicleInteriorColour(Vehicle, Customize["dashColour"])
		end

		if Customize["interColour"] ~= nil then
			SetVehicleDashboardColour(Vehicle, Customize["interColour"])
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SpawnPosition(Select)
	local Selected = {}
	local Position = nil

	if GaragesCoords[Select] then
		if string.sub(Select, 1, 9) == "Propertys" then
			local propertysData = GaragesCoords[Select]
			local propertysCoords = vec3(propertysData.x, propertysData.y, propertysData.z)
			local propertysSpawn = propertysData["1"]
			local _, CoordsZ = GetGroundZFor_3dCoord(propertysSpawn[1], propertysSpawn[2], propertysSpawn[3])
			Selected = { propertysSpawn[1], propertysSpawn[2], CoordsZ, propertysSpawn[4] }
			Position = GetClosestVehicle(Selected[1], Selected[2], Selected[3], 3.5, 0, 71)
			if not DoesEntityExist(Position) then
				return Selected
			end
		else
			for i, spawnPosition in ipairs(GaragesCoords[Select].spawnPosition) do
				local _, CoordsZ = GetGroundZFor_3dCoord(spawnPosition[1], spawnPosition[2], spawnPosition[3])
				Selected = { spawnPosition[1], spawnPosition[2], CoordsZ, spawnPosition[4] }
				Position = GetClosestVehicle(Selected[1], Selected[2], Selected[3], 2.5, 0, 71)
				if not DoesEntityExist(Position) then
					return Selected
				end
			end
		end
	end

	TriggerEvent("Notify", "amarelo", "Vagas estão ocupadas.", "Atenção", 5000)
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateVehicle(Model, Network, Engine, Health, Customize, Windows, Tyres, Brakes, PedIntoVehicle)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Customize ~= nil then
				local Mods = json.decode(Customize)
				VehicleMods(Vehicle, Mods)
			end

			SetVehicleEngineHealth(Vehicle, Engine + 0.0)
			SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
			SetVehicleNeedsToBeHotwired(Vehicle, false)
			DecorSetInt(Vehicle, "PlayerVehicle", -1)
			SetVehicleOnGroundProperly(Vehicle)
			SetVehRadioStation(Vehicle, "OFF")
			SetEntityHealth(Vehicle, Health)

			SetVehicleDirtLevel(Vehicle, 0.0)

			if Windows then
				local Windows = json.decode(Windows)
				if Windows ~= nil then
					for Index, v in pairs(Windows) do
						if not v then
							RemoveVehicleWindow(Vehicle, parseInt(Index))
						end
					end
				end
			end

			if Tyres then
				local Tyres = json.decode(Tyres)
				if Tyres ~= nil then
					for Index, Burst in pairs(Tyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle, parseInt(Index), true, 1000.0)
						end
					end
				end
			end

			if Model == "maverick2" then
				if LocalPlayer["state"]["Policia"] or LocalPlayer["state"]["PoliciaNorte"] then
					SetVehicleLivery(Vehicle, 0)
				elseif LocalPlayer["state"]["Paramedico"] then
					SetVehicleLivery(Vehicle, 1)
				end
			end

			if not DecorExistOn(Vehicle, "PlayerVehicle") then
				DecorSetInt(Vehicle, "PlayerVehicle", -1)
			end

			if GetVehicleClass(Vehicle) == 14 then
				SetBoatAnchor(Vehicle, true)
			end

			SetModelAsNoLongerNeeded(Model)

			if PedIntoVehicle then
				SetPedIntoVehicle(PlayerPedId(), Vehicle, -1)
			end
		end
	end

	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GetVehiclesInArea
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehiclesInArea(coords, radius)
	local vehicles = {}
	local handle, vehicle = FindFirstVehicle()
	local success
	repeat
		local pos = GetEntityCoords(vehicle)
		local distance = GetDistanceBetweenCoords(pos, coords.x, coords.y, coords.z, true)
		if distance < radius then
			table.insert(vehicles, vehicle)
		end
		success, vehicle = FindNextVehicle(handle)
	until not success
	EndFindVehicle(handle)
	return vehicles
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ClosestVehicleModelOnRadius
-----------------------------------------------------------------------------------------------------------------------------------------
function ClosestVehicleModelOnRadius(Radius, Model)
	local playerPed = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(playerPed)

	local vehicles = GetVehiclesInArea(playerCoords, Radius)
	for i, vehicle in ipairs(vehicles) do
		local model = GetEntityModel(vehicle)

		if model == GetHashKey(Model) then
			return vehicle
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete", function(Vehicle)
	local Distance = 25
	if vSERVER.CheckGlobalDetelePermission() then
		Distance = 500000
	end
	if Vehicle then
		Vehicle = ClosestVehicleModelOnRadius(Distance, Vehicle)
	end

	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(Distance)
	end

	if IsEntityAVehicle(Vehicle) and (not Entity(Vehicle)["state"]["Tow"] or LocalPlayer["state"]["Admin"]) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0, 5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle, i)
		end

		for i = 0, 5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle, i)
		end

		for i = 0, 7 do
			local Status = false

			if GetTyreHealth(Vehicle, i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		if DecorExistOn(Vehicle, "PlayerVehicle") then
			DecorRemove(Vehicle, "PlayerVehicle")
		end

		vSERVER.Delete(VehToNet(Vehicle), GetEntityHealth(Vehicle), GetVehicleEngineHealth(Vehicle),
			GetVehicleBodyHealth(Vehicle), GetVehicleFuelLevel(Vehicle), Doors, Windows, Tyres,
			GetVehicleNumberPlateText(Vehicle),
			{ GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeForce"),
				GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeBiasFront"),
				GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fHandBrakeForce") })
		TriggerEvent("Notify", "amarelo", "Veiculo deletado com sucesso.", "Atenção", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SearchBlip(Coords)
	if DoesBlipExist(Searched) then
		RemoveBlip(Searched)
		Searched = nil
	end

	Searched = AddBlipForCoord(Coords["x"], Coords["y"], Coords["z"])
	SetBlipSprite(Searched, 225)
	SetBlipColour(Searched, 77)
	SetBlipScale(Searched, 0.6)
	SetBlipAsShortRange(Searched, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(Searched)

	SetTimeout(30000, function()
		RemoveBlip(Searched)
		Searched = nil
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StartHotwired()
	Hotwired = true

	if LoadAnim(Dict) then
		TaskPlayAnim(PlayerPedId(), Dict, Anim, 8.0, 8.0, -1, 49, 1, 0, 0, 0)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StopHotwired(Vehicle)
	Hotwired = false

	if LoadAnim(Dict) then
		StopAnimTask(PlayerPedId(), Dict, Anim, 8.0)
	end

	if Vehicle then
		SetEntityAsMissionEntity(Vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
		SetVehicleNeedsToBeHotwired(Vehicle, false)

		if not DecorExistOn(Vehicle, "PlayerVehicle") then
			DecorSetInt(Vehicle, "PlayerVehicle", -1)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UpdateHotwired(Status)
	Hotwired = Status
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound", function()
	local Impound = vSERVER.Impound()
	if parseInt(#Impound) > 0 then
		for k, v in pairs(Impound) do
			exports["dynamic"]:AddButton(v["name"], "Clique para iniciar a liberação.", "garages:Impound", v["Model"],
				'Apreendidos', true)
		end
		exports["dynamic"]:SubMenu("Veiculos", "Veiculos apreendidos.", "Apreendidos")
		exports["dynamic"]:openMenu()
	else
		TriggerEvent("Notify", "amarelo", "Você não possui veículos apreendidos.", "Atenção", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function GarageBlips(x, y, z, name, id, color, scale, perm)
	local Blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(Blip, id)
	SetBlipDisplay(Blip, 4)
	SetBlipAsShortRange(Blip, true)
	SetBlipColour(Blip, color)
	SetBlipScale(Blip, scale)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(name)
	EndTextCommandSetBlipName(Blip)
	if perm then
		for _, Permission in pairs(perm) do
			blipRefs[Permission] = Blip
		end
	end
	return Blip
end

function removeBlip(index)
	if blipRegistry[index] then
		RemoveBlip(blipRegistry[index])
		blipRegistry[index] = nil
	end
end

function createBlip(index, x, y, z, name, blipId, blipColor, blipScale)
	if not blipRegistry[index] then
		local blip = GarageBlips(x, y, z, name, blipId, blipColor, blipScale)
		blipRegistry[index] = blip
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Adicionar blips
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Ped = PlayerPedId()
	local HoverfyTables = {}
	for k, v in pairs(GaragesCoords) do
		local GarageCoords = v.coord
		local CoordConfig = v.config
		local Config = Garages[CoordConfig]
		local hasPerm = false

		if Config.perm then
			for _, Permission in pairs(Config.perm) do
				if LocalPlayer.state[Permission] then
					hasPerm = true
					break
				end
			end
		end

		if hasPerm or not Config.perm then
			local index = #HoverfyTables + 1
			HoverfyTables[index] = { GarageCoords.x, GarageCoords.y, GarageCoords.z, 2.5, "E", "Garagem",
				"Pressione para abrir" }

			if v.showBlip and not blipRegistry[index] then
				createBlip(index, GarageCoords.x, GarageCoords.y, GarageCoords.z, Config.blip.name, Config.blip.blipId,
					Config.blip.blipColor, Config.blip.blipScale)
				blipRegistry[index] = true
			end
		end
		Wait(50)
	end
	TriggerEvent("hoverfy:Insert", HoverfyTables)
end)

for Index, _ in pairs(ClientState) do
	AddStateBagChangeHandler(Index, ("player:%s"):format(LocalPlayer["state"]["Player"]), function(Name, Key, Value)
		Active = Key
		if Value then
			local Ped = PlayerPedId()
			local HoverfyTables = {}
			for k, v in pairs(GaragesCoords) do
				local GarageCoords = v.coord
				local CoordConfig = v.config
				if CoordConfig then
					local Config = Garages[CoordConfig]
					local hasPerm = false

					if Config.perm then
						for _, Permission in pairs(Config.perm) do
							if LocalPlayer.state[Permission] then
								hasPerm = true
								break
							end
						end
					end

					if hasPerm or not Config.perm then
						local index = #HoverfyTables + 1
						HoverfyTables[index] = { GarageCoords.x, GarageCoords.y, GarageCoords.z, 2.5, "E", "Garagem",
							"Pressione para abrir" }

						if v.showBlip then
							GarageBlips(GarageCoords.x, GarageCoords.y, GarageCoords.z, Config.blip.name,
								Config.blip.blipId,
								Config.blip.blipColor, Config.blip.blipScale, Config.perm)
						end
					end
					Wait(50)
				end
			end
			TriggerEvent("hoverfy:Insert", HoverfyTables)
		else
			if blipRefs[Active] then
				RemoveBlip(blipRefs[Active])
				blipRefs[Active] = nil
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
local classBypass = {}
local function getVehicleClass(vehicle)
	local vehicleClass = GetVehicleClassFromName(vehicle)
	return classBypass[vehicleClass]
end

CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			for Number, v in pairs(GaragesCoords) do
				if string.sub(Number, 1, 9) == "Propertys" then
					local propertysCoords = vec3(v.x, v.y, v.z)
					local Distance = #(Coords - propertysCoords)

					if Distance <= 5.0 then
						TimeDistance = 1
						DrawMarker(23, propertysCoords.x, propertysCoords.y, propertysCoords.z - 0.95, 0.0, 0.0, 0.0, 0.0,
							0.0, 0.0, 1.75, 1.75, 0.0, 65, 130, 226, 100, 0, 0, 0, 0)

						if Distance <= 1.25 then
							DisableControlAction(0, 24, true)
							if IsControlJustPressed(1, 38) and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Target"] then
								local Vehicles = vSERVER.Vehicles(Number)
								actualGaragesNumber = Number
								if Vehicles then
									closed = false
									Opened = Number
									SetNuiFocus(true, true)
									for i = 1, #Vehicles do
										Vehicles[i].category = VehicleClass(VehicleIndexByName(Vehicles[i].name))
										if not Vehicles[i]["status"] then
											Vehicles[i]["status"] = {}
										end

										if not Vehicles[i]["tax"] then
											Vehicles[i]["tax"] = {}
										end

										if type(Vehicles[i]["tax"]) ~= "table" then
											Vehicles[i]["tax"] = {}
										end

										Vehicles[i]["status"].engine = (Vehicles[i].engine / 10)
										Vehicles[i]["status"].chassi = (Vehicles[i].chassi / 10)
										Vehicles[i]["status"].gas = Vehicles[i].gas
										Vehicles[i]["tax"].renovationDate = Vehicles[i].renovation
										Vehicles[i]["tax"].value = Vehicles[i].price
									end
									SendNUIMessage({ action = "setData", payload = { garage = Vehicles } })
									SendNUIMessage({ action = "openNUI" })
									while not closed do
										SetNuiFocus(true, true)
										Wait(0)
									end
								end
							end
						end
					end
				else
					local Distance = #(Coords - v.coord)

					if Distance <= 8.0 then
						TimeDistance = 1
						DrawMarker(23, v.coord.x, v.coord.y, v.coord.z - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.75, 1.75,
							0.0, 83, 20, 163, 100, 0, 0, 0, 0)
						if Distance <= 1.25 then
							DisableControlAction(0, 24, true)
							if IsControlJustPressed(1, 38) and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Target"] then
								local Vehicles = vSERVER.Vehicles(Number)
								actualGaragesNumber = Number
								if Vehicles then
									Opened = Number
									closed = false
									SetNuiFocus(true, true)
									local allVehicles = {}
									for i = 1, #Vehicles do
										local originalVehicle = {}
										for k, v in pairs(Vehicles[i]) do
											originalVehicle[k] = v
										end
										originalVehicle.category = VehicleClass(VehicleIndexByName(Vehicles[i].name))

										if not originalVehicle["status"] then
											originalVehicle["status"] = {}
										end

										if not originalVehicle["tax"] then
											originalVehicle["tax"] = {}
										end

										if type(originalVehicle["tax"]) ~= "table" then
											originalVehicle["tax"] = {}
										end

										originalVehicle["tax"].tax = Vehicles[i].nextTax
										originalVehicle["status"].engine = (Vehicles[i].engine / 10)
										originalVehicle["status"].chassi = (Vehicles[i].chassi / 10)
										originalVehicle["status"].gas = Vehicles[i].gas
										originalVehicle["tax"].renovationDate = Vehicles[i].renovation
										originalVehicle["tax"].value = Vehicles[i].price

										table.insert(allVehicles, originalVehicle)
									end

									for i = 1, #Vehicles do
										local newVehicle = {}
										for k, v in pairs(Vehicles[i]) do
											newVehicle[k] = v
										end
										newVehicle.category = 'Todos'

										table.insert(allVehicles, newVehicle)
									end

									SendNUIMessage({ action = "setData", payload = { garage = allVehicles } })
									SendNUIMessage({ action = "openNUI" })

									while not closed do
										SetNuiFocus(true, true)
										Wait(0)
									end
								end
							end
						end
					end
				end
			end
		end
		Wait(TimeDistance)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Close")
AddEventHandler("garages:Close", function()
	SendNUIMessage({ action = "closeNUI" })
	actualGaragesNumber = nil
	closed = true
	SetNuiFocus(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(Data, Callback)
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "closeNUI" })
	closed = true
	actualGaragesNumber = nil

	Callback("ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local takeVehicleCooldown = false
RegisterNUICallback("takeVehicle", function(Data, Callback)
	if not takeVehicleCooldown then
		takeVehicleCooldown = true
		vSERVER.Spawn(Data["model"], Opened)
		SetTimeout(2000, function()
			takeVehicleCooldown = false
		end)
	end
	Callback("Ok")
end)

RegisterNUICallback("spawnVehicles", function(Data, Callback)
	if not takeVehicleCooldown then
		takeVehicleCooldown = true
		vSERVER.Spawn(Data["name"], Opened)
		SetTimeout(2000, function()
			takeVehicleCooldown = false
		end)
	end
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteVehicles", function(Data, Callback)
	TriggerEvent("garages:Delete")
	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellVehicle", function(Data, Callback)
	if vSERVER.Sell(Data) then
		SendNUIMessage({ action = "closeNUI" })
		if actualGaragesNumber then
			local Vehicles = vSERVER.Vehicles(actualGaragesNumber)
			if Vehicles then
				Opened = actualGaragesNumber
				SetNuiFocus(true, true)
				for i = 1, #Vehicles do
					Vehicles[i].category = VehicleClass(VehicleIndexByName(Vehicles[i].name))
					if not Vehicles[i]["status"] then
						Vehicles[i]["status"] = {}
					end

					if not Vehicles[i]["tax"] then
						Vehicles[i]["tax"] = {}
					end

					if type(Vehicles[i]["tax"]) ~= "table" then
						Vehicles[i]["tax"] = {}
					end

					Vehicles[i]["tax"].tax = Vehicles[i].nextTax
					Vehicles[i]["status"].engine = (Vehicles[i].engine / 10)
					Vehicles[i]["status"].chassi = (Vehicles[i].chassi / 10)
					Vehicles[i]["status"].gas = Vehicles[i].gas
					Vehicles[i]["tax"].renovationDate = Vehicles[i].renovation
					Vehicles[i]["tax"].value = Vehicles[i].price
				end
				SendNUIMessage({ action = "setData", payload = { garage = Vehicles } })
				SendNUIMessage({ action = "openNUI" })
			end
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("transferVehicle", function(Data, Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)

	vSERVER.Transfer(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("payVehicleTax", function(Data, Callback)
	if vSERVER.Tax(Data["model"], Data["all"]) then
		SendNUIMessage({ action = "closeNUI" })
		if actualGaragesNumber then
			local Vehicles = vSERVER.Vehicles(actualGaragesNumber)
			if Vehicles then
				Opened = actualGaragesNumber
				SetNuiFocus(true, true)
				for i = 1, #Vehicles do
					Vehicles[i].category = VehicleClass(VehicleIndexByName(Vehicles[i].name))
					if not Vehicles[i]["status"] then
						Vehicles[i]["status"] = {}
					end

					if not Vehicles[i]["tax"] then
						Vehicles[i]["tax"] = {}
					end

					if type(Vehicles[i]["tax"]) ~= "table" then
						Vehicles[i]["tax"] = {}
					end

					Vehicles[i]["tax"].tax = Vehicles[i].nextTax
					Vehicles[i]["status"].engine = (Vehicles[i].engine / 10)
					Vehicles[i]["status"].chassi = (Vehicles[i].chassi / 10)
					Vehicles[i]["status"].gas = Vehicles[i].gas
					Vehicles[i]["tax"].renovationDate = Vehicles[i].renovation
					Vehicles[i]["tax"].value = Vehicles[i].price
				end
				SendNUIMessage({ action = "setData", payload = { garage = Vehicles } })
				SendNUIMessage({ action = "openNUI" })
			end
		end
	end
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Propertys")
AddEventHandler("garages:Propertys", function(Table)
	for Name, v in pairs(Table) do
		GaragesCoords[Name] = {
			["x"] = v["x"],
			["y"] = v["y"],
			["z"] = v["z"],
			["1"] = v["1"]
		}
	end
end)


RegisterNUICallback("getCityName", function(Data, Callback)
	cityName = GetConvar("cityName", "")
	Callback(cityName)
end)

RegisterNetEvent("playVehicleAlarm", function(vehicle, time)
	if vehicle then
		local veh = NetToVeh(vehicle)
		if NetworkHasControlOfEntity(veh) then
			SetVehicleAlarm(veh, true)
			SetVehicleAlarmTimeLeft(veh, time or 15000)
		end
	end
end)