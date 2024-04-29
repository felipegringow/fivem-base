-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.openChest()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Vehicle[Passport] then
        local myInfos = {}
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            v["amount"] = parseInt(v["amount"])
            v["name"] = itemName(v["item"])
            v["peso"] = itemWeight(v["item"])
            v["index"] = itemIndex(v["item"])
            v["max"] = itemMaxAmount(v["item"])
            v["economy"] = parseFormat(itemEconomy(v["item"]))
            v["desc"] = itemDescription(v["item"])
            v["key"] = v["item"]
            v["slot"] = k

            local splitName = splitString(v["item"], "-")
            if splitName[2] ~= nil then
                if itemDurability(v["item"]) then
                    v["durability"] = parseInt(os.time() - splitName[2])
                    v["days"] = itemDurability(v["item"])
                else
                    v["durability"] = 0
                    v["days"] = 1
                end
            else
                v["durability"] = 0
                v["days"] = 1
            end

            myInfos[k] = v
        end

        local vehInfos = {}
        local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
        for k, v in pairs(Result) do
            v["amount"] = parseInt(v["amount"])
            v["name"] = itemName(v["item"])
            v["peso"] = itemWeight(v["item"])
            v["index"] = itemIndex(v["item"])
            v["max"] = itemMaxAmount(v["item"])
            v["economy"] = parseFormat(itemEconomy(v["item"]))
            v["desc"] = itemDescription(v["item"])
            v["key"] = v["item"]
            v["slot"] = k

            local splitName = splitString(v["item"], "-")
            if splitName[2] ~= nil then
                if itemDurability(v["item"]) then
                    v["durability"] = parseInt(os.time() - splitName[2])
                    v["days"] = itemDurability(v["item"])
                else
                    v["durability"] = 0
                    v["days"] = 1
                end
            else
                v["durability"] = 0
                v["days"] = 1
            end

            if itemType(splitName[1]) == "Armamento" and splitName[3] then
                if v["desc"] then
                    v["desc"] = v["desc"] ..
                        "<br><description>Nome de registro: <green>" ..
                        vRP.FullName(splitName[3]) .. "</green>.</description>"
                else
                    v["desc"] = "<br><description>Nome de registro: <green>" ..
                        vRP.FullName(splitName[3]) .. "</green>.</description>"
                end
            end

            if splitName[1] == "silverring" then
                if not v["desc"] then
                    v["desc"] = "<br><description>Namorando com: <green>" .. vRP.FullName(splitName[2]) ..
                        "</green>.</description>"
                else
                    v["desc"] = v["desc"] ..
                        "<br><description>Namorando com: <green>" .. vRP.FullName(splitName[2]) ..
                        "</green>.</description>"
                end
            end

            if splitName[1] == "goldring" then
                if not v["desc"] then
                    v["desc"] = "<br><description>Casado com: <green>" .. vRP.FullName(splitName[2]) ..
                        "</green>.</description>"
                else
                    v["desc"] = v["desc"] ..
                        "<br><description>Casado com: <green>" .. vRP.FullName(splitName[2]) ..
                        "</green>.</description>"
                end
            end

            vehInfos[k] = v
        end

        return myInfos, vehInfos, vRP.InventoryWeight(Passport), vRP.GetWeight(Passport), vRP.ChestWeight(Result),
            Vehicle[Passport]["Weight"]
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local storeVehs = {
    ["ratloader"] = {
        ["woodlog"] = true
    },
    ["stockade"] = {
        ["pouch"] = true
    },
    ["trash"] = {
        ["glassbottle"] = true,
        ["plasticbottle"] = true,
        ["elastic"] = true,
        ["metalcan"] = true,
        ["battery"] = true
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.takeTrunkChestItem(Item, Slot, Amount, Target)
    local source = source
    local Amount = parseInt(Amount)
    local Passport = vRP.Passport(source)
    if Passport and Vehicle[Passport] then
        if Amount <= 0 then Amount = 1 end

        if vRP.TakeChest(Passport, Vehicle[Passport]["Data"], Amount, Slot, Target, true) then
            TriggerClientEvent("trunkchest:Update", source, "Request")
        else
            if Vehicle[Passport] then
                local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
                TriggerClientEvent("trunkchest:UpdateWeight", source, vRP.InventoryWeight(Passport),
                    vRP.GetWeight(Passport), vRP.ChestWeight(Result), Vehicle[Passport]["Weight"])
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.storeTrunkChestItem(Item, Slot, Amount, Target)
    local source = source
    local Amount = parseInt(Amount)
    local Passport = vRP.Passport(source)
    if Passport and Vehicle[Passport] then
        if Amount <= 0 then Amount = 1 end

        local vehName = Vehicle[Passport]["Model"]

        if vRP.StoreChest(Passport, Vehicle[Passport]["Data"], Amount, Vehicle[Passport]["Weight"], Slot, Target) then
            TriggerClientEvent("trunkchest:Update", source, "Request")
        else
            if Vehicle[Passport] then
                local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
                TriggerClientEvent("trunkchest:UpdateWeight", source, vRP.InventoryWeight(Passport),
                    vRP.GetWeight(Passport), vRP.ChestWeight(Result), Vehicle[Passport]["Weight"])
            end
        end
    end
    ::scapeInventory::
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Slot, Amount, Target)
    local source = source
    local Amount = parseInt(Amount)
    local Passport = vRP.Passport(source)
    if Passport and Vehicle[Passport] then
        if Amount <= 0 then Amount = 1 end

        if vRP.TakeChest(Passport, Vehicle[Passport]["Data"], Amount, Slot, Target) then
            exports['logs']:customLogs("trunckchest", {
                Passport = Passport,
                title = 'Limpou o Inventario',
                fields = {
                    { name = "Jogador",    value = Passport,                  inline = false },
                    { name = "Item",       value = Vehicle[Passport]["Data"], inline = false },
                    { name = "Quantidade", value = Amount,                    inline = false },
                },
                coords = false,
                identity = true
            })
            TriggerClientEvent("trunkchest:Update", source, "Request")
        else
            if Vehicle[Passport] then
                local Result = vRP.GetSrvData(Vehicle[Passport]["Data"])
                TriggerClientEvent("trunkchest:UpdateWeight", source, vRP.InventoryWeight(Passport),
                    vRP.GetWeight(Passport), vRP.ChestWeight(Result), Vehicle[Passport]["Weight"])
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.trunkChestClose()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Vehicle[Passport] then
        TriggerClientEvent("player:VehicleDoors", source, Vehicle[Passport]["Net"], "close")
        Vehicle[Passport] = nil
        vRPC.stopAnim(source)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk", function(Entity)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if VehicleChest(Entity[2]) > 0 then
            local PassportPlate = vRP.PassportPlate(Entity[1])
            if PassportPlate then
                Vehicle[Passport] = {
                    ["Net"] = Entity[4],
                    ["Plate"] = Entity[1],
                    ["Model"] = Entity[2],
                    ["User"] = PassportPlate["Passport"],
                    ["Weight"] = VehicleChest(Entity[2]),
                    ["Data"] = "Chest:" .. PassportPlate["Passport"] .. ":" .. Entity[2]
                }

                local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])
                if GetVehicleDoorLockStatus(Network) <= 1 then
                    TriggerClientEvent("trunkchest:Open", source)
                    TriggerClientEvent("player:VehicleDoors", source, Vehicle[Passport]["Net"], "open")
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Veículo trancado.", "Aviso", 5000)
                    Vehicle[Passport] = nil
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:FORCETRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:forceTrunk")
AddEventHandler("trunkchest:forceTrunk", function(Entity)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if VehicleChest(Entity[2]) > 0 then
            local PassportPlate = vRP.PassportPlate(Entity[1])
            if PassportPlate then
                if not vINVENTORY.checkWeapon(source, "WEAPON_CROWBAR") then
                    TriggerClientEvent("Notify", source, "amarelo",
                        "Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção",
                        5000)
                    return
                end

                Vehicle[Passport] = {
                    ["Net"] = Entity[4],
                    ["Plate"] = Entity[1],
                    ["Model"] = Entity[2],
                    ["User"] = PassportPlate["Passport"],
                    ["Weight"] = VehicleChest(Entity[2]),
                    ["Data"] = "Chest:" .. PassportPlate["Passport"] .. ":" .. Entity[2]
                }

                local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])
                if GetVehicleDoorLockStatus(Network) == 2 then
                    vRPC.playAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)

                    if vTASKBAR.Task(source, 10, 10000) then
                        TriggerClientEvent("trunkchest:Open", source)
                        TriggerClientEvent("player:VehicleDoors", source, Vehicle[Passport]["Net"], "open")
                    else
                        vRPC.stopAnim(source, false)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
    if Vehicle[Passport] then
        Vehicle[Passport] = nil
    end
end)
