-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
local vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local Creative = {}
Tunnel.bindInterface(GetCurrentResourceName(), Creative)

local CurrentInventory = {}
local CurrentWeapon = ""
local dropList = {}
local UseCooldown = GetGameTimer()
local Usables = 1
local defaultTimeout <const> = 60000
local StoreWeapon = false
local TakeWeapon = false
local Drops = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Weapons",function()
	return Weapon
end)

local weaponAmmos = {
    ["WEAPON_PISTOL_AMMO"] = {
        "WEAPON_PISTOL_MK2",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_VINTAGEPISTOL"
    },
    ["WEAPON_NAIL_AMMO"] = {
        "WEAPON_NAILGUN"
    },
    ["WEAPON_RPG_AMMO"] = {
        "WEAPON_RPG"
    },
    ["WEAPON_SMG_AMMO"] = {
        "WEAPON_MICROSMG",
        "WEAPON_MINISMG",
        "WEAPON_APPISTOL",
        "WEAPON_GUSENBERG",
        "WEAPON_MACHINEPISTOL"
    },
    ["WEAPON_RIFLE_AMMO"] = {
        "WEAPON_QBZ83",
        "WEAPON_PARAFAL",
        "WEAPON_COLTXM177",
        "WEAPON_COMPACTRIFLE",
        "WEAPON_BULLPUPRIFLE",
        "WEAPON_BULLPUPRIFLE_MK2",
        "WEAPON_ADVANCEDRIFLE",
        "WEAPON_ASSAULTRIFLE",
        "WEAPON_HEAVYRIFLE",
        "WEAPON_ASSAULTSMG",
        "WEAPON_ASSAULTRIFLE_MK2",
        "WEAPON_SPECIALCARBINE",
        "WEAPON_SPECIALCARBINE_MK2"
    },
    ["WEAPON_SHOTGUN_AMMO"] = {
        "WEAPON_PUMPSHOTGUN_MK2",
        "WEAPON_SAWNOFFSHOTGUN"
    },
    ["WEAPON_POLICE_AMMO"] = {
        "WEAPON_FNSCAR",
        "WEAPON_SMG",
        "WEAPON_PISTOL",
        "WEAPON_PUMPSHOTGUN",
        "WEAPON_CARBINERIFLE",
        "WEAPON_TACTICALRIFLE",
        "WEAPON_COMBATPISTOL",
        "WEAPON_CARBINERIFLE_MK2",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_SMG_MK2",
        "WEAPON_FNFAL",

    },
    ["WEAPON_MUSKET_AMMO"] = {
        "WEAPON_MUSKET",
        "WEAPON_SAUER"
    },
    ["WEAPON_PETROLCAN_AMMO"] = {
        "WEAPON_PETROLCAN"
    }
}

local craftList = {
    { vec3(713.95, -961.54, 30.4), "dressMaker" },
    { vec3(82.45, -1553.26, 29.59), "lixeiroShop" },
    { vec3(287.36, 2843.6, 44.7), "lixeiroShop" },
    { vec3(-413.68, 6171.99, 31.48), "lixeiroShop" },
    { vec3(228.35, -1752.9, 25.24), "ilegalWeapons" },
    { vec3(-1001.07, -1025.9, 2.19), "ilegalWeapons" },
    { vec3(-197.84, -1711.81, 32.65), "lockpickShop" },
    { vec3(2115.82, 4770.93, 41.16), "lockpickShop" },
    { vec3(895.06, -962.75, 35.55), "dirtyMoneys" },
    { vec3(1218.28, -275.69, 70.18), "padariaStore" },
    { vec3(473.85, -634.85, 25.65), "drugMixShop" },
    { vec3(-1753.74, -1086.96, 14.05), "jobsCrafting" }
}

-- Variaveis
local fireTimers
local firecracker
local uCarry
local iCarry = false
local sCarry = false
local Types = ""
local scaleForms = {}
local useWeapon = ""
local putWeaponHands = false
local storeWeaponHands = false
local timeReload = GetGameTimer()
local plyIdentity = {}
local plyInventory = {}
local WEAPON_UNARMED <const> = `WEAPON_UNARMED`
local useItemCooldown = 0
local blockButtons = false
local Paralyzing = false
-------------------
--- Refeito ---
-------------------

RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin", function(Index, Plate)
    if NetworkDoesNetworkIdExist(Index) then
        local Vehicle = NetToEnt(Index)
        if DoesEntityExist(Vehicle) then
            if GetVehicleNumberPlateText(Vehicle) == Plate then
                local Fuel = GetVehicleFuelLevel(Vehicle)

                SetVehicleFixed(Vehicle)
                SetVehicleDeformationFixed(Vehicle)

                SetVehicleFuelLevel(Vehicle, Fuel)
                TriggerServerEvent("CleanVehicle", VehToNet(Vehicle))
            end
        end
    end
end)
CreateThread(function()
    -- FIXME: Remover em produção
    if GetScreenblurFadeCurrentTime() > 0 then TriggerScreenblurFadeOut(0.0) end
end)

function loadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end
end

function LoadModel(mHash, timeout)
    if not IsModelValid(mHash) then error("Not valid model requested:", mHash) end
    if not HasModelLoaded(mHash) then
        RequestModel(mHash)
        while not HasModelLoaded(mHash) do Wait(50) end
        SetTimeout(timeout or defaultTimeout, function() SetModelAsNoLongerNeeded(mHash) end)
    end
end

function LoadAnimDict(animDict, timeout)
    if not DoesAnimDictExist(animDict) then error("Not valid animDict requested:", animDict) end
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do Wait(50) end
        SetTimeout(timeout or defaultTimeout, function() RemoveAnimDict(animDict) end)
    end
end

function LoadNamedPtfxAsset(asset, timeout)
    if not HasNamedPtfxAssetLoaded(asset) then
        RequestNamedPtfxAsset(asset)
        while not HasNamedPtfxAssetLoaded(asset) do Wait(50) end
        SetTimeout(timeout or defaultTimeout, function() RemoveNamedPtfxAsset(asset) end)
    end
end

local function errorSound()
    PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", false, false, false)
end


local function genereteProfilePicture()
    local mugshot = RegisterPedheadshotTransparent(PlayerPedId())
    while not IsPedheadshotReady(mugshot) do
        Wait(100)
    end
    SendNUIMessage { action = "generateMugshot", payload = GetPedheadshotTxdString(mugshot) }
    SetTimeout(1500, function()
        UnregisterPedheadshot(mugshot)
    end)
end

local function GetDropList()
    local Items = {}

    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local _, CoordsZ = GetGroundZFor_3dCoord(Coords["x"], Coords["y"], Coords["z"])

    for Index, v in pairs(Drops) do
        if #(vec3(Coords["x"], Coords["y"], CoordsZ) - vec3(v["Coords"][1], v["Coords"][2], v["Coords"][3])) <= 0.9 then
            local Number = #Items + 1

            Items[Number] = v
            Items[Number]["id"] = Index
        end
    end

    return Items
end

local function SetDropData()
    local Ped = PlayerPedId()
    local groundDropList = GetDropList()
    if table.type(groundDropList) == "empty" then return end
    SendNUIMessage({
        action = "setOtherInventory",
        payload = {
            title = "Chão",
            inventory = groundDropList,
            slots = 90
        }
    })
end

RegisterNUICallback("openCrafting", function(_, cb)
    local ply = PlayerPedId()

    local plyCds = GetEntityCoords(ply)
    for i = 1, #craftList do
        local v = craftList[i]
        local distance = #(plyCds - v[1])
        if distance < 5.0 then
            currentCrafting = v[2]
            return cb(vSERVER.requestCrafting(v[2]))
        end
    end
    cb({})
end)

RegisterNUICallback("functionCraft", function(data, cb)
    if currentCrafting == "" then error("empty crafting station") end
    vSERVER._functionCrafting(data.index, currentCrafting, data.amount)
    cb('ok')
end)

RegisterCommand("moc", function()
    local Ped = PlayerPedId()
    if GetEntityHealth(Ped) < 102 then return end
    if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPauseMenuActive() then
        if IsPlayerFreeAiming(128) then return end
        if GetScreenblurFadeCurrentTime() > 0 then return end
        SetNuiFocus(true, true)
        SetCursorLocation(0.5, 0.5)
        TriggerScreenblurFadeIn(250.0)
        SendNUIMessage({ action = "showMenu" })
        SetDropData()
        local NewInventory, MaxWeight, MaxSlots, PlayerData = vSERVER.requestInventory()
        if not NewInventory then return errorSound() end
        CurrentInventory = NewInventory
        SendNUIMessage({
            action = "setPlayerInventory",
            payload = {
                inventory = NewInventory,
                maxWeight = math.floor(MaxWeight + 1),
                slots = MaxSlots or 18
            }
        })
        SendNUIMessage({ action = "setPlayerData", payload = PlayerData })
        genereteProfilePicture()
    else
        CloseInventory()
    end
end)

RegisterNetEvent("inventory:Slot")
AddEventHandler("inventory:Slot", function(Number, Amount)
    Usables = parseInt(Number)
    if MumbleIsConnected() then
        vSERVER.UseItem(Number, Amount)
    end
end)

RegisterNUICallback("useItem", function(Data, cb)
    if GetGameTimer() >= UseCooldown then
        TriggerEvent("inventory:Slot", Data["slot"], Data["amount"])
        UseCooldown = GetGameTimer() + 1000
    end

    cb("Ok")
end)

RegisterNUICallback("updateSlot", function(Data, cb)
    vRPS.invUpdate(Data["slot"], Data["target"], Data["amount"])
    cb("ok")
end)


function Creative.returnWeapon()
    return CurrentWeapon ~= "" and CurrentWeapon
end

exports("returnWeapon", function()
    return CurrentWeapon ~= "" and CurrentWeapon
end)


function Creative.storeWeaponHands()
    if not StoreWeapon then
        StoreWeapon = true

        local Last = CurrentWeapon
        local Ped = PlayerPedId()
        LocalPlayer["state"]:set("Cancel", true, true)

        if not IsPedInAnyVehicle(Ped) then
            if LoadAnim("weapons@pistol@") then
                TaskPlayAnim(Ped, "weapons@pistol@", "aim_2_holster", 8.0, 8.0, -1, 48, 0, 0, 0, 0)
            end

            Wait(450)

            ClearPedTasks(Ped)
        end

        local Ammos = GetAmmoInPedWeapon(Ped, CurrentWeapon)

        StoreWeapon = false
        TriggerEvent("inventory:CleanWeapons", true)
        LocalPlayer["state"]:set("Cancel", false, true)

        return true, Ammos, Last
    end

    return false
end

function Creative.putAttachs(nameItem, nameWeapon)
    GiveWeaponComponentToPed(PlayerPedId(), nameWeapon, Attachs[nameItem][nameWeapon])
end

function Creative.putWeaponHands(Name, Ammo, Components, Type)
    if LocalPlayer["state"]["SafeZone"] then
        TriggerEvent("Notify", "negado", "Você não pode fazer isso aqui.", "Atenção", 5000)
        return
    end

    if not TakeWeapon then
        if not Ammo then
            Ammo = 0
        end

        if Ammo > 0 then
            Actived = true
        end

        TakeWeapon = true
        LocalPlayer["state"]:set("Cancel", true, true)

        local Ped = PlayerPedId()
        if not IsPedInAnyVehicle(Ped) then
            if LoadAnim("rcmjosh4") then
                TaskPlayAnim(Ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 8.0, -1, 48, 0, 0, 0, 0)
            end

            Wait(200)

            CurrentWeapon = Name
            TriggerEvent("inventory:RemoveWeapon", Name)
            GiveWeaponToPed(Ped, Name, Ammo, false, true)

            Wait(300)

            ClearPedTasks(Ped)
        else
            CurrentWeapon = Name
            TriggerEvent("inventory:RemoveWeapon", Name)
            GiveWeaponToPed(Ped, Name, Ammo, false, true)
        end

        if Components then
            for nameItem, _ in pairs(Components) do
                Creative.putAttachs(nameItem, Name)
            end
        end

        if Type then
            Types = Type
        end

        TakeWeapon = false
        LocalPlayer["state"]:set("Cancel", false, true)

        if itemAmmo(Name) then
            TriggerEvent("hud:Weapon", true, Name)
        end

        if not MumbleIsConnected() or vSERVER.dropWeapons(Name) or LocalPlayer["state"]["Safezone"] then
            TriggerEvent("inventory:CleanWeapons", true)
        end

        return true
    end

    return false
end

function Creative.rechargeCheck(ammoType)
    local weaponAmmo = 0
    local weaponHash = nil
    local Ped = PlayerPedId()
    local weaponStatus = false

    if weaponAmmos[ammoType] then
        weaponAmmo = GetAmmoInPedWeapon(Ped, Weapon)
        for _, v in pairs(weaponAmmos[ammoType]) do
            if CurrentWeapon == v then
                weaponHash = CurrentWeapon
                weaponStatus = true
                break
            end
        end
    end

    return weaponStatus, weaponHash, weaponAmmo
end

RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar", function(Number, Table)
    Drops[Number] = Table
end)

RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover", function(Number)
    if Drops[Number] then
        Drops[Number] = nil
    end
end)



CreateThread(function()
    while true do
        local TimeDistance = 999

        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        for _, v in pairs(Drops) do
            if #(Coords - vec3(v["Coords"][1], v["Coords"][2], v["Coords"][3])) <= 50 then
                TimeDistance = 1
                DrawMarker(23, v["coords"][1], v["coords"][2], v["coords"][3] + 0.05, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.15, 0.15, 0.0, 255, 255, 255, 50, 0, 0, 0, 0)
                DrawMarker(21, v["coords"][1], v["coords"][2], v["coords"][3] + 0.25, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.20, 0.20, 0.20, 42, 137, 255, 125, 0, 0, 0, 1)
            end
        end

        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons", function(Create)
    if Weapon ~= "" then
        RemoveAllPedWeapons(PlayerPedId(), true)
    end

    TriggerEvent("hud:Weapon", false)
    Actived = false
    CurrentWeapon = ""
    Types = ""
end)



RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open", function()
    SetNuiFocus(true, true)
    local NewInventory, MaxWeight, MaxSlots = vSERVER.requestInventory()
    if not NewInventory then return errorSound() end
    CurrentInventory = NewInventory
    local myInfos, vehInfos, InventoryWeight, PlayerWeight, ChestWeight, VehicleWeight = vSERVER.openChest()
    CurrentInventory = myInfos
    openTrunkChest(CurrentInventory, MaxWeight, vehInfos, ChestWeight)
    vRP.playAnim(false, { "amb@prop_human_bum_bin@base", "base" }, true)
end)


function openTrunkChest(myInventory, myBackpack, vehInventory, vehWeight)
    -- if not IsNuiFocused() then
    trunking = true
    SetNuiFocus(true, true)
    SetCursorLocation(0.5, 0.5)
    TriggerScreenblurFadeIn(250.0)
    SendNUIMessage({ action = "showMenu" })
    -- end

    SendNUIMessage({
        action = "setPlayerInventory",
        payload = {
            inventory = myInventory,
            maxWeight = myBackpack
        }
    })
    SendNUIMessage({
        action = "setOtherInventory",
        payload = {
            title = "Porta Malas",
            inventory = vehInventory,
            maxWeight = vehWeight,
            slots = 90
        }
    })
end

RegisterNetEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel", function()
    vSERVER.Cancel()
end)

RegisterNuiCallback("tradeItem", function(data, cb)
    if chestOpen and chestId then
        if data.from == "Mochila" then
            vSERVER.storeChestItem(data.item.labelName, data.slot, data.amount, data.target, chestOpen, chestId)
        else
            vSERVER.takeChestItem(data.item.labelName, data.slot, data.amount, data.target, chestOpen, chestId)
        end
    elseif inspecting then
        if data.from == "Mochila" then
            vSERVER.storeInspectItem(data.item.Item, data.slot, data.amount, data.target)
        else
            vSERVER.takeInspectItem(data.item.Item, data.slot, data.amount, data.target)
        end
    elseif trunking then
        if data.from == "Mochila" then
            vSERVER.storeTrunkChestItem(data.item.Item, data.slot, data.amount, data.target)
        else
            vSERVER.takeTrunkChestItem(data.item.Item, data.slot, data.amount, data.target)
        end
    elseif housing then
        if data.from == "Mochila" then
            vSERVER.storeHouseItem(data.item.Item, data.slot, data.amount, data.target, houseName, houseVault)
        else
            vSERVER.takeHouseItem(data.item.Item, data.slot, data.amount, data.target, houseName, houseVault)
        end
    elseif data.to == "Chão" then
        print('pegou do chao')
        data.item = data.item.Item
        dropItem(data)
    end
    cb("ok")
end)

RegisterNetEvent("inventory:clearWeapons", function()
    local ply = PlayerPedId()
    if CurrentWeapon ~= "" then RemoveAllPedWeapons(ply, true) end
    CurrentWeapon = ""
    Types = ""
    TriggerEvent("utils:PedWeapons", IsPedArmed(ply, 7), GetSelectedPedWeapon(ply))
end)

RegisterNetEvent("inventory:verifyWeapon", function(splitName)
    splitName = splitString(splitName, "-")
    if CurrentWeapon == splitName[1] then
        print('caiu aq')
        local ply = PlayerPedId()
        local weaponAmmo = GetAmmoInPedWeapon(ply, CurrentWeapon)
        if not vSERVER.VerificarArma(splitName[1], weaponAmmo) then
            RemoveAllPedWeapons(ply, true)
            CurrentWeapon = ""
            Types = ""
        end
    else
        if CurrentWeapon == "" then
            vSERVER.VerificarArma(splitName[1])
        end
    end
    TriggerEvent("utils:PedWeapons", IsPedArmed(ply, 7), GetSelectedPedWeapon(ply))
end)

RegisterNetEvent("inventory:preventWeapon", function(storeWeapons)
    if CurrentWeapon ~= WEAPON_UNARMED then
        local ply = PlayerPedId()
        local weaponAmmo = GetAmmoInPedWeapon(ply, CurrentWeapon)
        vSERVER.PreventWeapons(CurrentWeapon, weaponAmmo)
        if storeWeapons then RemoveAllPedWeapons(ply, true) end
        CurrentWeapon = ""
        Types = ""
        TriggerEvent("utils:PedWeapons", IsPedArmed(ply, 7), GetSelectedPedWeapon(ply))
    end
end)

function CloseInventory()
    while IsScreenblurFadeRunning() do Wait(25) end
    SetNuiFocus(false, false)
    SetCursorLocation(0.5, 0.5)
    SendNUIMessage({ action = "hideMenu" })
    if chestOpen or chestId then
        chestId = nil
        chestOpen = false
    end
    if inspecting then
        inspecting = false
        vSERVER.resetInspect()
    end
    if trunking then
        trunking = false
        vSERVER.trunkChestClose()
        vRP.removeObjects()
    end
    if housing then
        housing = false
        houseName = nil
        houseVault = nil
    end
    TriggerScreenblurFadeOut(500.0)
end

local function dropItem(data)
    if IsPedInAnyVehicle(ply) then return end
    local coords = GetEntityCoords(ply)
    local gridZone = getGridzone(coords["x"], coords["y"])
    local _, cdz = GetGroundZFor_3dCoord(coords["x"], coords["y"], coords["z"])
    vSERVER.Drops(data["item"], data["slot"], data["amount"], coords["x"], coords["y"], cdz, gridZone)
end


RegisterNUICallback("pickupItem", function(data, cb)
    local coords = GetEntityCoords(ply)
    local gridZone = getGridzone(coords["x"], coords["y"])
    vSERVER.Pickup(data["id"], data["amount"], data["target"], gridZone)
    cb("ok")
end)

function gridChunk(x)
    return math.floor((x + 8192) / 128)
end

function toChannel(v)
    return (v["x"] << 8) | v["y"]
end

-------------------

local function BlockButtons()
    while blockButtons do
        DisableControlAction(1, 75, true)
        DisableControlAction(1, 47, true)
        DisableControlAction(1, 257, true)
        DisablePlayerFiring(128, true)
        Wait(0)
    end
end

local function blockInvents()
    if exports["player"]:handCuff() then return false end
    return blockButtons
end

exports("blockInvents", blockInvents)

local function PreventWeapon()
    while plyArmed do
        local weaponAmmo = GetAmmoInPedWeapon(ply, useWeapon)
        if GetGameTimer() >= timeReload and IsPedReloading(ply) then
            vSERVER._preventWeapon(useWeapon, weaponAmmo)
            timeReload = GetGameTimer() + 1000
        end
        if (useWeapon == "WEAPON_PETROLCAN" and weaponAmmo <= 135 and IsPedShooting(ply)) or (useWeapon == "WEAPON_FIREEXTINGUISHER" and weaponAmmo <= 135 and IsPedShooting(ply)) or IsPedSwimming(ply) then
            if Types ~= "" then
                vSERVER._removeThrowing(Types)
            else
                vSERVER._preventWeapon(useWeapon, weaponAmmo)
            end
            RemoveAllPedWeapons(ply, true)
            useWeapon = ""
            Types = ""
            TriggerEvent("utils:PedWeapons", IsPedArmed(ply, 7), GetSelectedPedWeapon(ply))
        end
        Wait(100)
    end
end


local function ApplyBarbershopToPed(ped, custom)
    local weightFace = custom[2] / 100 + 0.0
    local weightSkin = custom[4] / 100 + 0.0
    SetPedHeadBlendData(ped, custom[41], custom[1], 0, custom[41], custom[1], 0, weightFace, weightSkin, 0.0, false)
    SetPedEyeColor(ped, custom[3])
    if custom[5] == 0 then
        SetPedHeadOverlay(ped, 0, custom[5], 0.0)
    else
        SetPedHeadOverlay(ped, 0, custom[5], 1.0)
    end
    SetPedHeadOverlay(ped, 6, custom[6], 1.0)
    if custom[7] == 0 then
        SetPedHeadOverlay(ped, 9, custom[7], 0.0)
    else
        SetPedHeadOverlay(ped, 9, custom[7], 1.0)
    end
    SetPedHeadOverlay(ped, 3, custom[8], 1.0)
    SetPedComponentVariation(ped, 2, custom[9], 0, 1)
    SetPedHairColor(ped, custom[10], custom[11])
    SetPedHeadOverlay(ped, 4, custom[12], custom[13] * 0.1)
    SetPedHeadOverlayColor(ped, 4, 1, custom[14], custom[14])
    SetPedHeadOverlay(ped, 8, custom[15], custom[16] * 0.1)
    SetPedHeadOverlayColor(ped, 8, 1, custom[17], custom[17])
    SetPedHeadOverlay(ped, 2, custom[18], custom[19] * 0.1)
    SetPedHeadOverlayColor(ped, 2, 1, custom[20], custom[20])
    SetPedHeadOverlay(ped, 1, custom[21], custom[22] * 0.1)
    SetPedHeadOverlayColor(ped, 1, 1, custom[23], custom[23])
    SetPedHeadOverlay(ped, 5, custom[24], custom[25] * 0.1)
    SetPedHeadOverlayColor(ped, 5, 1, custom[26], custom[26])
    SetPedFaceFeature(ped, 0, custom[27] * 0.1)
    SetPedFaceFeature(ped, 1, custom[28] * 0.1)
    SetPedFaceFeature(ped, 4, custom[29] * 0.1)
    SetPedFaceFeature(ped, 6, custom[30] * 0.1)
    SetPedFaceFeature(ped, 8, custom[31] * 0.1)
    SetPedFaceFeature(ped, 9, custom[32] * 0.1)
    SetPedFaceFeature(ped, 10, custom[33] * 0.1)
    SetPedFaceFeature(ped, 12, custom[34] * 0.1)
    SetPedFaceFeature(ped, 13, custom[35] * 0.1)
    SetPedFaceFeature(ped, 14, custom[36] * 0.1)
    SetPedFaceFeature(ped, 15, custom[37] * 0.1)
    SetPedFaceFeature(ped, 16, custom[38] * 0.1)
    SetPedFaceFeature(ped, 17, custom[39] * 0.1)
    SetPedFaceFeature(ped, 19, custom[40] * 0.1)
end
local function ApplyClothingToPed(ped, data, category)
    local item = data.item
    local texture = data.texture
    if category == "pants" then
        SetPedComponentVariation(ped, 4, item, 0, 1)
        SetPedComponentVariation(ped, 4, GetPedDrawableVariation(ped, 4), texture, 1)
    elseif category == "arms" then
        SetPedComponentVariation(ped, 3, item, 0, 1)
        SetPedComponentVariation(ped, 3, GetPedDrawableVariation(ped, 3), texture, 1)
    elseif category == "tshirt" then
        SetPedComponentVariation(ped, 8, item, 0, 1)
        SetPedComponentVariation(ped, 8, GetPedDrawableVariation(ped, 8), texture, 1)
    elseif category == "decals" then
        SetPedComponentVariation(ped, 10, item, 0, 1)
        SetPedComponentVariation(ped, 10, item, texture, 1)
    elseif category == "accessory" then
        SetPedComponentVariation(ped, 7, item, 0, 1)
        SetPedComponentVariation(ped, 7, item, texture, 1)
    elseif category == "torso" then
        SetPedComponentVariation(ped, 11, item, 0, 1)
        SetPedComponentVariation(ped, 11, GetPedDrawableVariation(ped, 11), texture, 1)
    elseif category == "shoes" then
        SetPedComponentVariation(ped, 6, item, 0, 1)
        SetPedComponentVariation(ped, 6, GetPedDrawableVariation(ped, 6), texture, 1)
    elseif category == "mask" then
        SetPedComponentVariation(ped, 1, item, 0, 1)
        SetPedComponentVariation(ped, 1, GetPedDrawableVariation(ped, 1), texture, 1)
    elseif category == "hat" then
        if item ~= -1 then
            SetPedPropIndex(ped, 0, item, texture, 1)
        else
            ClearPedProp(ped, 0)
        end
        SetPedPropIndex(ped, 0, item, texture, 1)
    elseif category == "glass" then
        if item ~= -1 then
            SetPedPropIndex(ped, 1, item, texture, 1)
        else
            ClearPedProp(ped, 1)
        end
        SetPedPropIndex(ped, 1, item, texture, 1)
    elseif category == "ear" then
        if item ~= -1 then
            SetPedPropIndex(ped, 2, item, texture, 1)
        else
            ClearPedProp(ped, 2)
        end
        SetPedPropIndex(ped, 2, item, texture, 1)
    elseif category == "watch" then
        if item ~= -1 then
            SetPedPropIndex(ped, 6, item, texture, 1)
        else
            ClearPedProp(ped, 6)
        end
        SetPedPropIndex(ped, 6, item, texture, 1)
    elseif category == "bracelet" then
        if item ~= -1 then
            SetPedPropIndex(ped, 7, item, texture, 1)
        else
            ClearPedProp(ped, 7)
        end
        SetPedPropIndex(ped, 7, item, texture, 1)
    end
end
local function ApplyTattoosToPed(ped, tattoos)
    for index, tatto in pairs(tattoos) do
        SetPedDecoration(ped, joaat(tatto[1]), joaat(index))
    end
end
local function CreateLocalPed(hash)
    LoadModel(hash)
    local ped = CreatePed(4, hash, GetEntityCoords(ply), false, false)
    while not DoesEntityExist(ped) do Wait(25) end
    return ped
end
local function DeleteEntityWhileUsingAlpha(entity)
    local alpha = GetEntityAlpha(entity)
    while alpha > 0 do
        alpha -= 1.0
        SetEntityAlpha(entity, alpha, false)
        Wait(0)
    end
    DeleteEntity(entity)
end
local function chaikin(dest, points, iterations)
    local result = {}
    for i = 1, #points - 1 do
        result[#result + 1] = points[i]
        result[#result + 1] = vec3((points[i].x + points[i + 1].x) / 2, (points[i].y + points[i + 1].y) / 2,
            (points[i].z + points[i + 1].z) / 2)
    end
    result[#result + 1] = points[#points]
    if iterations > 1 then
        chaikin(dest, result, iterations - 1)
    else
        dest.points = result
    end
end
local function draw_curve(points, particleDict, particleSet, scale, insertionTable)
    insertionTable = {}
    for i = 1, #points - 1 do
        local random_offset_x = math.random(-1, 1)
        local random_offset_y = math.random(-1, 2)
        local random_offset_z = math.random(-1, 2)
        local distance = math.sqrt(random_offset_x * random_offset_x + random_offset_y * random_offset_y)
        random_offset_x /= distance * 2
        random_offset_y /= distance * 2
        UseParticleFxAssetNextCall(particleDict)
        local fx = StartParticleFxLoopedAtCoord(particleSet, points[i].x + random_offset_x, points[i].y + random_offset_y,
            points[i].z + random_offset_z, 0.0, 0.0, 0.0, scale, false, false, false, false)
        table.insert(insertionTable, fx)
    end
    Wait(500)
    for i = 1, #insertionTable do StopParticleFxLooped(insertionTable[i], 0) end
end
local function quickFadeIn()
    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(1000)
end
local function LoadScaleform(scaleForm, text)
    local scaleform = RequestScaleformMovie(scaleForm)
    while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
    BeginScaleformMovieMethod(scaleform, "SET_PLAYER_NAME")
    PushScaleformMovieMethodParameterString(text)
    EndScaleformMovieMethod()
    return scaleform
end


exports("useItem", useItem)
RegisterNUICallback("invError", function(_, cb)
    errorSound()
    cb("ok")
end)
RegisterNUICallback("invClose", function(_, cb)
    CloseInventory()
    cb("ok")
end)

RegisterNUICallback("sendItem", function(data, cb)
    vSERVER.SendItem(data["slot"], data["amount"])
    cb("ok")
end)

RegisterNUICallback("dropItem", function(Data, Callback)
    if MumbleIsConnected() and not TakeWeapon and not StoreWeapon then
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local _, CoordsZ = GetGroundZFor_3dCoord(Coords["x"], Coords["y"], Coords["z"])

        vSERVER.Drops(Data["item"], Data["slot"], Data["amount"], Coords["x"], Coords["y"], CoordsZ)
    end

    Callback("Ok")
end)

function getGridzone(x, y)
    local gridChunk = vector2(gridChunk(x), gridChunk(y))
    return toChannel(gridChunk)
end

RegisterKeyMapping("moc", "Abrir a mochila", "keyboard", "oem_3")

RegisterNetEvent("inventory:CleanWeapons", function()
    RemoveAllPedWeapons(ply, true)
    useWeapon = ""
    Types = ""
    TriggerEvent("utils:PedWeapons", IsPedArmed(ply, 7), GetSelectedPedWeapon(ply))
end)
RegisterNetEvent("inventory:Close", CloseInventory)

RegisterNetEvent("inventory:Update", function(data)
    local NewInventory, MaxWeight, MaxSlots = vSERVER.requestInventory()
    if not NewInventory then return errorSound() end
    CurrentInventory = NewInventory
    SendNUIMessage({ action = "setPlayerInventory", payload = { inventory = CurrentInventory } })
end)

--TODO: Substituir uso do evento `inventory:Update` para esta função
function Creative.updateInventory(data)
    plyInventory = data
    SendNUIMessage({ action = "setPlayerInventory", payload = { inventory = data } })
end

RegisterNetEvent("inventory:blockButtons", function(status)
    blockButtons = status
    if not blockButtons then return end
    CreateThread(BlockButtons)
end)


RegisterNetEvent("inventory:parachuteColors", function()
    GiveWeaponToPed(ply, "GADGET_PARACHUTE", 1, false, true)
    SetPedParachuteTintIndex(ply, math.random(7))
end)
RegisterNetEvent("inventory:Firecracker", function()
    local mHash = `ind_prop_firework_03`
    LoadNamedPtfxAsset("scr_indep_fireworks")
    LoadModel(mHash)
    local explosives = 25
    local fireCrackerDuration = 300000
    fireTimers = GetGameTimer() + fireCrackerDuration
    local coords = GetOffsetFromEntityInWorldCoords(ply, 0.0, 0.6, 0.0)
    firecracker = CreateObject(mHash, coords["x"], coords["y"], coords["z"], true, true, false)
    local netObjs = ObjToNet(firecracker)
    SetNetworkIdCanMigrate(netObjs, true)
    SetEntityAsMissionEntity(firecracker, true, false)
    PlaceObjectOnGroundProperly(firecracker)
    FreezeEntityPosition(firecracker, true)
    Wait(10000)
    repeat
        UseParticleFxAssetNextCall("scr_indep_fireworks")
        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", coords["x"], coords["y"], coords["z"],
            0.0, 0.0, 0.0, 2.5, false, false, false, false)
        explosives = explosives - 1
        Wait(2000)
    until explosives <= 0
    _TRE("tryDeleteObject", netObjs)
    SetTimeout(fireCrackerDuration, function()
        fireTimers = nil
    end)
end)
RegisterNetEvent("inventory:stealTrunk", function(entity)
    if useWeapon ~= "WEAPON_CROWBAR" then
        return TriggerEvent("Notify", "amarelo", "<b>Pé de Cabra</b> não encontrado.",
            5000)
    end
    if GetVehicleDoorsLockedForPlayer(entity[3], 128) == 1 then return end
    local trunk = GetEntityBoneIndexByName(entity[3], "boot")
    if trunk == -1 then return end
    if GetVehicleDoorAngleRatio(entity[3], 5) > 0.89 then return end
    local coords = GetOffsetFromEntityInWorldCoords(ply, 0.0, 0.5, 0.0)
    local coordsEnt = GetWorldPositionOfEntityBone(entity[3], trunk)
    local distance = #(coords - coordsEnt)
    if distance > 1.9 then return end
    vSERVER._stealTrunk(entity)
end)

RegisterNetEvent("inventory:applyCondom", function()
    local angle = 1.0
    local radius = 0.4
    local lastGameTimer = GetGameTimer()
    local endTimer = lastGameTimer + 60000
    if table.type(scaleForms) == "empty" then
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_11", "~y~PROTEGIDO"),
                angleOffset = 0.0,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_12", "~y~PROTEGIDO "),
                angleOffset = 210.5,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_13", "~b~PROTEGIDO"),
                angleOffset = 105.25,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_14", "~b~PROTEGIDO "),
                angleOffset = -105.25,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
    end
    while GetGameTimer() < endTimer do
        local plyCoords = GetEntityCoords(ply)
        for i = 1, 4 do
            local v = scaleForms[i]
            local coords = vec3(plyCoords.x + radius * math.cos(-angle + v.angleOffset),
                plyCoords.y + radius * math.sin(-angle + v.angleOffset), plyCoords.z)
            local heading = GetHeadingFromVector_2d(plyCoords.x - coords.x, plyCoords.y - coords.y)
            DrawScaleformMovie_3dSolid(v.scaleform, coords.x + v.posOffset.x, coords.y + v.posOffset.y,
                coords.z + v.posOffset.z, v.rot.x, v.rot.y, -heading, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0, 1)
        end
        if (GetGameTimer() - lastGameTimer) > 1 then
            angle = angle + 0.02
            lastGameTimer = GetGameTimer()
        end
        Wait(1)
    end
    for i = 1, 4 do
        SetScaleformMovieAsNoLongerNeeded(scaleForms[i].scaleform)
    end
    scaleForms = {}
end)


AddEventHandler("utils:PedWeapons", function(armed)
    if not armed then return end
    CreateThread(PreventWeapon)
end)

AddEventHandler("utils:GetVehiclePedIsIn", function(veh, isDriver)
    if veh == 0 then return DrawDropList() end
    if not isDriver then return end
    if GetEntityModel(veh) ~= -1178021069 then return end
    while plyIsDriver do
        if not IsEntityPlayingAnim(ply, "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
            vRP.playAnim(true, { "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester" }, true)
        end
        Wait(500)
    end
    vRP.removeObjects("one")
end)
function Creative.dropFunctions()
    local coords = GetEntityCoords(ply)
    local gridZone = getGridzone(coords["x"], coords["y"])
    local _, cdz = GetGroundZFor_3dCoord(coords["x"], coords["y"], coords["z"])
    return coords["x"], coords["y"], cdz, gridZone
end

function Creative.checkFountain()
    local coords = GetEntityCoords(ply)
    if DoesObjectOfTypeExistAtCoords(coords, 0.7, `prop_watercooler`, true) or DoesObjectOfTypeExistAtCoords(coords, 0.7, `prop_watercooler_dark`, true) then
        return true, "fountain"
    end
    if IsEntityInWater(ply) then return true, "floor" end
end

function Creative.fishingAnim() return IsEntityPlayingAnim(ply, "amb@world_human_stand_fishing@idle_a", "idle_c", 3) end

function Creative.checkWeapon()
    return (GetPedParachuteState(ply) == -1 or GetPedParachuteState(ply) == 0) and not IsPedInParachuteFreeFall(ply) and
        not IsPedSwimming(ply) and GetSelectedPedWeapon(ply) ~= WEAPON_UNARMED
end

function Creative.checkAttachs(nameItem, nameWeapon) return weaponAttachs[nameItem][nameWeapon] end

function Creative.putAttachs(nameItem, nameWeapon)
    GiveWeaponComponentToPed(ply, nameWeapon,
        weaponAttachs[nameItem][nameWeapon])
end

function Creative.rechargeWeapon(weaponHash, ammoAmount)
    local Ped = PlayerPedId()
    AddAmmoToPed(Ped, weaponHash, ammoAmount)
end

function Creative.adrenalineDistance()
    local coords = GetEntityCoords(ply)
    for i = 1, #adrenalineCds do
        if #(coords - adrenalineCds[i]) < 5 then return true end
    end
end

function Creative.checkCracker() return fireTimers end

function Creative.checkWater() return IsPedSwimming(ply) end

function Creative.checkRagdoll() return IsPedRagdoll(ply) end

function Creative.wheelChair(vehPlate)
    if plyVeh == 0 then return end
    local heading = GetEntityHeading(ply)
    local coords = GetOffsetFromEntityInWorldCoords(ply, 0.0, 0.75, 0.0)
    local myVehicle = vGARAGE.serverVehicle("wheelchair", coords["x"], coords["y"], coords["z"], heading, vehPlate)
    if not NetworkDoesNetworkIdExist(myVehicle) then return end
    local vehicleNet = NetToEnt(myVehicle)
    if not NetworkDoesNetworkIdExist(vehicleNet) then return end
    SetVehicleOnGroundProperly(vehicleNet)
end

function Creative.tyreHealth(vehNet, Tyre)
    if not NetworkDoesNetworkIdExist(vehNet) then return end
    local Vehicle = NetToEnt(vehNet)
    if not DoesEntityExist(Vehicle) then return end
    return GetTyreHealth(Vehicle, Tyre)
end

function Creative.tyreStatus()
    if plyVeh > 0 then return end
    local Vehicle = vRP.nearVehicle(7)
    local coords = GetEntityCoords(ply)
    for k, Tyre in pairs(tyreList) do
        local Selected = GetEntityBoneIndexByName(Vehicle, k)
        if Selected ~= -1 then
            local coordsWheel = GetWorldPositionOfEntityBone(Vehicle, Selected)
            local distance = #(coords - coordsWheel)
            if distance <= 1.2 then
                return true, Tyre, VehToNet(Vehicle), GetVehicleNumberPlateText(Vehicle)
            end
        end
    end
end

function Creative.checkNearDoor(vehNet)
    if not NetworkDoesEntityExistWithNetworkId(vehNet) then return end
    local veh = NetToVeh(vehNet)
    local doorBone = GetEntityBoneIndexByName(veh, "door_dside_f")
    if doorBone == -1 then return true end
    local doorCds = GetWorldPositionOfEntityBone(veh, doorBone)
    return #(GetEntityCoords(ply) - doorCds) <= 1.5
end

--Inspect

function Creative.openInspect(myInventory, myBackpack, targetInventory, targetBackpack, targetId)
    if not IsNuiFocused() then
        inspecting = true
        SetNuiFocus(true, true)
        SetCursorLocation(0.5, 0.5)
        TriggerScreenblurFadeIn(250.0)
        SendNUIMessage({ action = "showMenu" })
    end
    SendNUIMessage({
        action = "setPlayerInventory",
        payload = {
            inventory = myInventory,
            maxWeight = myBackpack
        }
    })
    SendNUIMessage({
        action = "setOtherInventory",
        payload = {
            title = "Mochila  #" .. targetId,
            inventory = targetInventory,
            maxWeight = targetBackpack,
            slots = 23
        }
    })
end

--HomesChest
function Creative.openHomesChest(homeName, vaultMode, myInventory, myBackpack, homeInventory, homeWeight)
    houseName = homeName
    houseVault = vaultMode
    if not IsNuiFocused() then
        housing = true
        SetNuiFocus(true, true)
        SetCursorLocation(0.5, 0.5)
        TriggerScreenblurFadeIn(250.0)
        SendNUIMessage({ action = "showMenu" })
    end

    SendNUIMessage({
        action = "setPlayerInventory",
        payload = {
            inventory = myInventory,
            maxWeight = myBackpack
        }
    })
    SendNUIMessage({
        action = "setOtherInventory",
        payload = {
            title = "Baú",
            inventory = homeInventory,
            maxWeight = homeWeight,
            slots = 90
        }
    })
end

local function showShortcuts()
    SendNUIMessage({ action = "showHotbar", payload = true })
end
local function hideShortcuts()
    SendNUIMessage({ action = "showHotbar", payload = false })
end
RegisterCommand("+shortcuts", showShortcuts)
RegisterCommand("-shortcuts", hideShortcuts)
RegisterKeyMapping("+shortcuts", "Visualizar atalhos.", "keyboard", "TAB")


RegisterNetEvent('putcondom')
AddEventHandler('putcondom', function()
    local angle = 1.0
    local radius = 0.4
    local lastGameTimer = GetGameTimer()
    local ply = PlayerPedId()
    local endTimer = lastGameTimer + 60000
    if table.type(scaleForms) == "empty" then
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_11", "~y~PROTEGIDO"),
                angleOffset = 0.0,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_12", "~y~PROTEGIDO "),
                angleOffset = 210.5,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_13", "~b~PROTEGIDO"),
                angleOffset = 105.25,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
        table.insert(scaleForms,
            {
                scaleform = LoadScaleform("PLAYER_NAME_14", "~b~PROTEGIDO "),
                angleOffset = -105.25,
                rot = vec2(0.0, 0.0),
                posOffset = vec3(0, 0, 0)
            })
    end
    while GetGameTimer() < endTimer do
        local plyCoords = GetEntityCoords(ply)
        for i = 1, 4 do
            local v = scaleForms[i]
            local coords = vec3(plyCoords.x + radius * math.cos(-angle + v.angleOffset),
                plyCoords.y + radius * math.sin(-angle + v.angleOffset), plyCoords.z)
            local heading = GetHeadingFromVector_2d(plyCoords.x - coords.x, plyCoords.y - coords.y)
            DrawScaleformMovie_3dSolid(v.scaleform, coords.x + v.posOffset.x, coords.y + v.posOffset.y,
                coords.z + v.posOffset.z, v.rot.x, v.rot.y, -heading, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0, 1)
        end
        if (GetGameTimer() - lastGameTimer) > 1 then
            angle = angle + 0.02
            lastGameTimer = GetGameTimer()
        end
        Wait(1)
    end
    for i = 1, 4 do
        SetScaleformMovieAsNoLongerNeeded(scaleForms[i].scaleform)
    end
    scaleForms = {}
end)

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify", function(status)
    SendNUIMessage({
        action = "itemResponse",
        payload = { type = status[1], name = status[2], quantity = status[3], label = status[4], duration = 5 }
    })
end)

RegisterNetEvent("inventory:updateInterfaceAchievements")
AddEventHandler("inventory:updateInterfaceAchievements",function()
    SendNUIMessage({
        action = "updateEnsing",
        payload = {}
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local ATMList = {
	["1"] = { 228.18,338.4,105.56 },
	["2"] = { 158.63,234.22,106.63 },
	["3"] = { -57.67,-92.62,57.78 },
	["4"] = { 356.97,173.54,103.07 },
	["5"] = { -1415.94,-212.03,46.51 },
	["6"] = { -1430.2,-211.08,46.51 },
	["7"] = { -1282.54,-210.9,42.44 },
	["8"] = { -1286.25,-213.44,42.44 },
	["9"] = { -1289.32,-226.82,42.44 },
	["10"] = { -1285.58,-224.28,42.44 },
	["11"] = { -1109.8,-1690.82,4.36 },
	["12"] = { 1686.84,4815.82,42.01 },
	["13"] = { 1701.21,6426.57,32.76 },
	["14"] = { 1822.66,3683.04,34.27 },
	["15"] = { 1171.56,2702.58,38.16 },
	["16"] = { 1172.5,2702.59,38.16 },
	["17"] = { -1091.49,2708.66,18.96 },
	["18"] = { -3144.38,1127.6,20.86 },
	["19"] = { 527.36,-160.69,57.09 },
	["20"] = { 285.45,143.39,104.17 },
	["21"] = { -846.27,-341.28,38.67 },
	["22"] = { -846.85,-340.2,38.67 },
	["23"] = { -721.06,-415.56,34.98 },
	["24"] = { -1410.34,-98.75,52.42 },
	["25"] = { -1409.78,-100.49,52.39 },
	["26"] = { -712.9,-818.92,23.72 },
	["27"] = { -710.05,-818.9,23.72 },
	["28"] = { -660.71,-854.07,24.48 },
	["29"] = { -594.58,-1161.29,22.33 },
	["30"] = { -596.09,-1161.28,22.33 },
	["31"] = { -821.64,-1081.91,11.12 },
	["32"] = { 155.93,6642.86,31.59 },
	["33"] = { 174.14,6637.94,31.58 },
	["34"] = { -283.01,6226.11,31.49 },
	["35"] = { -95.55,6457.19,31.46 },
	["36"] = { -97.3,6455.48,31.46 },
	["37"] = { -132.93,6366.52,31.48 },
	["38"] = { -386.74,6046.08,31.49 },
	["39"] = { 24.47,-945.96,29.35 },
	["40"] = { 5.24,-919.83,29.55 },
	["41"] = { 295.77,-896.1,29.22 },
	["42"] = { 296.47,-894.21,29.23 },
	["43"] = { 1138.22,-468.93,66.73 },
	["44"] = { 1166.97,-456.06,66.79 },
	["45"] = { 1077.75,-776.54,58.23 },
	["46"] = { 289.1,-1256.8,29.44 },
	["47"] = { 288.81,-1282.37,29.64 },
	["48"] = { -1571.05,-547.38,34.95 },
	["49"] = { -1570.12,-546.72,34.95 },
	["50"] = { -1305.4,-706.41,25.33 },
	["51"] = { -2072.36,-317.28,13.31 },
	["52"] = { -2295.48,358.13,174.6 },
	["53"] = { -2294.7,356.46,174.6 },
	["54"] = { -2293.92,354.8,174.6 },
	["55"] = { 2558.75,351.01,108.61 },
	["56"] = { 89.69,2.47,68.29 },
	["57"] = { -866.69,-187.75,37.84 },
	["58"] = { -867.62,-186.09,37.84 },
	["59"] = { -618.22,-708.89,30.04 },
	["60"] = { -618.23,-706.89,30.04 },
	["61"] = { -614.58,-704.83,31.24 },
	["62"] = { -611.93,-704.83,31.24 },
	["63"] = { -537.82,-854.49,29.28 },
	["64"] = { -526.62,-1222.98,18.45 },
	["65"] = { -165.15,232.7,94.91 },
	["66"] = { -165.17,234.78,94.91 },
	["67"] = { -303.25,-829.74,32.42 },
	["68"] = { -301.7,-830.01,32.42 },
	["69"] = { -203.81,-861.37,30.26 },
	["70"] = { 119.06,-883.72,31.12 },
	["71"] = { 112.58,-819.4,31.34 },
	["72"] = { 111.26,-775.25,31.44 },
	["73"] = { 114.43,-776.38,31.41 },
	["74"] = { -256.23,-715.99,33.53 },
	["75"] = { -258.87,-723.38,33.48 },
	["76"] = { -254.42,-692.49,33.6 },
	["77"] = { -28.0,-724.52,44.23 },
	["78"] = { -30.23,-723.69,44.23 },
	["79"] = { -1315.75,-834.69,16.95 },
	["80"] = { -1314.81,-835.96,16.95 },
	["81"] = { -2956.86,487.64,15.47 },
	["82"] = { -2956.89,487.63,15.47 },
	["83"] = { -2958.98,487.73,15.47 },
	["84"] = { -3043.97,594.56,7.73 },
	["85"] = { -3241.17,997.6,12.55 },
	["86"] = { -1205.78,-324.79,37.86 },
	["87"] = { -1205.02,-326.3,37.84 },
	["88"] = { 147.58,-1035.77,29.34 },
	["89"] = { 146.0,-1035.17,29.34 },
	["90"] = { 33.18,-1348.24,29.49 },
	["91"] = { 2558.51,389.48,108.61 },
	["92"] = { 1153.65,-326.78,69.2 },
	["93"] = { -717.71,-915.66,19.21 },
	["94"] = { -56.98,-1752.1,29.42 },
	["95"] = { 380.75,323.39,103.56 },
	["96"] = { -3240.58,1008.59,12.82 },
	["97"] = { 1735.24,6410.52,35.03 },
	["98"] = { 540.31,2671.14,42.16 },
	["99"] = { 1968.07,3743.57,32.33 },
	["100"] = { 2683.1,3286.55,55.23 },
	["101"] = { 1703.0,4933.6,42.06 },
	["102"] = { -1827.3,784.88,138.3 },
	["103"] = { -3040.72,593.11,7.9 },
	["104"] = { 238.32,215.99,106.29 },
	["105"] = { 237.9,216.89,106.29 },
	["106"] = { 237.47,217.81,106.29 },
	["107"] = { 237.04,218.72,106.29 },
	["108"] = { 236.62,219.64,106.29 },
	["109"] = { 126.82,-1296.6,29.27 },
	["110"] = { 127.81,-1296.03,29.27 },
	["111"] = { -248.08,6327.53,32.42 },
	["112"] = { 315.09,-593.68,43.29 },
	["113"] = { 1836.24,3681.04,34.27 },
	["114"] = { -677.36,5834.58,17.32 },
	["115"] = { 472.3,-1001.57,30.68 },
	["116"] = { 468.52,-990.55,26.27 },
	["117"] = { -1431.2,-447.75,35.91 },
	["118"] = { 349.86,-594.51,28.8 },
	["119"] = { -556.12,-205.21,38.22 },
	["120"] = { 560.5,2742.61,42.87 },
	["121"] = { 1099.77,207.12,-49.44 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkAtm(Coords)
	local BombZone = false
	local AtmSelected = false

	for Number,v in pairs(ATMList) do
		local Distance = #(vec3(Coords["x"],Coords["y"],Coords["z"]) - vec3(v[1],v[2],v[3]))
		if Distance <= 1.0 then
			BombZone = vec3(v[1],v[2],v[3] - 1)
			AtmSelected = Number
			break
		end
	end

	return BombZone,AtmSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(ATMList) do
		exports["target"]:AddCircleZone("Atm:"..Number,vec3(v[1],v[2],v[3]),0.5,{
			name = "Atm:"..Number,
			heading = 3374176
		},{
			Distance = 1.0,
			options = {
				{
					event = "Bank",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	end
end)
