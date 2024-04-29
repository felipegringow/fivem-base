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
vSERVER = Tunnel.getInterface("routes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {}
local inCollect = 1
local inSeconds = 0
local inDelivery = 1
local inService = false
local blipCollect = nil
local blipDelivery = nil
local lastService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(Works) do
				local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
				if distance <= 2 then
					timeDistance = 1

					if not inService then
						DrawText3D(v["coords"][1],v["coords"][2],v["coords"][3],"~g~E~w~   INICIAR")
					else
						DrawText3D(v["coords"][1],v["coords"][2],v["coords"][3],"~g~E~w~   FINALIZAR")
					end

					if IsControlJustPressed(1,38) and inSeconds <= 0 then
						inSeconds = 3

						if not inService then
							if vSERVER.Permission(k) then
								inService = k

								if v["deliveryCoords"] ~= nil then
									if lastService ~= k then
										if v["routeDelivery"] then
											inCollect = 1
										else
											inDelivery = math.random(#Works[k]["deliveryCoords"])
										end
									end

									makeDeliveryMarked(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3])
								end

								if v["collectCoords"] ~= nil then
									if lastService ~= k then
										if v["routeCollect"] then
											inCollect = 1
										else
											inCollect = math.random(#Works[k]["collectCoords"])
										end
									end

									makeCollectMarked(v["collectCoords"][inCollect][1],v["collectCoords"][inCollect][2],v["collectCoords"][inCollect][3])
								end

								TriggerEvent("Notify","amarelo","Serviço iniciado.",5000)
							end
						else
							if inService == k then
								lastService = k
								inService = false
								TriggerEvent("Notify","amarelo","Serviço finalizado.",5000)

								if DoesBlipExist(blipCollect) then
									RemoveBlip(blipCollect)
									blipCollect = nil
								end

								if DoesBlipExist(blipDelivery) then
									RemoveBlip(blipDelivery)
									blipDelivery = nil
								end
							else
								TriggerEvent("Notify","amarelo","Finalize o emprego anterior para iniciar um novo.",5000)
							end
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if inService then
			local ped = PlayerPedId()
			if (Works[inService]["usingVehicle"] and IsPedInAnyVehicle(ped)) or (not Works[inService]["usingVehicle"] and not IsPedInAnyVehicle(ped)) then
				local coords = GetEntityCoords(ped)

				if Works[inService]["collectCoords"] ~= nil then
					local distance = #(coords - vector3(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3]))
					if distance <= Works[inService]["collectShowDistance"] then
						timeDistance = 1

						DrawText3D(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3],"~g~E~w~   "..Works[inService]["collectText"])

						if distance <= Works[inService]["collectButtonDistance"] and inSeconds <= 0 and IsControlJustPressed(1,38) then
							inSeconds = 3

							if Works[inService]["collectAnim"] ~= nil then
								LocalPlayer["state"]["Cancel"] = true
								LocalPlayer["state"]["Commands"] = true
								TriggerEvent("Progress",Works[inService]["collectDuration"] + 500)
								SetEntityHeading(ped,Works[inService]["collectCoords"][inCollect][4])
								SetEntityCoords(ped,Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3] - 1,1,0,0,0)
								vRP.playAnim(Works[inService]["collectAnim"][1],{Works[inService]["collectAnim"][2],Works[inService]["collectAnim"][3]},Works[inService]["collectAnim"][4])

								Wait(Works[inService]["collectDuration"])

								LocalPlayer["state"]["Commands"] = false
								LocalPlayer["state"]["Cancel"] = false
								vRP.removeObjects()
							end

							if Works[inService]["routeCollect"] then
								if Works[inService]["collectVehicle"] ~= nil then
									local vehicle = GetLastDrivenVehicle()
									local vehHash = Works[inService]["collectVehicle"]

									if IsVehicleModel(vehicle,vehHash) then
										if vSERVER.Collect(inService) then
											if inCollect >= #Works[inService]["collectCoords"] then
												inCollect = 1
											else
												inCollect = inCollect + 1
											end

											makeCollectMarked(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3])
										end
									else
										TriggerEvent("Notify","amarelo","Precisa utilizar o veículo do <b>"..inService.."</b>.",3000)
									end
								else
									if vSERVER.Collect(inService) then
										if inCollect >= #Works[inService]["collectCoords"] then
											inCollect = 1
										else
											inCollect = inCollect + 1
										end

										makeCollectMarked(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3])
									end
								end
							else
								if Works[inService]["collectVehicle"] ~= nil then
									local vehicle = GetLastDrivenVehicle()
									local vehHash = Works[inService]["collectVehicle"]

									if IsVehicleModel(vehicle,vehHash) then
										if vSERVER.Collect(inService) then
											inCollect = math.random(#Works[inService]["collectCoords"])
											makeCollectMarked(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3])
										end
									else
										TriggerEvent("Notify","amarelo","Precisa utilizar o veículo do <b>"..inService.."</b>.",3000)
									end
								else
									if vSERVER.Collect(inService) then
										inCollect = math.random(#Works[inService]["collectCoords"])

										makeCollectMarked(Works[inService]["collectCoords"][inCollect][1],Works[inService]["collectCoords"][inCollect][2],Works[inService]["collectCoords"][inCollect][3])
									end
								end
							end
						end
					end
				end

				if Works[inService]["deliveryCoords"] ~= nil then
					local distance = #(coords - vector3(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3]))
					if distance <= 30 then
						timeDistance = 1

						DrawText3D(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3],"~g~E~w~   "..Works[inService]["deliveryText"])

						if distance <= 1 and inSeconds <= 0 and IsControlJustPressed(1,38) then
							inSeconds = 3

							if Works[inService]["routeDelivery"] then
								if Works[inService]["deliveryVehicle"] ~= nil then
									local vehicle = GetLastDrivenVehicle()
									local vehHash = Works[inService]["deliveryVehicle"]

									if IsVehicleModel(vehicle,vehHash) then
										if vSERVER.Delivery(inService) then
											if inDelivery >= #Works[inService]["deliveryCoords"] then
												inDelivery = 1
											else
												inDelivery = inDelivery + 1
											end

											makeDeliveryMarked(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3])
										end
									else
										TriggerEvent("Notify","amarelo","Precisa utilizar o veículo do <b>"..inService.."</b>.",3000)
									end
								else
									if vSERVER.Delivery(inService) then
										if inDelivery >= #Works[inService]["deliveryCoords"] then
											inDelivery = 1
										else
											inDelivery = inDelivery + 1
										end

										makeDeliveryMarked(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3])
									end
								end
							else
								if Works[inService]["deliveryVehicle"] ~= nil then
									local vehicle = GetLastDrivenVehicle()
									local vehHash = Works[inService]["deliveryVehicle"]

									if IsVehicleModel(vehicle,vehHash) then
										if vSERVER.Delivery(inService) then
											inDelivery = math.random(#Works[inService]["deliveryCoords"])
											makeDeliveryMarked(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3])
										end
									else
										TriggerEvent("Notify","amarelo","Precisa utilizar o veículo do <b>"..inService.."</b>.",3000)
									end
								else
									if vSERVER.Delivery(inService) then
										inDelivery = math.random(#Works[inService]["deliveryCoords"])
										makeDeliveryMarked(Works[inService]["deliveryCoords"][inDelivery][1],Works[inService]["deliveryCoords"][inDelivery][2],Works[inService]["deliveryCoords"][inDelivery][3])
									end
								end
							end
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if inSeconds > 0 then
			inSeconds = inSeconds - 1
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Status)
	Works = Status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKECOLLECTMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeCollectMarked(x,y,z)
	if DoesBlipExist(blipCollect) then
		RemoveBlip(blipCollect)
		blipCollect = nil
	end

	if inService then
		blipCollect = AddBlipForCoord(x,y,z)
		SetBlipSprite(blipCollect,12)
		SetBlipColour(blipCollect,2)
		SetBlipScale(blipCollect,0.9)
		SetBlipRoute(blipCollect,true)
		SetBlipAsShortRange(blipCollect,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coletar")
		EndTextCommandSetBlipName(blipCollect)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEDELIVERYMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeDeliveryMarked(x,y,z)
	if DoesBlipExist(blipDelivery) then
		RemoveBlip(blipDelivery)
		blipDelivery = nil
	end

	if inService then
		blipDelivery = AddBlipForCoord(x,y,z)
		SetBlipSprite(blipDelivery,12)
		SetBlipColour(blipDelivery,5)
		SetBlipScale(blipDelivery,0.9)
		SetBlipRoute(blipDelivery,true)
		SetBlipAsShortRange(blipDelivery,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Entregar")
		EndTextCommandSetBlipName(blipDelivery)
	end
end