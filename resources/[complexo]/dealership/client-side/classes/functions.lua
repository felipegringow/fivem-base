--- Returns a table containing all the vehicles that can be bought.

function mathLegth(n)
    return math.ceil(n * 100) / 100
end

---@param stockList table
---@return table
function GetVehicleListWithClasses(stockList)
    local vehiclesList = VehicleGlobal()

    local vehiclesToTablet = {}

    for k, v in pairs(vehiclesList) do
        local hashName = GetHashKey(k)
        local vehicleClass = GetVehicleClassFromName(hashName)
        local vehPrice = parseInt(v.Price)
        local className = v.Class
        if not className then
            className = "Utilitários"
        end
        if v["Mode"] == "work" then
            className = "Serviços"
        elseif v["Mode"] == "rental" or v["Mode"] == "Rental" then
            className = "VIP"
            vehPrice = parseInt(v.Gemstone)
        end

        vehiclesToTablet[#vehiclesToTablet + 1] = {
            model = k,
            name = v[1],
            chest = parseInt(v[2]),
            type = v[4],
            price = vehPrice,
            testDrivePrice = 500,
            tax = (vehPrice / 100) * 5,
            category = className,
            quantity = 100,
            tier = v[6] or nil,
        }
    end

    return vehiclesToTablet
end

--- Returns the stock amount of a vehicle.
---@param stockList table
---@param vehicleName string
---@return number
function GetVehicleStock(stockList, vehicleName)
    if not vehicleName then return false end
    local vehStock = vehicleStock(vehicleName)
    if parseInt(vehStock) <= 0 then return 99 end
    if stockList[vehicleName] then
        return stockList[vehicleName]
    end
    return parseInt(vehStock)
end
