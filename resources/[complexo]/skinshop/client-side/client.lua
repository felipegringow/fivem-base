-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("skinshop",cRP)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cam = -1
local InShop = false
local ChangeData = true
local CameraFinalSettings = {}
local TryBuyDelay = 0

LocalPlayer.state.GasMask = false

local CAMERA_OFFSET_SETTINGS = {
	[1] = { offset = vec3(0.25, 2.0, 0.0), fov = 70.0 },
	[2] = { offset = vec3(0.05, 0.5, 0.6), fov = 60.0 },
	[3] = { offset = vec3(0.07, 0.7, 0.1), fov = 80.0 },
	[4] = { offset = vec3(0.07, 0.7, -0.4), fov = 80.0 },
	[5] = { offset = vec3(0.07, 0.7, -0.9), fov = 60.0 },
	[6] = { offset = vec3(0.07, 1.6, 0.0), fov = 65.0 },
}

local PED_COMPONENT_ENUM = {
	mask = 1,
	hair = 2,
	arms = 3,
	pants = 4,
	parachute = 5,
	shoes = 6,
	accessory = 7,
	tshirt = 8,
	vest = 9,
	decals = 10,
	torso = 11
}

local PED_PROP_ENUM = {
	hat = 0,
	glass = 1,
	ear = 2,
	mouth = 3,
	leftHand = 4,
	rightHand = 5,
	watch = 6,
	bracelet = 7
}

local CLOTH_CATEGORY_MAP = {
	mask = { type = "Clothes", id = 1 },
	arms = { type = "Clothes", id = 3 },
	pants = { type = "Clothes", id = 4 },
	-- parachute = { type = "Clothes", id = 5 },
	shoes = { type = "Clothes", id = 6 },
	accessory = { type = "Clothes", id = 7 },
	tshirt = { type = "Clothes", id = 8 },
	vest = { type = "Clothes", id = 9 },
	decals = { type = "Clothes", id = 10 },
	torso = { type = "Clothes", id = 11 },
	hat = { type = "Props", id = 0 },
	glass = { type = "Props", id = 1 },
	ear = { type = "Props", id = 2 },
	watch = { type = "Props", id = 6 },
	bracelet = { type = "Props", id = 7 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local SkinData = {
	Clothes = {
		[PED_COMPONENT_ENUM.mask] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.arms] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.pants] = { item = 0, texture = 0 },
		-- [PED_COMPONENT_ENUM.parachute"] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.shoes] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.accessory] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.tshirt] = { item = 15, texture = 0 },
		[PED_COMPONENT_ENUM.vest] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.decals] = { item = 0, texture = 0 },
		[PED_COMPONENT_ENUM.torso] = { item = 0, texture = 0 },
	},
	Props = {
		[PED_PROP_ENUM.hat] = { item = -1, texture = 0 },
		[PED_PROP_ENUM.glass] = { item = 0, texture = 0 },
		[PED_PROP_ENUM.ear] = { item = -1, texture = 0 },
		[PED_PROP_ENUM.watch] = { item = -1, texture = 0 },
		[PED_PROP_ENUM.bracelet] = { item = -1, texture = 0 },
	}
}

local DEFAULT_SKIN_DATA = {
	[`mp_m_freemode_01`] = {
		Clothes = {
			[PED_COMPONENT_ENUM.pants] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.arms] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.tshirt] = { item = 1, texture = 0 },
			[PED_COMPONENT_ENUM.torso] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.vest] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.shoes] = { item = 34, texture = 0 },
			-- [PED_COMPONENT_ENUM.parachute"] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.mask] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.accessory] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.decals] = { item = 0, texture = 0 },
		},
		Props = {
			[PED_PROP_ENUM.hat] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.glass] = { item = 0, texture = 0 },
			[PED_PROP_ENUM.ear] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.watch] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.bracelet] = { item = -1, texture = 0 },
		}
	},
	[`mp_f_freemode_01`] = {
		Clothes = {
			[PED_COMPONENT_ENUM.pants] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.arms] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.tshirt] = { item = 1, texture = 0 },
			[PED_COMPONENT_ENUM.torso] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.vest] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.shoes] = { item = 35, texture = 0 },
			-- [PED_COMPONENT_ENUM.parachute"] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.mask] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.accessory] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.decals] = { item = 0, texture = 0 },
		},
		Props = {
			[PED_PROP_ENUM.hat] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.glass] = { item = 0, texture = 0 },
			[PED_PROP_ENUM.ear] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.watch] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.bracelet] = { item = -1, texture = 0 },
		}
	},
	Default = {
		Clothes = {
			[PED_COMPONENT_ENUM.pants] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.arms] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.tshirt] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.torso] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.vest] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.shoes] = { item = 0, texture = 0 },
			-- [PED_COMPONENT_ENUM.parachute"] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.mask] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.accessory] = { item = 0, texture = 0 },
			[PED_COMPONENT_ENUM.decals] = { item = 0, texture = 0 },
		},
		Props = {
			[PED_PROP_ENUM.hat] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.glass] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.ear] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.watch] = { item = -1, texture = 0 },
			[PED_PROP_ENUM.bracelet] = { item = -1, texture = 0 },
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKED CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
local BlockedClothes = {
	-- 	[`mp_m_freemode_01`] = {
	-- 		Clothes = {
	-- 			-- [PED_COMPONENT_ENUM.torso] = {
	-- 			-- 	[3] = true,
	-- 			-- 	[4] = true
	-- 			-- }
	-- 		},
	-- 		Props = {
	-- 			[PED_PROP_ENUM.hat] = {
	-- 				[10] = true
	-- 			}
	-- 		}
	-- 	},
	-- 	[`mp_f_freemode_01`] = {
	-- 		Clothes = {
	-- 			-- [PED_COMPONENT_ENUM.torso] = {
	-- 			-- 	[3] = true,
	-- 			-- 	[4] = true
	-- 			-- }
	-- 		},
	-- 		Props = {
	-- 			[PED_PROP_ENUM.hat] = {
	-- 				[10] = true
	-- 			}
	-- 		}
	-- 	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:Apply")
AddEventHandler("skinshop:Apply",function(status)
	if status then
		if not status.Clothes or not status.Props then
			local data = status
			status = {
				Clothes = {},
				Props = {}
			}
			for category, value in pairs(data) do
				if PED_COMPONENT_ENUM[category] then
					status.Clothes[PED_COMPONENT_ENUM[category]] = value
				elseif PED_PROP_ENUM[category] then
					status.Props[PED_PROP_ENUM[category]] = value
				end
			end
		end
		
		for category, value in pairs(status.Clothes) do
			if type(category) == "string" then
				category = tonumber(category)
			end
			
			SkinData.Clothes[category] = value
		end
		
		for category, value in pairs(status.Props) do
			if type(category) == "string" then
				category = tonumber(category)
			end
			
			SkinData.Props[category] = value
		end

	end

	vSERVER.Update(SkinData)
	exports["skinshop"]:Apply(SkinData)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	SkinData = custom
	exports["skinshop"]:Apply(custom)
	vSERVER.Update(custom)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:updateTattoo")
AddEventHandler("skinshop:updateTattoo",function()
	resetClothing(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart", function(rsc)
	local ply = PlayerPedId()

	if GetCurrentResourceName() ~= rsc then return end
	
	for index, data in pairs(SkinData.Clothes) do
		data.item = GetPedDrawableVariation(ply, index)
		data.texture = GetPedTextureVariation(ply, index)
	end
	
	for index, data in pairs(SkinData.Props) do
		data.item = GetPedPropIndex(ply, index)
		data.texture = GetPedPropTextureIndex(ply, index)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOP LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local SHOP_LOCATIONS = {
	{ coords = vec3(77.71, -1395.05, 29.37), shop = "Default" },
	{ coords = vec3(74.88,-1400.08,29.37), shop = "Default" },
	{ coords = vec3(80.42,-1400.13,29.37), shop = "Default" },
	{ coords = vec3(-709.09,-143.23,37.41), shop = "Default" },
	{ coords = vec3(-701.47,-156.89,37.41), shop = "Default" },
	{ coords = vec3(-166.04,-294.02,39.73), shop = "Default" },
	{ coords = vec3(-171.45,-308.83,39.73), shop = "Default" },
	{ coords = vec3(-828.87,-1076.69,11.32), shop = "Default" },
	{ coords = vec3(-826.14,-1081.52,11.32), shop = "Default" },
	{ coords = vec3(-1198.62,-770.67,17.3), shop = "Default" },
	{ coords = vec3(-1451.4,-247.0,49.82), shop = "Default" },
	{ coords = vec3(-1440.71,-235.17,49.82), shop = "Default" },
	{ coords = vec3(10.38,6516.93,31.88), shop = "Default" },
	{ coords = vec3(6.66,6521.02,31.88), shop = "Default" },
	{ coords = vec3(1693.48,4829.94,42.06), shop = "Default" },
	{ coords = vec3(1688.02,4829.23,42.06), shop = "Default" },
	{ coords = vec3(129.04,-218.61,54.56), shop = "Default" },
	{ coords = vec3(613.28,2756.72,42.09), shop = "Default" },
	{ coords = vec3(1189.51,2710.73,38.22), shop = "Default" },
	{ coords = vec3(1189.46,2705.23,38.22), shop = "Default" },
	{ coords = vec3(-3167.03,1048.69,20.86), shop = "Default" },
	{ coords = vec3(-1107.17,2706.14,19.11), shop = "Default" },
	{ coords = vec3(-1103.47,2702.0,19.11), shop = "Default" },
	{ coords = vec3(426.08,-799.02,29.49), shop = "Default" },
	{ coords = vec3(420.55,-799.1,29.49), shop = "Default" },
	{ coords = vec3(1835.98,2573.06,46.02), shop = "Default" }, -- Presidio
	{ coords = vec3(1452.57, -2016.63, 72.12), shop = "Default" },
	{ coords = vec3(1319.02, -163.33, 111.23), shop = "Default" },
	{ coords = vec3(-1523.38, 133.56, 60.44), shop = "Default" },
	{ coords = vec3(1526.88, -1845.79, 85.89), shop = "Default" },
	{ coords = vec3(1592.64, -1532.67, 95.24), shop = "Default" },
	{ coords = vec3(-1654.24, 506.88, 130.94), shop = "Default" },
	{ coords = vec3(1841.99, 469.22, 172.58), shop = "Default" },
	{ coords = vec3(1761.02, 3323.73, 41.37), shop = "Default" },
	{ coords = vec3(-919.25, -2040.85, 9.32), shop = "Default" }, -- BCRF BPM
	{ coords = vec3(363.87, -1587.81, 29.28), shop = "Default" }, -- BCE BPM
	{ coords = vec3(828.66, -1293.75, 19.85), shop = "Default" }, -- PC
	{ coords = vec3(1836.02, 2573.85, 46.02), shop = "Default" }, -- PENAL
	{ coords = vec3(-1681.97, -780.19, 17.62), shop = "Default" }, -- MechanicSul
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY SET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local data = {}
	for i = 1, #SHOP_LOCATIONS do
		data[#data+1] = { SHOP_LOCATIONS[i].coords.x, SHOP_LOCATIONS[i].coords.y, SHOP_LOCATIONS[i].coords.z, 5, "E", "Loja de Roupas", "Pressione para abrir" }
	end
	TriggerEvent("hoverfy:Insert",data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local delay = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local coords = GetEntityCoords(Ped)

				for _, shopData in ipairs(SHOP_LOCATIONS) do
					if #(coords - shopData.coords) <= 5 then
						delay = 1
						
						if IsControlJustPressed(0, 38) then
							openShop(shopData.shop)
						end
					end
				end
			end
		end
		Wait(delay)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFACE METHODS
-----------------------------------------------------------------------------------------------------------------------------------------
function openShop(shopType)
	local ply = PlayerPedId()
	
	if InShop then return end
	TriggerEvent("hud:active", false)
	InShop = true
	setupCamera()
	EmitNuiMessage("SKINSHOP:SET_VISIBLE", { toggle = true, fileName = GetEntityArchetypeName(ply).."-"..shopType })
	SetCursorLocation(0.1,0.1)
	SetNuiFocus(true, true)
end

function closeShop()
	if not InShop then return end
	TriggerEvent("hud:active", true)
	if ChangeData then
		ChangeData = false
		exports["skinshop"]:Apply(SkinData)
		vSERVER.Update(SkinData)
	end
	RenderScriptCams(false, true, 1000, true, true)
	DestroyCam(Cam)
	Cam = nil
	EmitNuiMessage("SKINSHOP:SET_VISIBLE", { toggle = false })
	InShop = false
	SetNuiFocus(false, false)
	vRP.stopAnim()
	EmitNuiMessage("SKINSHOP:RESET_CART")
end

function setupCamera()
	local ply = PlayerPedId()
	
	FreezeEntityPosition(ply, true)
	vRP.playAnim(false, {"move_f@multiplayer", "idle"}, true)
	local coords = GetOffsetFromEntityInWorldCoords(ply, 0.25, 2.0, 0.0)
	RenderScriptCams(false, false)
	DestroyCam(Cam, false)
	repeat
		Wait(10)
	until not DoesCamExist(Cam)
	Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamActive(Cam, true)
	RenderScriptCams(true, true, 1000, true, true)
	SetCamCoord(Cam, coords)
	SetCamRot(Cam, 0.0, 0.0, GetEntityHeading(ply) + 180)
	for i = 1, 6 do
		CameraFinalSettings[i] = { coords = GetOffsetFromEntityInWorldCoords(ply, CAMERA_OFFSET_SETTINGS[i].offset), fov = CAMERA_OFFSET_SETTINGS[i].fov }
	end
	FreezeEntityPosition(ply, false)
end

function updateCloth(data)
	
	local ply = PlayerPedId()
	
	if not data.index or not data.category or not data.type or not data.texture then return end
	
	local pedModel = GetEntityModel(ply)
	
	if BlockedClothes[pedModel] and BlockedClothes[pedModel][data.type] and BlockedClothes[pedModel][data.type][data.category] and BlockedClothes[pedModel][data.type][data.category][data.index] then return end
	
	if not ChangeData then ChangeData = true end
	
	if data.type == "Clothes" then
		SetPedComponentVariation(ply, data.category, data.index, data.texture, 1)
	elseif data.index >= 0 then
		SetPedPropIndex(ply, data.category, data.index, data.texture, 1)
	else
		ClearPedProp(ply, data.category)
	end
	
end

exports("Apply",function(data)
	local ply = PlayerPedId()
	
	local pedModel = GetEntityModel(ply)
	
	if not data then data = SkinData elseif data == "default" then data = DEFAULT_SKIN_DATA[pedModel] or DEFAULT_SKIN_DATA.Default end
	
	if not data.Clothes or not data.Props then return end
	
	local checkBlockedClothes = BlockedClothes[pedModel]
	
	for category, value in pairs(data.Clothes) do
		if not checkBlockedClothes or not checkBlockedClothes.Clothes[category] or not checkBlockedClothes.Clothes[category][value.item] then
			SetPedComponentVariation(ply, category, value.item, value.texture, 1)
		end
	end
	
	for category, value in pairs(data.Props) do
		category = tonumber(category)
		
		if value.item >= 0 then
			if not checkBlockedClothes or not checkBlockedClothes.Props[category] or not checkBlockedClothes.Props[category][value.item] then
				SetPedPropIndex(ply, category, value.item, value.texture, 1)
			end
		else
			ClearPedProp(ply, category)
		end
	end

end)

function EmitNuiMessage(type, payload)
	SendNUIMessage({
		type = type,
		payload = payload and { payload } or {}
	})
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFACE INTERACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CLOSE_INTERFACE",function(_, cb)
	closeShop()
	cb("Ok")
end)

RegisterNUICallback("ROTATE_PED",function(amount, cb)
	local ply = PlayerPedId()
	
	if not InShop then cb("Ok") return end
	SetEntityHeading(ply, GetEntityHeading(ply) + amount)
	cb("Ok")
end)

RegisterNUICallback("SET_CAMERA",function(cameraIndex, cb)
	if not InShop then cb("Ok") return end
	if not Cam or not DoesCamExist(Cam) then cb("Ok") return end
	if CameraFinalSettings[cameraIndex] then
		SetCamCoord(Cam, CameraFinalSettings[cameraIndex].coords)
		SetCamFov(Cam, CameraFinalSettings[cameraIndex].fov)
	end
	cb("Ok")
end)

RegisterNUICallback("UPDATE_CLOTH",function(data, cb)
	updateCloth(data)
	cb("Ok")
end)

RegisterNUICallback("TRY_BUY_CLOTHES",function(data, cb)
	if not InShop then cb("Ok") return end
	if GetGameTimer() <= TryBuyDelay then cb("Ok") return end
	TryBuyDelay = GetGameTimer() + 2000
	if not data[1] then cb("Ok") return end
	RenderScriptCams(false, true, 1000, true, true)
	DestroyCam(Cam)
	Cam = nil
	EmitNuiMessage("SKINSHOP:SET_VISIBLE", { toggle = false })
	TriggerEvent("hud:active", true)
	InShop = false
	SetNuiFocus(false, false)
	vRP.stopAnim()
	EmitNuiMessage("SKINSHOP:RESET_CART")
	for _, cloth in ipairs(data) do
		SkinData[cloth.type][cloth.category] = { item = cloth.index, texture = cloth.texture }
	end
	if vSERVER.tryBuyClothes(data) then
		for _, cloth in ipairs(data) do
			SkinData[cloth.type][cloth.category] = { item = cloth.index, texture = cloth.texture }
		end
		cb(true)
	else
		cb(false)
	end
	vSERVER.Update(SkinData)
	exports["skinshop"]:Apply(SkinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function(shopType)
	if vSERVER.checkShares() then
		openShop(shopType or "Default")
	end
end)

RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	local ply = PlayerPedId()

	if not LocalPlayer.state.GasMask then
		if GetPedDrawableVariation(ply,PED_COMPONENT_ENUM.mask) == SkinData.Clothes[PED_COMPONENT_ENUM.mask].item then
			vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)
			Wait(900)
			SetPedComponentVariation(ply, PED_COMPONENT_ENUM.mask, 0, 0, 1)
		else
			vRP.playAnim(true, {"mp_masks@on_foot", "put_on_mask"}, true)
			Wait(700)
			SetPedComponentVariation(ply, PED_COMPONENT_ENUM.mask, SkinData.Clothes[PED_COMPONENT_ENUM.mask].item, SkinData.Clothes[PED_COMPONENT_ENUM.mask].texture, 1)
		end
		vRP.removeObjects("one")
	end
end)

RegisterNetEvent("skinshop:setGasMask")
AddEventHandler("skinshop:setGasMask",function()
	local ply = PlayerPedId()

	if LocalPlayer.state.GasMask then
		vRP.playAnim(true, {"missfbi4", "takeoff_mask"}, true)
		Wait(900)
		LocalPlayer.state.GasMask = false
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.mask, 0, 0, 1)
	else
		vRP.playAnim(true, {"mp_masks@on_foot", "put_on_mask"}, true)
		Wait(700)
		LocalPlayer.state.GasMask = true
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.mask, 38, 0, 1)
	end
	vRP.removeObjects("one")
end)

RegisterNetEvent("skinshop:removeGasMask")
AddEventHandler("skinshop:removeGasMask",function()
	local ply = PlayerPedId()

	if LocalPlayer.state.GasMask then
		vRP.playAnim(true, {"missfbi4", "takeoff_mask"}, true)
		Wait(900)
		LocalPlayer.state.GasMask = false
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.mask, 0, 0, 1)
	end
end)

RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	local ply = PlayerPedId()

	vRP.playAnim(true, {"mp_masks@standard_car@ds@", "put_on_mask"}, true)
	Wait(900)
	if GetPedPropIndex(ply, PED_PROP_ENUM.hat) == SkinData.Props[PED_PROP_ENUM.hat].item then
		ClearPedProp(ply, PED_PROP_ENUM.hat)
	else
		SetPedPropIndex(ply, PED_PROP_ENUM.hat, SkinData.Props[PED_PROP_ENUM.hat].item, SkinData.Props[PED_PROP_ENUM.hat].texture, 1)
	end
	vRP.removeObjects("one")
end)

RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	local ply = PlayerPedId()

	vRP.playAnim(true, {"clothingspecs", "take_off"}, true)
	Wait(1000)
	if GetPedPropIndex(ply, PED_PROP_ENUM.glass) == SkinData.Props[PED_PROP_ENUM.glass].item then
		ClearPedProp(ply, PED_PROP_ENUM.glass)
	else
		SetPedPropIndex(ply, PED_PROP_ENUM.glass, SkinData.Props[PED_PROP_ENUM.glass].item, SkinData.Props[PED_PROP_ENUM.glass].texture, 2)
	end
	vRP.removeObjects("one")
end)
---------

RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms",function()
	local ply = PlayerPedId()

	if GetPedDrawableVariation(ply, PED_COMPONENT_ENUM.arms) == SkinData.Clothes[PED_COMPONENT_ENUM.arms].item then
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.arms, 15, 0, 1)
	else
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.arms, SkinData.Clothes[PED_COMPONENT_ENUM.arms].item, SkinData.Clothes[PED_COMPONENT_ENUM.arms].texture, 1)
	end
end)

RegisterNetEvent("skinshop:setShoes")
AddEventHandler("skinshop:setShoes",function()
	local ply = PlayerPedId()

	if GetPedDrawableVariation(ply, PED_COMPONENT_ENUM.shoes) == SkinData.Clothes[PED_COMPONENT_ENUM.shoes].item then
		local defaultSkinData = DEFAULT_SKIN_DATA[GetEntityModel(ply)] or DEFAULT_SKIN_DATA.Default
		vRP.playAnim(false, {"random@domestic", "pickup_low"}, false)
		Wait(1200)
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.shoes, defaultSkinData.Clothes[PED_COMPONENT_ENUM.shoes].item, 0, 1)
	else
		vRP.playAnim(false, {"random@domestic", "pickup_low"}, false)
		Wait(1200)
		SetPedComponentVariation(ply, PED_COMPONENT_ENUM.shoes, SkinData.Clothes[PED_COMPONENT_ENUM.shoes].item, SkinData.Clothes[PED_COMPONENT_ENUM.shoes].texture, 1)
	end
end)

RegisterNetEvent("skinshop:setBackpack")
AddEventHandler("skinshop:setBackpack",function()
	local ply = PlayerPedId()

	local pedModel = GetEntityModel(ply)
	if pedModel == `mp_m_freemode_01` then
		SkinData.Clothes[PED_COMPONENT_ENUM.decals].item = 154
	elseif pedModel == `mp_f_freemode_01` then
		SkinData.Clothes[PED_COMPONENT_ENUM.decals].item = 191
	end
	SkinData.Clothes[PED_COMPONENT_ENUM.decals].texture = 0
	SetPedComponentVariation(ply, PED_COMPONENT_ENUM.decals, SkinData.Clothes[PED_COMPONENT_ENUM.decals].item, SkinData.Clothes[PED_COMPONENT_ENUM.decals].texture, 1)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FORCECLOTH
-----------------------------------------------------------------------------------------------------------------------------------------
local forceClothConfig = {
	["stakejacket"] = {
		[`mp_m_freemode_01`] = { anim = {"missfbi3_camcrew","final_loop_guy"}, animDelay = 2500, clothType = "torso", clothIndex = 4, clothTexture = 0},
		[`mp_f_freemode_01`] = { anim = {"missfbi3_camcrew","final_loop_guy"}, animDelay = 2500, clothType = "torso", clothIndex = 3, clothTexture = 0},
	},
	["stakeshirt"] = {
		[`mp_m_freemode_01`] = { anim = {"missfbi3_camcrew","final_loop_guy"}, animDelay = 2500, clothType = "torso", clothIndex = 3, clothTexture = 0},
		[`mp_f_freemode_01`] = { anim = {"missfbi3_camcrew","final_loop_guy"}, animDelay = 2500, clothType = "torso", clothIndex = 4, clothTexture = 0},
	},
	["stakecap"] = {
		[`mp_m_freemode_01`] = { anim = {"mp_masks@standard_car@ds@","put_on_mask"}, animDelay = 900, clothType = "hat", clothIndex = 10, clothTexture = 0},
		[`mp_f_freemode_01`] = { anim = {"mp_masks@standard_car@ds@","put_on_mask"}, animDelay = 900, clothType = "hat", clothIndex = 10, clothTexture = 0},
	},
}

RegisterNetEvent("skinshop:forceCloth")
AddEventHandler("skinshop:forceCloth",function(clothName)
	local ply = PlayerPedId()
	local pedModel = GetEntityModel(ply)
	local clothConfig = forceClothConfig[clothName]
	if clothConfig then
		local clothData = clothConfig[pedModel]
		if clothData and CLOTH_CATEGORY_MAP[clothData.clothType] then
			vRP.playAnim(true, clothData.anim, false)
			Wait(clothData.animDelay)
			
			local func = CLOTH_CATEGORY_MAP[clothData.clothType].type == "variation" and SetPedComponentVariation or SetPedPropIndex
			func(ply, CLOTH_CATEGORY_MAP[clothData.clothType].id, clothData.clothIndex, clothData.clothTexture, 1)
			vRP.stopAnim(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getCustomization()
	return SkinData
end