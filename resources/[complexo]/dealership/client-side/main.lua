local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

cRP = {}
Tunnel.bindInterface(GetCurrentResourceName(), cRP)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterNetEvent("dealership:openSystem", function(stockList)
    SetNUIDisplay(true)
    EmitNuiMessage("DEALERSHIP:UPDATE_VEHICLES", GetVehicleListWithClasses(stockList))
end)

CreateThread(function()
    local innerTable = {}
    for _, v in pairs(CONFIG.SHOWROOM_COORDS) do
        innerTable[#innerTable + 1] = { v.x, v.y, v.z, 3.0, "E", "Concessionária", "Pressione para abrir" }
    end
    TriggerEvent("hoverfy:Insert", innerTable)
end)

CreateThread(function()
    while true do
        local threadDelay = 500
        local ply = PlayerPedId()
        local coords = GetEntityCoords(ply)
        local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
        if coords then
            for k, v in pairs(CONFIG.SHOWROOM_COORDS) do
                local distance = #(coords - v.xyz)
                if distance <= 3.0 then
                    threadDelay = 0
                    if IsControlJustPressed(0, 38) and (not plyVeh or plyVeh == 0) then
                        local VehicleGlobal = VehicleGlobal()
                        local FilteredVehicles = {}
                        for key, vehicle in pairs(VehicleGlobal) do
                            if vehicle["Dealership"] == nil or vehicle["Dealership"] == false then
                                FilteredVehicles[key] = vehicle
                            end
                        end
                        TriggerEvent("dealership:openSystem", FilteredVehicles)
                        vRP._Destroy()
                        -- vRP._createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base", "base",
                        --     "prop_cs_tablet", 50, 28422)
                    end
                end
            end
        end
        Wait(threadDelay)
    end
end)
