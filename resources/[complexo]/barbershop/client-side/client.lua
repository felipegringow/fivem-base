local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("barbershop", cRP)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local customization = {
    -- Blend
    fathers = 0,
    mothers = 45,
    skinMix = 0.5,
    skinColorParents = 0,
    skinColor = 0,
    skinColorMix = 0.5,

    -- Overlay
    blemishes = -1, -- 0
    beard = -1, -- 1
    beardIntensity = 1.0,
    beardColor = 0,
    eyebrow = 0, -- 2
    eyebrowIntensity = 1.0,
    eyebrowColor = 0,
    aging = -1, -- 3
    agingIntensity = 1.0,

    makeup = -1, -- 4
    makeupIntensity = 1.0,
    makeupColor = 0,
    blush = -1, -- 5
    blushIntensity = 1.0,
    blushColor = 0,
    complexion = -1, -- 6
    complexionIntensity = 1.0,
    sunDamage = -1, -- 7
    sunDamageIntensity = 1.0,
    lipstick = -1, -- 8
    lipstickIntensity = 1.0,
    lipstickColor = 0,
    freckles = -1, -- 9
    frecklesIntensity = 1.0,
    frecklesColor = 0,
    chestHair = -1, -- 10
    chestHairIntensity = 1.0,
    chestHairColor = 0,

    bodyBlemishes = -1, -- 11
    bodyBlemishesIntensity = 1.0,

    addBodyBlemishes = -1, -- 12
    addBodyBlemishesIntensity = 1.0,

    -- Face Feature
    noseWidth = 0.0,
    noseHeight = 0.0,
    noseLength = 0.0,
    noseProfile = 0.0,
    noseTip = 0.0,
    noseBroke = 0.0,

    browHeight = 0.0,
    browDepth = 0.0,
    cheekHeight = 0.0,
    cheekDepth = 0.0,

    cheekPuffed = 0.0,
    eyesSize = 0.0,
    lipsSize = 0.0,
    jawWidth = 0.0,
    jawRound = 0.0,
    chinHeight = 0.0,
    chinDepth = 0.0,
    chinPointed = 0.0,

    chinBum = 0.5,
    neckMale = 0.5,

    -- Extras
    eyeColor = 0,
    hair = 2,
    hairColor = 0,
    hairColor2 = 0,
    hairFade = -1,
}
local myCustomization = {}

local allowedAttributes = {
    ["beard"] = true,
    ["beardIntensity"] = true,
    ["beardColor"] = true,
    ["eyebrow"] = true,
    ["eyebrowIntensity"] = true,
    ["eyebrowColor"] = true,
    ["makeup"] = true,
    ["makeupIntensity"] = true,
    ["blush"] = true,
    ["blushIntensity"] = true,
    ["blushColor"] = true,
    ["chestHair"] = true,
    ["chestHairIntensity"] = true,
    ["chestHairColor"] = true,
    ["hair"] = true,
    ["hairColor"] = true,
    ["hairColor2"] = true,
    ["hairFade"] = true,
    ["lipstick"] = true,
    ["lipstickIntensity"] = true,
    ["lipstickColor"] = true,
}

local HairDecorations = {
	[1885233650]  = {
		[1]  = { collection = 2575696819, overlay = 2470940806 },
		[2]  = { collection = 598190139, overlay = 739308497 },
		[3]  = { collection = 598190139, overlay = 495343292 },
		[4]  = { collection = 598190139, overlay = 2608255643 },
		[5]  = { collection = 598190139, overlay = 1187457341 },
		[6]  = { collection = 598190139, overlay = 956403122 },
		[7]  = { collection = 598190139, overlay = 1647042566 },
		[8]  = { collection = 598190139, overlay = 3833488553 },
		[9]  = { collection = 598190139, overlay = 2411641643 },
		[10] = { collection = 598190139, overlay = 2180718500 },
		[11] = { collection = 598190139, overlay = 708472048 },
		[12] = { collection = 598190139, overlay = 495343292 },
		[13] = { collection = 598190139, overlay = 1503775674 },
		[14] = { collection = 598190139, overlay = 1862399610 },
		[15] = { collection = 598190139, overlay = 3087599751 },
		[16] = { collection = 598190139, overlay = 111650251 },
		[17] = { collection = 598190139, overlay = 4266025802 },
		[18] = { collection = 598190139, overlay = 2467794158 },
		[19] = { collection = 598190139, overlay = 3774285873 },
		[20] = { collection = 598190139, overlay = 4085624142 },
		[21] = { collection = 598190139, overlay = 4001387825 },
		[22] = { collection = 598190139, overlay = 20871853 },
		[23] = { collection = 598190139, overlay = 4205143952 },
		[24] = { collection = 62137527, overlay = 534771589 },
		[25] = { collection = 62137527, overlay = 2954827777 },
		[26] = { collection = 62137527, overlay = 3444986535 },
		[27] = { collection = 62137527, overlay = 3743413818 },
		[28] = { collection = 1529191571, overlay = 2863762782 },
		[29] = { collection = 1529191571, overlay = 3161632992 },
		[30] = { collection = 1529191571, overlay = 2485182525 },
		[31] = { collection = 4054732749, overlay = 1431846777 },
		[32] = { collection = 4054732749, overlay = 3834799180 },
		[33] = { collection = 4054732749, overlay = 3983721389 },
		[34] = { collection = 4054732749, overlay = 3352935961 },
		[35] = { collection = 4054732749, overlay = 3650464080 },
		[36] = { collection = 4054732749, overlay = 211198653 },
		[37] = { collection = 1616273011, overlay = 3175745814 },
		[38] = { collection = 1616273011, overlay = 2652767338 }
	},
	[-1667301416] = {
		[1]  = { collection = 2575696819, overlay = 2470940806 },
		[2]  = { collection = 598190139, overlay = 104062694 },
		[3]  = { collection = 598190139, overlay = 869579299 },
		[4]  = { collection = 598190139, overlay = 1201332655 },
		[5]  = { collection = 598190139, overlay = 1028967715 },
		[6]  = { collection = 598190139, overlay = 2643332496 },
		[7]  = { collection = 598190139, overlay = 3402688533 },
		[8]  = { collection = 598190139, overlay = 3262961517 },
		[9]  = { collection = 598190139, overlay = 4039291896 },
		[10] = { collection = 598190139, overlay = 1890137027 },
		[11] = { collection = 598190139, overlay = 3888161488 },
		[12] = { collection = 598190139, overlay = 3702426796 },
		[13] = { collection = 598190139, overlay = 205417419 },
		[14] = { collection = 598190139, overlay = 2167690677 },
		[15] = { collection = 598190139, overlay = 3087599751 },
		[16] = { collection = 598190139, overlay = 111650251 },
		[17] = { collection = 598190139, overlay = 3495990 },
		[18] = { collection = 598190139, overlay = 4009440706 },
		[19] = { collection = 598190139, overlay = 3262961517 },
		[20] = { collection = 598190139, overlay = 1907377338 },
		[21] = { collection = 598190139, overlay = 2136399879 },
		[22] = { collection = 598190139, overlay = 4009440706 },
		[23] = { collection = 598190139, overlay = 1568410532 },
		[24] = { collection = 598190139, overlay = 2702216367 },
		[25] = { collection = 62137527, overlay = 2969508819 },
		[26] = { collection = 62137527, overlay = 3728242245 },
		[27] = { collection = 62137527, overlay = 3507117033 },
		[28] = { collection = 1529191571, overlay = 2039295216 },
		[29] = { collection = 1529191571, overlay = 2039295216 },
		[30] = { collection = 1529191571, overlay = 1800147054 },
		[31] = { collection = 1529191571, overlay = 2275461399 },
		[32] = { collection = 4054732749, overlay = 3966627234 },
		[33] = { collection = 4054732749, overlay = 1657725123 },
		[34] = { collection = 4054732749, overlay = 2777002960 },
		[35] = { collection = 4054732749, overlay = 1677522529 },
		[36] = { collection = 598190139, overlay = 1201332655 },
		[37] = { collection = 4054732749, overlay = 1841934566 },
		[38] = { collection = 4054732749, overlay = 1521494915 },
		[39] = { collection = 1616273011, overlay = 687338866 },
		[40] = { collection = 1616273011, overlay = 1827923343 },
	}
};

RegisterNUICallback("updateBarbershopAttribute", function(data,cb)
    cb("ok")
    if not customization[data.key] then return end
    --if not allowedAttributes[data.key] then return end
    customization[data.key] = data.value
    exports['barbershop']:Update()
end)

RegisterNUICallback("getMaxDrawables", function (data, cb)
    UpdateDrawables()
    cb("ok")
end)
RegisterNUICallback("rotatePed", function(data,cb)
    local ply = PlayerPedId()
    cb("ok")
    --TaskTurnPedToFaceCoord(ply, GetOffsetFromEntityInWorldCoords(ply, (data == 65 and -0.01 or 0.01), 0.0, 0.0), -1)
    SetEntityHeading(ply, GetEntityHeading(ply) + (data == 65 and -10.0 or 10.0))
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeMenu", function(apply, cb)
    SetNuiFocus(false, false)
    if apply then
        vSERVER.Update(customization)
    else
        customization = table.shallow_copy(myCustomization)
    end
    exports['barbershop']:Update()
    DisplayBarbershop(false)
    cb('ok')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate", function(data, cb)
    local ply = PlayerPedId()
    local heading = GetEntityHeading(ply)
    if data == "left" then
        SetEntityHeading(ply, heading + 10)
    elseif data == "right" then
        SetEntityHeading(ply, heading - 10)
    end
    cb('ok')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply", function(customs)
    customization = customs
    exports['barbershop']:Update()
    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function DisplayBarbershop(enable)
    local ply = PlayerPedId()
    myCustomization = {}
    if enable then
        myCustomization = table.shallow_copy(customization)
        SetEntityHeading(ply, 332.21)
        SetFollowPedCamViewMode(0)
        SetNuiFocus(true, true)
        EmitNuiMessage("BARBERSHOP:CONFIG", { customization = customization })
        EmitNuiMessage("BARBERSHOP:SHOW", { show = true })
        UpdateDrawables()
        vRP.playAnim(false, { "mp_character_creation@customise@male_a", "drop_loop" }, true)
        SetPlayerInvincible(ply, true)
        if not DoesCamExist(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamCoord(cam, GetEntityCoords(ply))
            SetCamRot(cam, 0.0, 0.0, 0.0)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
            SetCamCoord(cam, GetEntityCoords(ply))
        end
        local x, y, z = table.unpack(GetEntityCoords(ply))
        SetCamCoord(cam, x + 0.3, y + 0.34, z + 0.8)
        SetCamRot(cam, -22.0, 0.0, 150.0)
        TriggerEvent('hud:Active',false)
    else
        TriggerEvent('hud:Active',true)
        vRP.stopAnim(false)
        EmitNuiMessage("BARBERSHOP:SHOW", { show = false })
        SetPlayerInvincible(ply, false)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    SetNuiFocus(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local locations = {
    { -813.37, -183.85, 37.57 },
    { 138.13, -1706.46, 29.3 },
    { -1280.92, -1117.07, 7.0 },
    { 1930.54, 3732.06, 32.85 },
    { 1214.2, -473.18, 66.21 },
    { -33.61, -154.52, 57.08 },
    { -276.65, 6226.76, 31.7 },
    { 1741.8, 427.61, 222.74 },
    { 1626.32, 438.33, 255.88 },
    { 1742.02, 427.81, 222.74 },
    { 2081.99, -103.14, 252.21 },
    { 2202.22, 17.12, 247.2 },
    { -54.32, 1269.21, 300.79 },
    { 1474.08, -2350.29, 74.31 },
    { 3070.55, 2965.73, 92.59 },
    { 1493.5, -179.43, 199.1 },
    { -305.92, -2679.26, -4.58 }, -- Calisto
    { 2232.08, 2090.89, 134.21 }, -- Milicia
    { 2379.16, 2295.67, 93.45 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local innerTable = {}
    for _, v in pairs(locations) do
        table.insert(innerTable, { v[1], v[2], v[3], 2.5, "E", "Barbearia", "Pressione para abrir" })
    end
    TriggerEvent("hoverfy:Insert", innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local ply = PlayerPedId()
    SetNuiFocus(false, false)
    while true do
        local timeDistance = 999
        if not IsPedInAnyVehicle(ply) then
            local coords = GetEntityCoords(ply)
            for _, v in pairs(locations) do
                local distance = #(coords - vector3(v[1], v[2], v[3]))
                if distance <= 2.5 then
                    timeDistance = 1
                    if IsControlJustPressed(1, 38) --[[ and vSERVER.CheckWanted()  ]]then
                        DisplayBarbershop(true)
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)

RegisterCommand('admbarbershop', function()
    DisplayBarbershop(true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea", function(x, y, z, distance)
    local objectsPool = GetGamePool("CObject")
    local pumpTable = {}
    for _, object in pairs(objectsPool) do
        local objectArchetype = GetEntityArchetypeName(object)
        if objectArchetype == 'prop_gas_pump_1a' then
            local coords = GetEntityCoords(object)
            local distanceObject = #(coords - vec3(x, y, z))
            if distanceObject <= distance then
                SetEntityCollision(object, false, false)
                table.insert(pumpTable, object)
            end
        end
    end
    ClearAreaOfVehicles(x, y, z, distance + 0.0, false, false, false, false, false)
    ClearAreaOfObjects(x, y, z, distance + 0.0, 1)
    Wait(1000)
    for _, object in pairs(pumpTable) do
        if DoesEntityExist(object) then SetEntityCollision(object, true, true) end
    end
end)


function UpdateDrawables()
    
    local ply = PlayerPedId()
    local plyModel = GetEntityModel(ply)
	local valuesMax = {
		blemishes = GetPedHeadOverlayNum(0)-1,
		beard = GetPedHeadOverlayNum(1)-1,
		eyebrow = GetPedHeadOverlayNum(2)-1,
		aging = GetPedHeadOverlayNum(3)-1,
		makeup = GetPedHeadOverlayNum(4)-1,
		blush = GetPedHeadOverlayNum(5)-1,
		complexion = GetPedHeadOverlayNum(6)-1,
		sunDamage = GetPedHeadOverlayNum(7)-1,
		lipstick = GetPedHeadOverlayNum(8)-1,
		freckles = GetPedHeadOverlayNum(9)-1,
		chestHair = GetPedHeadOverlayNum(10)-1,
		bodyBlemishes = GetPedHeadOverlayNum(11)-1,
        addBodyBlemishes = GetPedHeadOverlayNum(12)-1,
		hair = GetNumberOfPedDrawableVariations(ply, 2)-1,
        makeupColor = GetNumMakeupColors()-1,
        hairFade = #HairDecorations[plyModel],
	}

	EmitNuiMessage("BARBERSHOP:MAXDRAWABLES", { maxDrawables = valuesMax })
end

exports("Update",function()
    local ply = PlayerPedId()
    exports['barbershop']:UpdateSkin()
    exports['barbershop']:UpdateFace()
    exports['barbershop']:UpdateHead()
    if not IsEntityPlayingAnim(ply, "mp_character_creation@customise@male_a", "drop_loop", 3) then
        vRP.playAnim(false, { "mp_character_creation@customise@male_a", "drop_loop" }, true)
    end
end)

exports("UpdateSkin",function()
    local ply = PlayerPedId()
    SetPedHeadBlendData(ply, customization.fathers, customization.mothers, 0, customization.skinColor, customization.skinColorParents, 0,  0.0, true)
end)

exports("UpdateFace",function()
    local ply = PlayerPedId()
    SetPedEyeColor(ply, customization.eyeColor)
	SetPedFaceFeature(ply, 0, customization.noseWidth + 0.0)
	SetPedFaceFeature(ply, 1, customization.noseHeight + 0.0)
	SetPedFaceFeature(ply, 2, customization.noseLength + 0.0)
	SetPedFaceFeature(ply, 3, customization.noseProfile + 0.0)
	SetPedFaceFeature(ply, 4, customization.noseTip + 0.0)
	SetPedFaceFeature(ply, 5, customization.noseBroke + 0.0)

	SetPedFaceFeature(ply, 6, customization.browHeight + 0.0)
	SetPedFaceFeature(ply, 7, customization.browDepth + 0.0)
	SetPedFaceFeature(ply, 8, customization.cheekHeight + 0.0)
	SetPedFaceFeature(ply, 9, customization.cheekDepth + 0.0)
	SetPedFaceFeature(ply, 10, customization.cheekPuffed + 0.0)
	SetPedFaceFeature(ply, 11, customization.eyesSize + 0.0)
	SetPedFaceFeature(ply, 12, customization.lipsSize + 0.0)
	SetPedFaceFeature(ply, 13, customization.jawWidth + 0.0)
	SetPedFaceFeature(ply, 14, customization.jawRound + 0.0)
	SetPedFaceFeature(ply, 15, customization.chinHeight + 0.0)
	SetPedFaceFeature(ply, 16, customization.chinDepth + 0.0)
	SetPedFaceFeature(ply, 17, customization.chinPointed + 0.0)
	SetPedFaceFeature(ply, 18, customization.chinBum + 0.0)
	SetPedFaceFeature(ply, 19, customization.neckMale + 0.0)
end)

exports("UpdateHead",function()
    local ply = PlayerPedId()
    local plyModel = GetEntityModel(ply)
	SetPedHeadOverlay(ply, 0, customization.blemishes, 1.0)
	SetPedHeadOverlayColor(ply, 0, 0, 0, 0)
	SetPedHeadOverlay(ply, 1, customization.beard, customization.beardIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 1, 1, customization.beardColor, customization.beardColor)
    SetPedHeadOverlay(ply, 2, customization.eyebrow, customization.eyebrowIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 2, 1, customization.eyebrowColor, customization.eyebrowColor)
	SetPedHeadOverlay(ply, 3, customization.aging, customization.agingIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 3, 0, 0, 0)
	SetPedHeadOverlay(ply, 4, customization.makeup, customization.makeupIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 4, 1, customization.makeupColor, customization.makeupColor)
	SetPedHeadOverlay(ply, 5, customization.blush, customization.blushIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 5, 2, customization.blushColor, customization.blushColor)
	SetPedHeadOverlay(ply, 6, customization.complexion, customization.complexionIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 6, 0, 0, 0)
	SetPedHeadOverlay(ply, 7, customization.sunDamage, customization.sunDamageIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 7, 0, 0, 0)
	SetPedHeadOverlay(ply, 8, customization.lipstick, customization.lipstickIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 8, 2, customization.lipstickColor, customization.lipstickColor)
	SetPedHeadOverlay(ply, 9, customization.freckles, customization.frecklesIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 9, 0, 0, 0)
	SetPedHeadOverlay(ply, 10, customization.chestHair, customization.chestHairIntensity + 0.0)
	SetPedHeadOverlayColor(ply, 10, 1, customization.chestHairColor, customization.chestHairColor)
    SetPedHeadOverlay(ply, 11, customization.bodyBlemishes, customization.bodyBlemishesIntensity + 0.0)
    SetPedHeadOverlayColor(ply, 11, 0, 0, 0)
    SetPedHeadOverlay(ply, 12, customization.addBodyBlemishes, customization.addBodyBlemishesIntensity + 0.0)
    SetPedHeadOverlayColor(ply, 12, 0, 0, 0)
	SetPedComponentVariation(ply, 2, customization.hair, 0, 0)
	SetPedHairColor(ply, customization.hairColor, customization.hairColor2)
    
    if customization.hairFade ~= 0 then
		if HairDecorations[plyModel] and HairDecorations[plyModel][customization.hairFade] then
			local collection = HairDecorations[plyModel][customization.hairFade].collection
			local overlay = HairDecorations[plyModel][customization.hairFade].overlay
			ClearPedDecorationsLeaveScars(ply)
			AddPedDecorationFromHashes(ply, collection, overlay)
            
		end
	else ClearPedDecorationsLeaveScars(ply) end
end)


function EmitNuiMessage(type, payload)
	SendNUIMessage({
		type = type,
		payload = { payload } or {}
	})
end

function table.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end