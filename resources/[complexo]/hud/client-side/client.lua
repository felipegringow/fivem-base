local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("hud", Creative)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showHud = false
local clientStress = 0
local showMovie = false
local radioDisplay = ""
local pauseBreak = false
local homeInterior = false
local flexDirection = "Norte"
local showHood = false
local showBlips = {}
local timeBlips = {}
local numberBlips = 0

local clientHunger = 100
local clientThirst = 100
local updateFoods = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local beltLock = true
local beltVelocity = vector3(0, 0, 0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local SeatbeltSpeed = 0
local SeatbeltLock = false
local SeatbeltVelocity = vec3(0, 0, 0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask
local divingTank
local clientOxigen = 100
local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local clockHours = 18
local clockMinutes = 0
local weatherSync = "CLEAR"
local timeDate = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local policeRadar = false
local policeFreeze = false
local policeService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mumble = false
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- MUMBLECONNECTED
-- -----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected", function()
    if not Mumble then
        SendNUIMessage({ mumble = false })
        Mumble = true
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- MUMBLEDISCONNECTED
-- -----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected", function()
    if Mumble then
        SendNUIMessage({ mumble = true })
        Mumble = false
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD:VOIP
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip", function(number)
    local Number = tonumber(number)
    local voiceTarget = { "Baixo", "Médio", "Alto", "Muito Alto" }
    EmitNuiMessage("HUD:VOICE", { voice = voiceTarget[Number] })
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADGLOBAL
-- -----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if LocalPlayer["state"]["Active"] and not LocalPlayer.state.Farming then
            if divingMask ~= nil then
                if GetGameTimer() >= divingTimers then
                    divingTimers = GetGameTimer() + 35000
                    clientOxigen = clientOxigen - 1
                    -- vRPS.clientOxigen()
                    if clientOxigen <= 0 then
                        ApplyDamageToPed(ply, 50, false)
                    end
                end
            end
        end
        Wait(5000)
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADGLOBAL
-- -----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if GetGameTimer() >= timeDate then
            timeDate = GetGameTimer() + 10000
            clockMinutes = clockMinutes + 1
            if clockMinutes >= 60 then
                clockHours = clockHours + 1
                clockMinutes = 0
                if clockHours >= 24 then
                    clockHours = 0
                end
            end
        end
        Wait(5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress", function(progressTimer, Timer)
    EmitNuiMessage("HUD:PROGRESS", { timer = Timer / 1000 })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local shouldSync = true
CreateThread(function()
    local timeWait = 500
    while true do
        if homeInterior then
            SetWeatherTypeNow("CLEAR")
            SetWeatherTypePersist("CLEAR")
            SetWeatherTypeNowPersist("CLEAR")
            NetworkOverrideClockTime(00, 00, 00)
        else
            if shouldSync then
                SetWeatherTypeNow(weatherSync)
                SetWeatherTypePersist(weatherSync)
                SetWeatherTypeNowPersist(weatherSync)
                NetworkOverrideClockTime(clockHours, clockMinutes, 00)
            end
        end
        if beltLock then
            timeWait = 0
            DisableControlAction(1, 75, true)
        end
        Wait(timeWait)
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADHUD
-- -----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if LocalPlayer["state"]["Active"] and not LocalPlayer.state.Farming then
            if GetGameTimer() >= updateFoods and GetEntityHealth(PlayerPedId()) > 101 then
                updateFoods = GetGameTimer() + 45000
                clientThirst = clientThirst - 1
                clientHunger = clientHunger - 1
                if clientHunger <= 10 or clientThirst <= 10 then
                    ApplyDamageToPed(PlayerPedId(), 10, false)
                end
            end
        end
        Wait(30000)
    end
end)

RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger", function(Number)
    clientHunger = parseInt(Number)
    if clientHunger >= 100 then
        clientHunger = 100
    end
end)

RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst", function(Number)
    clientThirst = parseInt(Number)
    if clientThirst >= 100 then
        clientThirst = 100
    end
end)


RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress", function(Number)
    clientStress = parseInt(Number)
end)

CreateThread(function()
    while true do
        local ply = PlayerPedId()
        local timeSleep = 5000
        if LocalPlayer["state"]["Active"]  then
            timeSleep = 500
            if IsPauseMenuActive() then
                EmitNuiMessage("HUD:SHOW", { show = false })
                pauseBreak = true
            else
                if pauseBreak and showHud then
                    EmitNuiMessage("HUD:SHOW", { show = true })
                    pauseBreak = false
                end
            end
            if showHud then
                local armour = GetPedArmour(ply)
                local coords = GetEntityCoords(ply)
                local heading = GetEntityHeading(ply)
                local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"], coords["y"], coords["z"]))
                if heading >= 315 or heading < 45 then
                    flexDirection = "Norte"
                elseif heading >= 45 and heading < 135 then
                    flexDirection = "Oeste"
                elseif heading >= 135 and heading < 225 then
                    flexDirection = "Sul"
                elseif heading >= 225 and heading < 315 then
                    flexDirection = "Leste"
                end

                EmitNuiMessage("HUD:PLAYER_STATS", {
                    isTalking = MumbleIsPlayerTalking(128),
                    health = GetEntityHealth(ply) - 100,
                    armour = armour,
                    hunger = clientHunger,
                    thirst = clientThirst,
                    stress = clientStress,
                    oxigen = clientOxigen,
                    street = streetName,
                    direction = flexDirection,
                    radioMhz = radioDisplay,
                })
                SetInfos()
                DisplayRadar(true)
            end
        end
        Wait(timeSleep)
    end
end)

function SetInfos()
    local ply = PlayerPedId()
    if IsPedArmed(ply, 7) then
        local weaponModel = exports.inventory:Weapons()
        local weaponHash = GetSelectedPedWeapon(ply)
        local weaponAmmo = GetAmmoInPedWeapon(ply, weaponHash)
        local _, ammoInClip = GetAmmoInClip(ply, weaponHash)
        local isPedUsingMeleeWeapon = IsPedArmed(ply, 1)

        EmitNuiMessage("HUD:WEAPON", {
            weapon = {
                ammo = weaponAmmo - ammoInClip,
                ammoInClip = ammoInClip,
                name = itemName(weaponModel),
                model = itemIndex(weaponModel),
                isMelee = isPedUsingMeleeWeapon
            }
        })
    else
        EmitNuiMessage("HUD:WEAPON", { weapon = nil })
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADHUD VEHICLE
-- -----------------------------------------------------------------------------------------------------------------------------------------
local InVeh = false
local timeVehAwait = 1000
CreateThread(function()
    LoadPtfxAsset("veh_xs_vehicle_mods")
    while true do
        timeVehAwait = 2500
        local ply = PlayerPedId()
        if LocalPlayer["state"]["Active"]  then
            if showHud then
                if IsPedInAnyVehicle(ply) then
                    if not IsMinimapRendering() then
                        DisplayRadar(true)
                    end
                    timeVehAwait = 25
                    local vehicle = GetVehiclePedIsUsing(ply)
                    --local vehModel = GetEntityModel(vehicle)
                    local fuel = GetVehicleFuelLevel(vehicle)
                    local speed = GetEntitySpeed(vehicle) * 3.6
                    --local plate = GetVehicleNumberPlateText(vehicle)
                    local vehClass = GetVehicleClass(vehicle)
                    local showBelt = true
                    if vehClass == 8 or (vehClass >= 13 and vehClass <= 16) or vehClass == 21 then
                        showBelt = false
                    end
                    local nitroShow = 0
                    if not InVeh then
                        InVeh = true
                        EmitNuiMessage("HUD:INVEH", { inVeh = InVeh })
                    end

                    if NitroFlame then
                        NitroDisable()
                    end

                    if LocalPlayer["state"]["Nitro"] then
                        Nitro = NitroFuel
                    else
                        if (GlobalState["Nitro"][Plate] or 0) ~= Nitro then
                            Nitro = GlobalState["Nitro"][Plate] or 0
                        end
                    end

                    EmitNuiMessage("HUD:VEH_STATS", {
                        isTalking = MumbleIsPlayerTalking(128),
                        lowEngine = GetVehicleEngineHealth(vehicle) > 500,
                        carLocked = GetVehicleDoorLockStatus(vehicle) == 2,
                        speed = parseInt(speed),
                        rpm = IsVehicleEngineOn(vehicle) and parseInt(GetVehicleCurrentRpm(vehicle) * 100) or 0,
                        showBelt = showBelt,
                        seatBelt = beltLock,
                        nitro = nitroShow > 0 and parseInt((nitroShow * 100) / 1000) or 0,
                        fuel = parseInt(fuel),
                        inVeh = true
                    })
                    SetInfos()
                else
                    if InVeh then
                        InVeh = false
                        EmitNuiMessage("HUD:INVEH", { inVeh = InVeh })
                    end
                end
            end
        end
        Wait(timeVehAwait)
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud", function(source, args)
    showHud = not showHud

    if showHud then
        TriggerEvent("PrimaryHud:disable")
    end

    EmitNuiMessage("HUD:SHOW", { show = showHud })
    if IsMinimapRendering() and not showHud then
        DisplayRadar(false)
    end
end, false)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD:TOGGLEHOOD
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood", function()
    showHood = not showHood
    if showHood then
        SetPedComponentVariation(ply, 1, 69, 0, 1)
    else
        SetPedComponentVariation(ply, 1, 0, 0, 1)
    end
    SendNUIMessage({ hood = showHood })
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:active", function()
    showHud = not showHud
    DisplayRadar(true)

    if showHud then
        LocalPlayer.state.Hud = "Complexo"
        TriggerEvent("PrimaryHud:disable")
    end

    EmitNuiMessage("HUD:SHOW", { show = showHud })
    if IsMinimapRendering() and not showHud then
        DisplayRadar(false)
    end

    updateMapPosition()
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD:RADIODISPLAY
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio", function(Frequency)
    if parseInt(Frequency) <= 0 then
        radioDisplay = ""
    else
        radioDisplay = parseInt(Frequency)
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FOWARDPED
-- -----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
    local heading = GetEntityHeading(ped) + 90.0
    if heading < 0.0 then
        heading = 360.0 + heading
    end
    heading = heading * 0.0174533
    return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local shouldCheckForSeatBelt = true
function ChangeCheckForSeatBelt(status)
    shouldCheckForSeatBelt = status
end
CreateThread(function()
    while true do
        local timeDistance = 999
        if playerActive then
            if IsPedInAnyVehicle(ply) then
                if not IsPedOnAnyBike(ply) and not IsPedInAnyHeli(ply) and not IsPedInAnyPlane(ply) and shouldCheckForSeatBelt then
                    timeDistance = 50
                    local vehicle = GetVehiclePedIsUsing(ply)
                    local speed = GetEntitySpeed(vehicle) * 3.6
                    if speed ~= beltSpeed then
                        if (beltSpeed - speed) >= 40 and not beltLock then
                            local fowardVeh = fowardPed(ply)
                            local coords = GetEntityCoords(ply)
                            SetEntityCoords(ply, coords["x"] + fowardVeh["x"], coords["y"] + fowardVeh["y"], coords["z"] + 1, 1, 0, 0, 0)
                            SetEntityVelocity(ply, beltVelocity["x"], beltVelocity["y"], beltVelocity["z"])
                            ApplyDamageToPed(ply, 50, false)
                            Wait(1)
                            SetPedToRagdoll(ply, 5000, 5000, 0, 0, 0, 0)
                        end
                        beltVelocity = GetEntityVelocity(vehicle)
                        beltSpeed = speed
                    end
                end
            else
                if beltSpeed ~= 0 then
                    beltSpeed = 0
                end
                if beltLock then
                    beltLock = false
                end
            end
        end
        Wait(timeDistance)
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SEATBELT
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt", function()
        local ply = PlayerPedId()
        if not IsPedInAnyVehicle(ply, false) or IsPedOnAnyBike(ply) then return end
        if beltLock then
            TriggerEvent("sounds:Private", "unbelt", 0.5)
            beltLock = false
        else
            TriggerEvent("sounds:Private", "belt", 0.5)
            beltLock = true
    end
end, false)

AddEventHandler("hud:seatbelt", function(state)
        if not IsPedInAnyVehicle(ply, false) or IsPedOnAnyBike(ply) then return end

        beltLock = state

        if beltLock then
            TriggerEvent("sounds:source", "belt", 0.5)
        else
            TriggerEvent("sounds:source", "unbelt", 0.5)

    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- KEYMAPPING
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt", "Colocar/Retirar o cinto.", "keyboard", "g")
-------------------------------------------------------------------------------------------------------------------------------
-- -- REMOVESCUBA
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:ScubaRemove")
AddEventHandler("hud:ScubaRemove", function()
    if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
        if DoesEntityExist(divingMask) then
            _TRE("tryDeleteObject", ObjToNet(divingMask))
            divingMask = nil
        end
        if DoesEntityExist(divingTank) then
            _TRE("tryDeleteObject", ObjToNet(divingTank))
            divingTank = nil
        end
        SetEnableScuba(ply, false)
        SetPedMaxTimeUnderwater(ply, 10.0)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local defaultAspectRatio = 1920 / 1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapXOffset, minimapYOffset = 0, 0
    if aspectRatio > defaultAspectRatio then
        local aspectDifference = defaultAspectRatio - aspectRatio
        minimapXOffset = aspectDifference / 3.6
    end
    SetMinimapComponentPosition("minimap", "L", "B", -0.0045 + minimapXOffset, 0.002 + minimapYOffset, 0.150, 0.188888)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.020 + minimapXOffset, 0.030 + minimapYOffset, 0.111, 0.159)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.03 + minimapXOffset, 0.022 + minimapYOffset, 0.266, 0.237)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()

    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    Minimap.res_x = res_x
    Minimap.res_y = res_y
    return Minimap
end

function updateMapPosition()
    local defaultAspectRatio = 1920 / 1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapXOffset, minimapYOffset = 0, 0
    if aspectRatio > defaultAspectRatio then
        local aspectDifference = defaultAspectRatio - aspectRatio
        minimapXOffset = aspectDifference / 3.6
    end
    DisplayRadar(true)
    DisplayRadar(false)
    RequestStreamedTextureDict("circleminimap", false)

    while not HasStreamedTextureDictLoaded("circleminimap") do
        Wait(500) -- mudei o wait de 100 para 500
    end

    SetMinimapClipType(1)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circleminimap", "radarmasksm")
    SetMinimapComponentPosition("minimap", "L", "B", -0.0045 + minimapXOffset, 0.002 + minimapYOffset - 0.025, 0.150,
        0.188888)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.020 + minimapXOffset, 0.030 + minimapYOffset - 0.025,
        0.111,
        0.159)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.03 + minimapXOffset, 0.022 + minimapYOffset - 0.025,
        0.266,
        0.237)

    SetBigmapActive(true, false)
    Wait(50)
    SetBigmapActive(false, false)
    Wait(1000)
    DisplayRadar(false)
end

CreateThread(function()
    Wait(1000)
    while true do
        local timeSleep = 10000
        -- if LocalPlayer.state.Hud == "Street" then
            timeSleep = 5000
            local Minimap = GetMinimapAnchor()
            local anchor = {
                Street = {
                    Top = (Minimap.res_y * Minimap.top_y) - 55,
                    Left = (Minimap.res_x * Minimap.left_x)
                },
                Status = {
                    Top = (Minimap.res_y * Minimap.top_y),
                    Left = (Minimap.res_x * Minimap.right_x) + 20,
                    Height = (Minimap.height * 100) - 1.6, -- Percentage
                    Width = (Minimap.width * 100)
                }
            }

            EmitNuiMessage("HUD:BOUNDS", { anchor = anchor })
        -- end
        Wait(timeSleep)
    end
end)

function SendWeaponInfo()
    local ply = PlayerPedId()
    local weaponModel = exports.inventory:Weapons()
    local weaponHash = GetSelectedPedWeapon(ply)
    local weaponAmmo = GetAmmoInPedWeapon(ply, weaponHash)
    local _, ammoInClip = GetAmmoInClip(ply, weaponHash)
    local isPedUsingMeleeWeapon = IsPedArmed(ply, 1)
    EmitNuiMessage("HUD:WEAPON", {
        weapon = {
            ammo = weaponAmmo - ammoInClip,
            ammoInClip = ammoInClip,
            name = itemName(weaponModel),
            model = string.upper(weaponModel),
            isMelee = isPedUsingMeleeWeapon
        }
    })
end

local notifyId = 0
local notifyStyles = {
    ["vermelho"] = { "error", "Ocorreu um erro!" },
    ["negado"] = { "error", "Ocorreu um erro!" },
    ["verde"] = { "success", "Sucesso!" },
    ["azul"] = { "info", "Informação" },
    ["amarelo"] = { "warn", "Informação" },
    ["hunger"] = { "info", "Fome", "hunger" },
    ["thirst"] = { "info", "Sede", "thirst" },
    ["blood"] = { "error", "Sangramento!", "blood" },
}

RegisterNetEvent("Notify")
AddEventHandler("Notify", function(style, message, title, timer)
    if LocalPlayer.state.Hud == "America" then return end
    if not timer then timer = 5000 end
    notifyId = notifyId + 1
    EmitNuiMessage("HUD:NOTIFY", {
        notify = {
            id = notifyId,
            type = notifyStyles[style] and notifyStyles[style][1] or "info",
            title = notifyStyles[style] and notifyStyles[style][2] or "Informação",
            description = message,
            duration = timer,
            uniqueId = notifyStyles[style] and notifyStyles[style][3] or nil
        }
    })
end)

function EmitNuiMessage(type, payload)
    SendNUIMessage({
        type = type,
        payload = { payload } or {}
    })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 999
        local ply = PlayerPedId()
        if IsPedInAnyPoliceVehicle(ply) and policeService  then
            if policeRadar then
                if not policeFreeze then
                    timeDistance = 100

                    local vehicle = GetVehiclePedIsUsing(ply)
                    local vehicleDimension = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.0, 1.0)

                    local vehicleFront = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 105.0, 0.0)
                    local vehicleFrontShape = StartShapeTestCapsule(vehicleDimension, vehicleFront, 3.0, 10, vehicle, 7)
                    local _, _, _, _, vehFront = GetShapeTestResult(vehicleFrontShape)

                    if IsEntityAVehicle(vehFront) then
                        local vehModel = GetEntityModel(vehFront)
                        local vehPlate = GetVehicleNumberPlateText(vehFront)
                        local vehSpeed = GetEntitySpeed(vehFront) * 3.6
                        local vehName = GetDisplayNameFromVehicleModel(vehModel)

                        EmitNuiMessage("HUD:SET_FRONT_RADAR",
                            { Plate = vehPlate, Model = vehName, Speed = math.floor(vehSpeed) })
                    end

                    local vehicleBack = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -105.0, 0.0)
                    local vehicleBackShape = StartShapeTestCapsule(vehicleDimension, vehicleBack, 3.0, 10, vehicle, 7)
                    local _, _, _, _, vehBack = GetShapeTestResult(vehicleBackShape)

                    if IsEntityAVehicle(vehBack) then
                        local vehModel = GetEntityModel(vehBack)
                        local vehPlate = GetVehicleNumberPlateText(vehBack)
                        local vehSpeed = GetEntitySpeed(vehBack) * 3.6
                        local vehName = GetDisplayNameFromVehicleModel(vehModel)

                        EmitNuiMessage("HUD:SET_BACK_RADAR",
                            { Plate = vehPlate, Model = vehName, Speed = math.floor(vehSpeed) })
                    end
                end
            end
        end

        if not IsPedInAnyVehicle(ply) and policeRadar then
            policeRadar = false
            EmitNuiMessage("HUD:SET_FRONT_RADAR", nil)
            EmitNuiMessage("HUD:SET_BACK_RADAR", nil)
        end

        Wait(timeDistance)
    end
end)

RegisterCommand("toggleRadar", function(source, args)
    if IsPedInAnyPoliceVehicle(ply) and policeService then
        if policeRadar then
            policeRadar = false

            EmitNuiMessage("HUD:SET_FRONT_RADAR", nil)
            EmitNuiMessage("HUD:SET_BACK_RADAR", nil)
        else
            policeRadar = true

            EmitNuiMessage("HUD:SET_FRONT_RADAR", { Plate = "--", Model = "Desconhecido", Speed = 0 })
            EmitNuiMessage("HUD:SET_BACK_RADAR", { Plate = "--", Model = "Desconhecido", Speed = 0 })
        end
    end
end, false)

RegisterCommand("toggleFreeze", function(source, args)
    if IsPedInAnyPoliceVehicle(ply) and policeService then
        policeFreeze = not policeFreeze
    end
end, false)

RegisterNetEvent("police:updateService", function(status)
    policeService = status
end)

RegisterKeyMapping("toggleRadar", "Ativar/Desativar radar das viaturas.", "keyboard", "N")
RegisterKeyMapping("toggleFreeze", "Travar/Destravar radar das viaturas.", "keyboard", "M")

-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted", function()
    return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed", function()
    return false
end)

function LoadPtfxAsset(Library)
    RequestNamedPtfxAsset(Library)
    while not HasNamedPtfxAssetLoaded(Library) do
        RequestNamedPtfxAsset(Library)
        Wait(1)
    end

    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
    RequestStreamedTextureDict(Library, false)
    while not HasStreamedTextureDictLoaded(Library) do
        RequestStreamedTextureDict(Library, false)
        Wait(1)
    end

    return true
end