-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("markers")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Markers = {}
local Players = {}
local Pause = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
local Colors = {
	["Policia"] = 63,
	["Paramedico"] = 6,
	["Mecanico"] = 82,
	["Prisioneiro"] = 33,
	["Corredor"] = 32
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORSTART
-----------------------------------------------------------------------------------------------------------------------------------------
for Index,_ in pairs(Colors) do
	AddStateBagChangeHandler(Index,("player:%s"):format(LocalPlayer["state"]["Player"]),function(Name,Key,Value)
		Active = Key

		if not Value then
			Active = false
			TriggerEvent("markers:Clear")
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] and Colors[Active] then
			if LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"] or LocalPlayer["state"]["Mechanic"] then
				if IsPauseMenuActive() then
					if not Pause then
						Pause = true

						for Number,_ in pairs(Markers) do
							RemoveBlip(Markers[Number])
							Markers[Number] = nil
						end
					end

					local List = vSERVER.Users()

					for Number,v in pairs(List) do
						if Markers[Number] then
							async(function()
								MoveBlipSmooth(Markers[Index],v["Coords"])
							end)
						else
							Markers[Number] = AddBlipForCoord(v["Coords"])
							SetBlipSprite(Markers[Number],1)
							SetBlipDisplay(Markers[Number],4)
							SetBlipAsShortRange(Markers[Number],true)
							SetBlipColour(Markers[Number],Colors[v["Service"]])
							SetBlipScale(Markers[Number],0.7)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("! "..v["Service"])
							EndTextCommandSetBlipName(Markers[Number])
						end
					end
				else
					if Pause then
						Pause = false

						for Number,_ in pairs(Markers) do
							RemoveBlip(Markers[Number])
							Markers[Number] = nil
						end
					end

					local Active = GetPlayers()
					for Number,v in pairs(Players) do
						if Active[Number] then
							if not Markers[Number] then
								local source = GetPlayerFromServerId(Number)
								local Ped = GetPlayerPed(source)

								Markers[Number] = AddBlipForEntity(Ped)
								SetBlipSprite(Markers[Number],1)
								SetBlipDisplay(Markers[Number],4)
								SetBlipShowCone(Markers[Number],true)
								SetBlipAsShortRange(Markers[Number],true)
								SetBlipColour(Markers[Number],Colors[v["Service"]])
								SetBlipScale(Markers[Number],0.7)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("! "..v["Service"])
								EndTextCommandSetBlipName(Markers[Number])
							end
						else
							if Markers[Number] then
								RemoveBlip(Markers[Number])
								Markers[Number] = nil
							end
						end
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEBLIPSMOOTH
-----------------------------------------------------------------------------------------------------------------------------------------
function MoveBlipSmooth(Blip,Coords)
	local Timer = 0.0
	local Delay = GetGameTimer()
	local Start = GetBlipCoords(Blip)

	while Timer < 1.0 do
		if GetTimeDifference(GetGameTimer(),Delay) > 10 then
			Delay = GetGameTimer()
			Timer = Timer + 0.01

			if DoesBlipExist(Blip) then
				SetBlipCoords(Blip,Start - (Timer * (Start - Coords)))
			else
				Timer = 1.0
			end
		end

		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:FULL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Full")
AddEventHandler("markers:Full",function(Table)
	Players = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Add")
AddEventHandler("markers:Add",function(source,Table)
	Players[source] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Remove")
AddEventHandler("markers:Remove",function(source)
	if Players[source] then
		Players[source] = nil
	end

	if Markers[source] then
		if DoesBlipExist(Markers[source]) then
			RemoveBlip(Markers[source])
			Markers[source] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Clear")
AddEventHandler("markers:Clear",function()
	for Number,_ in pairs(Markers) do
		RemoveBlip(Markers[Number])
	end

	Pause = false
	Players = {}
	Markers = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local PlayerList = {}

	for _,v in ipairs(GetActivePlayers()) do
		PlayerList[GetPlayerServerId(v)] = true
	end

	return PlayerList
end