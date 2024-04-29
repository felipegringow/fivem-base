-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vSERVER = Tunnel.getInterface("admin")
tvRP = Tunnel.getInterface("vrp")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVISIBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Freeze = false
local Flash = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportWay()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Ped = GetVehiclePedIsUsing(Ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(GetBlipInfoIdCoord(waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(Ped,x,y,height,false,false,false)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(Ped) do
			Wait(1)
		end

		Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(Ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(Ped) do
		Wait(1)
	end

	SetEntityCoordsNoOffset(Ped,x,y,z,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportLimbo()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,xCoords = GetNthClosestVehicleNode(Coords["x"],Coords["y"],Coords["z"],1,0,0,0)

	SetEntityCoordsNoOffset(Ped,xCoords["x"],xCoords["y"],xCoords["z"] + 1,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ DEBUG ]
-----------------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug",function()
	dickheaddebug = not dickheaddebug
    if dickheaddebug then
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"ON")
        debugon()
    else
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"OFF")
    end
end)

local inFreeze = false

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function debugon()
Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        
        if dickheaddebug then
            local pos = GetEntityCoords(GetPlayerPed(-1))

            local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 

            local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    

            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
            
            
            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)

            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)

            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)

            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("Notify","amarelo","Freeze ON.",5000)
                else
                    inFreeze = true
                    TriggerEvent("Notify","amarelo","Freeze OFF.",5000)
                end
            end
        else
            Citizen.Wait(5000)
        end
    end
end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxtS(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local vehicle = GetVehiclePedIsUsing(Ped)

		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11) - 1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12) - 1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13) - 1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15) - 1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			vSERVER.buttonTxt()
-- 		end
-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			local Ped = PlayerPedId()
-- 			local vehicle = GetVehiclePedIsUsing(Ped)
-- 			local vehCoords = GetEntityCoords(vehicle)
-- 			local leftCoords = GetOffsetFromEntityInWorldCoords(vehicle,5.0,0.0,0.0)
-- 			local rightCoords = GetOffsetFromEntityInWorldCoords(vehicle,-5.0,0.0,0.0)

-- 			vSERVER.raceCoords(vehCoords,leftCoords,rightCoords)
-- 		end

-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)

		LocalPlayer["state"]["Spectate"] = true
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		LocalPlayer["state"]["Spectate"] = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.16)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DEBUGTOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:DebugToggle")
AddEventHandler("admin:DebugToggle",function()
    if not LocalPlayer["state"]["Debug"] then
		LocalPlayer["state"]["Debug"] = true
        debugOn()
        TriggerEvent("Notify","amarelo","Debug ON.",5000)
    else
		LocalPlayer["state"]["Debug"] = false
        TriggerEvent("Notify","amarelo","Debug OFF.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANPEDBEUSED
-----------------------------------------------------------------------------------------------------------------------------------------
function canPedBeUsed(Ped)
    if Ped == nil then
        return false
    end

    if Ped == PlayerPedId() then
        return false
    end

    if not DoesEntityExist(Ped) then
        return false
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehicle()
    local PlayerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local Handle,Veh = FindFirstVehicle()
    local Success
    local Rped = nil
    local DistanceFrom
    repeat
        local VehCoords = GetEntityCoords(Veh)
        local Distance = #(PlayerCoords - VehCoords)
        if canPedBeUsed(ped) and Distance < 30.0 and (DistanceFrom == nil or Distance < DistanceFrom) then
            DistanceFrom = Distance
            Rped = Veh

	    	if IsEntityTouchingEntity(PlayerPed,Veh) then
	    		DrawText3Ds(VehCoords["x"],VehCoords["y"],VehCoords["z"] + 1, "Veh: "..Veh.." Model: "..GetEntityModel(Veh).." IN CONTACT")
	    	else
	    		DrawText3Ds(VehCoords["x"],VehCoords["y"],VehCoords["z"] + 1, "Veh: "..Veh.." Model: "..GetEntityModel(Veh))
	    	end
        end
        Success,Veh = FindNextVehicle(Handle)
    until not Success
    EndFindVehicle(Handle)
    return Rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetObject()
    local PlayerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local Handle,Obj = FindFirstObject()
    local Success
    local Rped = nil
    local DistanceFrom
    repeat
        local ObjCoords = GetEntityCoords(Obj)
        local Distance = #(PlayerCoords - ObjCoords)
        if Distance < 10.0 then
            DistanceFrom = Distance
            Rped = Obj

	    	if IsEntityTouchingEntity(PlayerPed,Obj) then
	    		DrawText3Ds(ObjCoords["x"],ObjCoords["y"],ObjCoords["z"] + 1,"Obj: "..Obj.." Model: "..GetEntityModel(Obj).." IN CONTACT")
	    	else
	    		DrawText3Ds(ObjCoords["x"],ObjCoords["y"],ObjCoords["z"] + 1,"Obj: "..Obj.." Model: "..GetEntityModel(Obj))
	    	end

			-- FreezeEntityPosition(Obj,Freeze)
        end
        Success,Obj = FindNextObject(Handle)
    until not Success
    EndFindObject(Handle)
    return Rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPED
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPed()
    local PlayerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local Handle,Ped = FindFirstPed()
    local Success
    local Rped = nil
    local DistanceFrom
    repeat
        local PedCoords = GetEntityCoords(Ped)
        local Distance = #(PlayerCoords - PedCoords)
        if canPedBeUsed(Ped) and Distance < 30.0 and (DistanceFrom == nil or Distance < DistanceFrom) then
            DistanceFrom = Distance
            Rped = Ped

	    	if IsEntityTouchingEntity(PlayerPed,Ped) then
	    		DrawText3Ds(PedCoords["x"],PedCoords["y"],PedCoords["z"],"Ped: "..Ped.." Model: "..GetEntityModel(Ped).." Relationship HASH: "..GetPedRelationshipGroupHash(Ped).." IN CONTACT")
	    	else
	    		DrawText3Ds(PedCoords["x"],PedCoords["y"],PedCoords["z"],"Ped: "..Ped.." Model: "..GetEntityModel(Ped).." Relationship HASH: "..GetPedRelationshipGroupHash(Ped))
	    	end

            FreezeEntityPosition(Ped,Freeze)
        end
        Success,Ped = FindNextPed(Handle)
    until not Success
    EndFindPed(Handle)
    return Rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
function debugOn()
	CreateThread(function()
		while LocalPlayer["state"]["Debug"] do
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			local CoordsFor = GetOffsetFromEntityInWorldCoords(Ped,0,1.0,0.0)
			local CoordsBack = GetOffsetFromEntityInWorldCoords(Ped,0,-1.0,0.0)
			local CoordsLef = GetOffsetFromEntityInWorldCoords(Ped,1.0,0.0,0.0)
			local CoordsRig = GetOffsetFromEntityInWorldCoords(Ped,-1.0,0.0,0.0) 

			local CoordsFor2 = GetOffsetFromEntityInWorldCoords(Ped,0,2.0,0.0)
			local CoordsBack2 = GetOffsetFromEntityInWorldCoords(Ped,0,-2.0,0.0)
			local CoordsLef2 = GetOffsetFromEntityInWorldCoords(Ped,2.0,0.0,0.0)
			local CoordsRig2 = GetOffsetFromEntityInWorldCoords(Ped,-2.0,0.0,0.0)    

			local StreetHash,StreetCrossing = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])--
			StreetName = GetStreetNameFromHashKey(StreetHash)--

			drawTxtS(0.8,0.50,0.4,0.4,0.30,"Heading: "..GetEntityHeading(Ped),55,155,55,255)--
			drawTxtS(0.8,0.52,0.4,0.4,0.30,"Coords: "..Coords,55,155,55,255)--
			drawTxtS(0.8,0.54,0.4,0.4,0.30,"Attached Ent: "..GetEntityAttachedTo(Ped),55,155,55,255)--
			drawTxtS(0.8,0.56,0.4,0.4,0.30,"H a G: "..GetEntityHeightAboveGround(Ped),55,155,55,255)--
			drawTxtS(0.8,0.58,0.4,0.4,0.30,"Health: "..GetEntityHealth(Ped),55,155,55,255)--
			drawTxtS(0.8,0.60,0.4,0.4,0.30,"Model: "..GetEntityModel(Ped),55,155,55,255)--
			drawTxtS(0.8,0.62,0.4,0.4,0.30,"Speed: "..GetEntitySpeed(Ped),55,155,55,255)--
			drawTxtS(0.8,0.64,0.4,0.4,0.30,"Frame Time: "..GetFrameTime(),55,155,55,255)--
			drawTxtS(0.8,0.66,0.4,0.4,0.30,"Street: "..StreetName,55,155,55,255)--
			
			
			DrawLine(Coords,CoordsFor,255,0,0,115)
			DrawLine(Coords,CoordsBack,255,0,0,115)

			DrawLine(Coords,CoordsLef,255,255,0,115)
			DrawLine(Coords,CoordsRig,255,255,0,115)

			DrawLine(CoordsFor,CoordsFor2,255,0,255,115)
			DrawLine(CoordsBack,CoordsBack2,255,0,255,115)

			DrawLine(CoordsLef,CoordsLef2,255,255,255,115)
			DrawLine(CoordsRig,CoordsRig2,255,255,255,115)

			GetPed()
			GetVehicle()
			GetObject()

			if IsControlJustReleased(1,38) then
				Freeze = not Freeze

				if Freeze then
					TriggerEvent("Notify","amarelo","Freeze ON.",5000)
				else
					TriggerEvent("Notify","amarelo","Freeze OFF.",5000)
				end
			end

			Wait(1)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Quake",nil,function(Name,Key,Value)
	ShakeGameplayCam("SKY_DIVING_SHAKE",1.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Limparea(Coords)
	ClearAreaOfPeds(Coords["x"], Coords["y"], Coords["z"], 100.0, 0)
	ClearAreaOfCops(Coords["x"], Coords["y"], Coords["z"], 100.0, 0)
	ClearAreaOfObjects(Coords["x"], Coords["y"], Coords["z"], 100.0, 0)
	ClearAreaOfProjectiles(Coords["x"], Coords["y"], Coords["z"], 100.0, 0)
	ClearAreaOfVehicles(Coords["x"], Coords["y"], Coords["z"], 100.0, false, false, false, false, false)
	ClearAreaLeaveVehicleHealth(Coords["x"], Coords["y"], Coords["z"], 100.0, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:FLASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:Flash")
AddEventHandler("admin:Flash", function()
	local Pid = PlayerId()
	if not Flash then
		TriggerEvent("Notify", "verde", "Super velocidade ativada.", "Sucesso", 5000)
		SetRunSprintMultiplierForPlayer(Pid, 1.49)
		SetPedMoveRateOverride(Pid, 10.0)
		Flash = true
	else
		Flash = false
		SetRunSprintMultiplierForPlayer(Pid, 1.0)
		TriggerEvent("Notify", "amarelo", "Super velocidade desativada.", "Atenção", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXTS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxtS(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25,0.25)
    SetTextColour(r,g,b,a)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2,y - height / 2 + 0.005)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3DS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(204,204,204,175)
		BeginTextCommandDisplayText("STRING")
		SetTextCentre(1)
		AddTextComponentSubstringKeyboardDisplay(text)
		EndTextCommandDisplayText(_x,_y)
		DrawText(_x,_y)
		local width = string.len(text) / 300
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,200)
	end
end