-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("markers",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Users()
	for Source,v in pairs(Players) do
		local Ped = GetPlayerPed(Source)
		if DoesEntityExist(Ped) then
			v["Coords"] = GetEntityCoords(Ped)
		end
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("markers:Add")
AddEventHandler("markers:Add",function(source,Service,Connect)
	Players[source] = {
		["Coords"] = vec3(0,0,0),
		["Service"] = Service
	}

	for Sources,_ in pairs(Players) do
		if Sources ~= source then
			TriggerClientEvent("markers:Add",Sources,source,Players[source])
		end
	end

	if Connect then
		TriggerClientEvent("markers:Full",source,Players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("markers:Remove",function(source)
	if Players[source] then
		Players[source] = nil
		TriggerClientEvent("markers:Clear",source)

		for Sources,_ in pairs(Players) do
			if Sources ~= source then
				TriggerClientEvent("markers:Remove",Sources,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Players[source] then
		Players[source] = nil

		for Sources,_ in pairs(Players) do
			TriggerClientEvent("markers:Remove",Sources,source)
		end
	end
end)