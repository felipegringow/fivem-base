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
Tunnel.bindInterface("dynamic", cRP)
vSERVER = Tunnel.getInterface("dynamic")

function _RNE(event, ...)
	RegisterNetEvent(event)
	AddEventHandler(event, ...)

	print(event)
end

function _TRE(event, ...)
	TriggerEvent(event, ...)

	print(event)
end

local isDisplayingMenu = false

local policeService = false
local paramedicService = false

local animalHahs
local animalFollow = false

local function getMenuItems(menuItems)
	if not menuItems then return end
	local ply = PlayerPedId()

	local availableItems = {}

	for _, menuItem in ipairs(menuItems) do
		if not menuItem.enableMenu or menuItem.enableMenu(ply) then
			availableItems[#availableItems + 1] = {
				id = menuItem.id,
				title = menuItem.title,
				icon = menuItem.icon,
				items = getMenuItems(menuItem.items),
			}
		end
	end

	return availableItems
end

local function getAvailableMenus()
	local availableMenus = {}
	local ply = PlayerPedId()

	for _, menuOption in ipairs(MenuOptions) do
		if not menuOption.enableMenu or menuOption.enableMenu(ply) then
			local menuItems = getMenuItems(menuOption.items)

			availableMenus[#availableMenus + 1] = {
				id = menuOption.id,
				title = menuOption.title,
				icon = menuOption.icon,
				items = menuItems,
			}
		end
	end

	return availableMenus
end

local function isNight()
	local hours = GetClockHours()

	return hours > 19 or hours < 6
end



local function openRadialMenu()
	local ply = PlayerPedId()

    if isDisplayingMenu then return end

    --[[ if exports["player"]:blockCommands() or exports["player"]:handCuff() or GetEntityHealth(ply) <= 101 then return end
 ]]
    isDisplayingMenu = true

	local availableMenus = getAvailableMenus()

    SendNUIMessage({
        state = "show",
        data = availableMenus,
		isNight = isNight()
    })

    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)

	CreateThread(function()
		while isDisplayingMenu do
			DisableControlAction(0, 1, true) -- INPUT_LOOK_LR
			DisableControlAction(0, 2, true) -- INPUT_LOOK_UD
			DisableControlAction(0, 24, true) -- INPUT_ATTACK
			DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
			DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
			DisableControlAction(0, 257, true) -- INPUT_ATTACK2
			DisableControlAction(0, 346, true) -- INPUT_VEH_MELEE_LEFT
			
			Wait(0)
		end
	end)
end

local function closeRadialMenu()
    if not isDisplayingMenu then return end

    isDisplayingMenu = false

    SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
    SendNUIMessage({ state = 'destroy' })
end

local function addOptionToMenu(option)
    if not option.id or not option.title then return end

    MenuOptions[#MenuOptions + 1] = option
end

local function findMenuItemById(items, id)
    for _, menuItem in ipairs(items) do
        if menuItem.id == id then
            return menuItem
        end
        if menuItem.items then
            local foundItem = findMenuItemById(menuItem.items, id)
            if foundItem then
                return foundItem
            end
        end
    end
end

function HasAnimal()
    return animalHahs
end

function IsPolice()
    return policeService
end

function IsParamedic()
    return paramedicService
end

RegisterKeyMapping("+radial_menu", "Abrir menu radial.", "keyboard", "F1")

RegisterCommand("+radial_menu", openRadialMenu, false)
RegisterCommand("-radial_menu", closeRadialMenu, false)

exports("AddOption", addOptionToMenu)

RegisterNUICallback("triggerAction", function(data, cb)
    cb("ok")

    local menuOption = findMenuItemById(MenuOptions, data.id)
    if not menuOption then return end

    if menuOption.server then
        _TRE(menuOption.trigger, menuOption.triggerArgs and table.unpack(menuOption.triggerArgs) or nil)
    else
        TriggerEvent(menuOption.trigger, menuOption.triggerArgs and table.unpack(menuOption.triggerArgs) or nil)
    end
end)

RegisterNUICallback("close", function(data, cb)
    closeRadialMenu()

	cb("ok")
end)

_RNE("police:updateService",function(status)
	policeService = status
end)

_RNE("paramedic:updateService",function(status)
	paramedicService = status
end)

_RNE("dynamic:animalSpawn",function(model)
	if animalHahs == nil then
		local ped = PlayerPedId()
		local mHash = GetHashKey(model)

		RequestModel(mHash)
		while not HasModelLoaded(mHash) do
			Wait(1)
		end

		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,0.0)
		animalHahs = CreatePed(28,mHash,coords["x"],coords["y"],coords["z"] - 1,GetEntityHeading(ped),true,false)
		local netPeds = PedToNet(animalHahs)

		SetNetworkIdCanMigrate(netPeds,true)

		SetPedCanRagdoll(animalHahs,false)
		SetEntityInvincible(animalHahs,true)
		SetPedFleeAttributes(animalHahs,0,0)
		SetEntityAsMissionEntity(animalHahs,true,false)
		SetBlockingOfNonTemporaryEvents(animalHahs,true)
		SetPedRelationshipGroupHash(animalHahs,GetHashKey("k9"))
		GiveWeaponToPed(animalHahs,GetHashKey("WEAPON_ANIMAL"),200,true,true)

		SetModelAsNoLongerNeeded(mHash)

		TriggerEvent("dynamic:animalFunctions","seguir")

		vSERVER._animalRegister(PedToNet(animalHahs))
	else
		vSERVER._animalCleaner()
		animalFollow = false
		animalHahs = nil
	end
end)

_RNE("dynamic:animalFunctions",function(functions)
	if animalHahs ~= nil then
		local ped = PlayerPedId()

		if functions == "seguir" then
			if not animalFollow then
				TaskFollowToOffsetOfEntity(animalHahs,ped,1.0,1.0,0.0,5.0,-1,2.5,1)
				SetPedKeepTask(animalHahs,true)
				animalFollow = true
			else
				SetPedKeepTask(animalHahs,false)
				ClearPedTasks(animalHahs)
				animalFollow = false
			end
		elseif functions == "colocar" then
			if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
				local vehicle = GetVehiclePedIsUsing(ped)
				if IsVehicleSeatFree(vehicle,0) then
					TaskEnterVehicle(animalHahs,vehicle,-1,0,2.0,16,0)
				end
			end
		elseif functions == "remover" then
			if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
				TaskLeaveVehicle(animalHahs,GetVehiclePedIsUsing(ped),256)
				TriggerEvent("dynamic:animalFunctions","seguir")
			end
		elseif functions == "deletar" then
			vSERVER._animalCleaner()
			animalFollow = false
			animalHahs = nil
		end
	end
end)