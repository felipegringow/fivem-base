-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Camera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Locate = {
	{ ["Coords"] = vec3(-2205.92,-370.48,13.29), ["name"] = "" },
	{ ["Coords"] = vec3(-2205.92,-370.48,13.29), ["name"] = "" },
	{ ["Coords"] = vec3(-250.35,6209.71,31.49), ["name"] = "" },
	{ ["Coords"] = vec3(1694.37,4794.66,41.92), ["name"] = "" },
	{ ["Coords"] = vec3(1858.94,3741.78,33.09), ["name"] = "" },
	{ ["Coords"] = vec3(328.0,2617.89,44.48), ["name"] = "" },
	{ ["Coords"] = vec3(308.33,-232.25,54.07), ["name"] = "" },
	{ ["Coords"] = vec3(449.71,-659.27,28.48), ["name"] = "" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMS
-----------------------------------------------------------------------------------------------------------------------------------------
local Anims = {
	{ ["Dict"] = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", ["Name"] = "hi_dance_crowd_17_v2_male^2" },
	{ ["Dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", ["Name"] = "high_center_down" },
	{ ["Dict"] = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", ["Name"] = "med_center_up" }
}



RegisterCommand("spawn",function()	
	if vSERVER.checkPerm() then
		
		TriggerEvent("spawn:Opened")
	end
end)
AddEventHandler("onResourceStart",function(Resource)
	if "spawn" == Resource then
		TriggerEvent("spawn:Opened")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Opened")
AddEventHandler("spawn:Opened",function()
	local Ped = PlayerPedId()
	SetEntityCoords(Ped,233.85,-1387.59,29.55,false,false,false,false)
	LocalPlayer["state"]:set("Invincible",true,true)
	LocalPlayer["state"]:set("Invisible",true,true)
	SetEntityVisible(Ped,false,false)
	FreezeEntityPosition(Ped,true)
	SetEntityInvincible(Ped,true)
	SetEntityHeading(Ped,136.07)
	SetEntityHealth(Ped,101)
	SetPedArmour(Ped,0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,232.0,-1388.64,30.45)
	RenderScriptCams(true,true,0,true,true)
	SetCamRot(Camera,0.0,0.0,320.0,2)
	SetCamActive(Camera,true)

	Characters = vSERVER.Characters()
	if parseInt(#Characters) > 0 then
		Customization(Characters[1])
	end

	Wait(5000)

	SendNUIMessage({ Action = "Spawn", Table = Characters })
	SetNuiFocus(true,true)

	if IsScreenFadedOut() then
		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(Data,Callback)
	if vSERVER.CharacterChosen(Data["Passport"]) then
		SendNUIMessage({ Action = "Close" })
	end
	Characters = vSERVER.Characters()
	if parseInt(#Characters) > 0 then
		Customization(Characters[Data["Passport"]])
	end
	vSERVER.FinshSpawn()
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter",function(Data,Callback)
	vSERVER.NewCharacter(Data["name"],Data["lastname"],Data["sex"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SwitchCharacter",function(Data,Callback)
	for _,v in pairs(Characters) do
		if v["Passport"] == Data["Passport"] then
			Customization(v,true)
			break
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- spawn:justSpawn
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:justSpawn")
AddEventHandler("spawn:justSpawn",function(Open,Barbershop)
	if Open then
		Locate[1] = { ["Coords"] = Barbershop, ["name"] = "" }

		for Number,v in pairs(Locate) do
			local Road = GetStreetNameAtCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])
			Locate[Number]["name"] = GetStreetNameFromHashKey(Road)
		end

		SetCamCoord(Camera,Locate[1]["Coords"]["x"],Locate[1]["Coords"]["y"],Locate[1]["Coords"]["z"] + 1)
		SendNUIMessage({ Action = "Location", Table = Locate })
		LocalPlayer["state"]:set("Invisible",true,true)
		SetEntityVisible(PlayerPedId(),false,false)
		SetCamRot(Camera,0.0,0.0,0.0,2)
	else
		SetEntityVisible(PlayerPedId(),true,false)
		LocalPlayer["state"]:set("Invisible",false,true)
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("hud:active",true)
		SetNuiFocus(false,false)

		if DoesCamExist(Camera) then
			RenderScriptCams(false,false,0,false,false)
			SetCamActive(Camera,false)
			DestroyCam(Camera,false)
			Camera = nil
		end

		if Barbershop then
			TriggerServerEvent("vRP:BucketClient","Enter")
			TriggerEvent("barbershop:Open","open")
			TriggerEvent("initial:Open")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	SetEntityVisible(PlayerPedId(),true,false)
	LocalPlayer["state"]:set("Invisible",false,true)
	SendNUIMessage({ Action = "Close" })
	TriggerEvent("hud:active",true)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen",function(Data,Callback)
	local Ped = PlayerPedId()
	local Index = Data["index"]

	SetEntityCoords(Ped,Locate[Index]["Coords"]["x"],Locate[Index]["Coords"]["y"],Locate[Index]["Coords"]["z"] - 1)
	SetCamCoord(Camera,Locate[Index]["Coords"]["x"],Locate[Index]["Coords"]["y"],Locate[Index]["Coords"]["z"] + 1)
	SetCamRot(Camera,0.0,0.0,0.0,2)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Table,Check)
	if LoadModel(Table["Skin"]) then
		if Check then
			if GetEntityModel(PlayerPedId()) ~= GetHashKey(Table["Skin"]) then
				SetPlayerModel(PlayerId(),Table["Skin"])
				SetPedComponentVariation(PlayerPedId(),5,0,0,1)
			end
		else
			SetPlayerModel(PlayerId(),Table["Skin"])
			SetPedComponentVariation(PlayerPedId(),5,0,0,1)
		end

		local Ped = PlayerPedId()
		local Random = math.random(#Anims)
		if LoadAnim(Anims[Random]["Dict"]) then
			TaskPlayAnim(Ped,Anims[Random]["Dict"],Anims[Random]["Name"],8.0,8.0,-1,1,0,0,0,0)
		end
		TriggerEvent("barbershop:Apply",Table["Barber"])
		TriggerEvent("skinshop:Apply",Table["Clothes"])
		for Index,Overlay in pairs(Table["Tattoos"]) do
            AddPedDecorationFromHashes(Ped,Overlay,Index)
        end

		SetEntityVisible(Ped,true,false)
		LocalPlayer["state"]:set("Invisible",false,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:INCREMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Increment")
AddEventHandler("spawn:Increment",function(Tables)
	for _,v in pairs(Tables) do
		Locate[#Locate + 1] = { ["Coords"] = v["Coords"], ["name"] = "" }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATASET
-----------------------------------------------------------------------------------------------------------------------------------------
local Dataset = {
	["pants"] = { item = 0, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Clothes(Ped,Data)
	for Index,v in pairs(Dataset) do
		if not Data[Index] then
			Data[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped,4,Data["pants"]["item"],Data["pants"]["texture"],1)
	SetPedComponentVariation(Ped,3,Data["arms"]["item"],Data["arms"]["texture"],1)
	SetPedComponentVariation(Ped,5,Data["backpack"]["item"],Data["backpack"]["texture"],1)
	SetPedComponentVariation(Ped,8,Data["tshirt"]["item"],Data["tshirt"]["texture"],1)
	SetPedComponentVariation(Ped,9,Data["vest"]["item"],Data["vest"]["texture"],1)
	SetPedComponentVariation(Ped,11,Data["torso"]["item"],Data["torso"]["texture"],1)
	SetPedComponentVariation(Ped,6,Data["shoes"]["item"],Data["shoes"]["texture"],1)
	SetPedComponentVariation(Ped,1,Data["mask"]["item"],Data["mask"]["texture"],1)
	SetPedComponentVariation(Ped,10,Data["decals"]["item"],Data["decals"]["texture"],1)
	SetPedComponentVariation(Ped,7,Data["accessory"]["item"],Data["accessory"]["texture"],1)

	if Data["hat"]["item"] ~= -1 and Data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,Data["hat"]["item"],Data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if Data["glass"]["item"] ~= -1 and Data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,Data["glass"]["item"],Data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if Data["ear"]["item"] ~= -1 and Data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,Data["ear"]["item"],Data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if Data["watch"]["item"] ~= -1 and Data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,Data["watch"]["item"],Data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if Data["bracelet"]["item"] ~= -1 and Data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,Data["bracelet"]["item"],Data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
-- function Barber(Ped,Status)
-- 	local Clothes = {}
-- 	for Number = 1,41 do
-- 		Clothes[Number] = Status[Number] or 0
-- 	end

-- 	local Face = Clothes[2] / 100 + 0.0
-- 	local Skin = Clothes[4] / 100 + 0.0

-- 	SetPedHeadBlendData(Ped,Clothes[41],Clothes[1],0,Clothes[41],Clothes[1],0,Face,Skin,0.0,false)

-- 	SetPedEyeColor(Ped,Clothes[3])

-- 	if Clothes[5] == 0 then
-- 		SetPedHeadOverlay(Ped,0,Clothes[5],0.0)
-- 	else
-- 		SetPedHeadOverlay(Ped,0,Clothes[5],1.0)
-- 	end

-- 	SetPedHeadOverlay(Ped,6,Clothes[6],1.0)

-- 	if Clothes[7] == 0 then
-- 		SetPedHeadOverlay(Ped,9,Clothes[7],0.0)
-- 	else
-- 		SetPedHeadOverlay(Ped,9,Clothes[7],1.0)
-- 	end

-- 	SetPedHeadOverlay(Ped,3,Clothes[8],1.0)

-- 	SetPedComponentVariation(Ped,2,Clothes[9],0,1)
-- 	SetPedHairColor(Ped,Clothes[10],Clothes[11])

-- 	SetPedHeadOverlay(Ped,4,Clothes[12],Clothes[13] * 0.1)
-- 	SetPedHeadOverlayColor(Ped,4,1,Clothes[14],Clothes[14])

-- 	SetPedHeadOverlay(Ped,8,Clothes[15],Clothes[16] * 0.1)
-- 	SetPedHeadOverlayColor(Ped,8,1,Clothes[17],Clothes[17])

-- 	SetPedHeadOverlay(Ped,2,Clothes[18],Clothes[19] * 0.1)
-- 	SetPedHeadOverlayColor(Ped,2,1,Clothes[20],Clothes[20])

-- 	SetPedHeadOverlay(Ped,1,Clothes[21],Clothes[22] * 0.1)
-- 	SetPedHeadOverlayColor(Ped,1,1,Clothes[23],Clothes[23])

-- 	SetPedHeadOverlay(Ped,5,Clothes[24],Clothes[25] * 0.1)
-- 	SetPedHeadOverlayColor(Ped,5,1,Clothes[26],Clothes[26])

-- 	SetPedFaceFeature(Ped,0,Clothes[27] * 0.1)
-- 	SetPedFaceFeature(Ped,1,Clothes[28] * 0.1)
-- 	SetPedFaceFeature(Ped,4,Clothes[29] * 0.1)
-- 	SetPedFaceFeature(Ped,6,Clothes[30] * 0.1)
-- 	SetPedFaceFeature(Ped,8,Clothes[31] * 0.1)
-- 	SetPedFaceFeature(Ped,9,Clothes[32] * 0.1)
-- 	SetPedFaceFeature(Ped,10,Clothes[33] * 0.1)
-- 	SetPedFaceFeature(Ped,12,Clothes[34] * 0.1)
-- 	SetPedFaceFeature(Ped,13,Clothes[35] * 0.1)
-- 	SetPedFaceFeature(Ped,14,Clothes[36] * 0.1)
-- 	SetPedFaceFeature(Ped,15,Clothes[37] * 0.1)
-- 	SetPedFaceFeature(Ped,16,Clothes[38] * 0.1)
-- 	SetPedFaceFeature(Ped,17,Clothes[39] * 0.1)
-- 	SetPedFaceFeature(Ped,19,Clothes[40] * 0.1)
-- end