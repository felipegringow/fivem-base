Showroom = {}
setmetatable(Showroom, { __index = Showroom })

CreateThread(function()
    Showroom:__construct()
end)

function mathLegth(n)
    return math.ceil(n * 100) / 100
end

--- Construct the exhibition vehicle entity
---@return table
function Showroom:__construct()
    self.vehicleEntity = false
    self.vehiclesCreated = {}
    self.vehicleModel = false
    self.lastModelLoaded = false
    self.isLoadingModel = false
    self.vehicleColor = 0
    self.isInTestDrive = false
    self.testDriveInitAt = 0
    return self
end

--- Destruct the exhibition vehicle entity
---@return nil
function Showroom:__destruct()
    self:deleteVehicleOnDisplay()
    self = nil
end

--- Change the vehicle on display
---@param vehicleModel number
---@return nil
function Showroom:changeVehicleOnDisplay(vehicleModel)
    if not IsNuiFocused() then return end
    if self.isLoadingModel then return end
    if (self.lastModelLoaded and self.lastModelLoaded == vehicleModel) then return end
    self:deleteVehicleOnDisplay()

    if not vehicleModel then return end
    self.vehicleModel = vehicleModel
    self.lastModelLoaded = vehicleModel
    self.isLoadingModel = true
    LoadModel(self.vehicleModel)
    self.isLoadingModel = false

    local vehicleSpawnCoord = CONFIG.SHOWROOM_VEHICLE_SPAWN_COORDS
    self.vehicleEntity = CreateVehicle(self.vehicleModel, vehicleSpawnCoord.x, vehicleSpawnCoord.y, vehicleSpawnCoord.z,
        vehicleSpawnCoord.w, false, false)
    self.vehiclesCreated[#self.vehiclesCreated + 1] = self.vehicleEntity
    while not DoesEntityExist(self.vehicleEntity) do Wait(10) end

    self:setupVehicleOnDisplay()
    self:updateVehicleColor(0)
    self:updateVehicleUIStats()
    SetModelAsNoLongerNeeded(self.vehicleModel)
end

--- Setup all stuff to the vehicle on display
---@return nil
function Showroom:setupVehicleOnDisplay()
    if not self.vehicleEntity then return end
    if not DoesEntityExist(self.vehicleEntity) then return end

    FreezeEntityPosition(self.vehicleEntity, true)
    SetEntityInvincible(self.vehicleEntity, true)
    SetVehicleDoorsLocked(self.vehicleEntity, 4)
    SetVehicleOnGroundProperly(self.vehicleEntity)
    SetVehicleNumberPlateText(self.vehicleEntity, "COMPLEXO")
    SetVehicleEngineOn(self.vehicleEntity, true, true, false)
    SetVehicleLights(self.vehicleEntity, 2)
    SetVehicleLightsMode(self.vehicleEntity, 2)
    SetVehicleFullbeam(self.vehicleEntity, true)
end

--- Rotates the vehicle on display
---@param status boolean
---@return nil
function Showroom:rotateVehicle(status)
    if not self.vehicleEntity then return end
    if not DoesEntityExist(self.vehicleEntity) then return end
    local vehicleHeading = GetEntityHeading(self.vehicleEntity)
    SetEntityHeading(self.vehicleEntity,
        vehicleHeading + (status and CONFIG.SHOWROOM_ROTATE_VEHICLE_RATIO or -CONFIG.SHOWROOM_ROTATE_VEHICLE_RATIO))
end

--- Delete the vehicle on display
---@return nil
function Showroom:deleteVehicleOnDisplay()
    if self.vehicleEntity then
        if DoesEntityExist(self.vehicleEntity) then
            DeleteEntity(self.vehicleEntity)
        end
        self.vehicleEntity = false
    end

    for k, v in pairs(self.vehiclesCreated) do
        DeleteEntity(v)
        self.vehiclesCreated[k] = nil
    end
end

--- Change the vehicle color
---@param colorIndex number
---@return nil
function Showroom:updateVehicleColor(colorIndex)
    if not CONFIG.VEHICLE_CUSTOM_COLORS[colorIndex] then return end
    if not self.vehicleEntity then return end
    if not DoesEntityExist(self.vehicleEntity) then return end
    self.vehicleColor = colorIndex
    local r, g, b = table.unpack(CONFIG.VEHICLE_CUSTOM_COLORS[colorIndex])
    SetVehicleCustomPrimaryColour(self.vehicleEntity, r, g, b)
    SetVehicleCustomSecondaryColour(self.vehicleEntity, r, g, b)
end

--- Buy the vehicle on display
---@param vehicleName string
---@return nil
function Showroom:buyVehicle(vehicleName)
    print('buyVehicle', vehicleName)
    if not vehicleName then return end
    -- local vehicleData = vRP.getVehicleData(self.vehicleEntity) or {}
    -- vSERVER.Buy(vehicleName, vehicleData, self.vehicleColor)
    vSERVER.Buy(vehicleName)
end

--- Get all vehicle stats to send to UI
---@return nil
function Showroom:updateVehicleUIStats()
    if not self.vehicleEntity then return end
    if not DoesEntityExist(self.vehicleEntity) then return end

    local maxSpeed = GetVehicleEstimatedMaxSpeed(self.vehicleEntity) * 3.95
    local maxBraking = GetVehicleMaxBraking(self.vehicleEntity) * 100
    local maxTraction = GetVehicleMaxTraction(self.vehicleEntity)
    local maxPassengers = GetVehicleMaxNumberOfPassengers(self.vehicleEntity) + 1

    local vehicleData = {
        {
            label = "Velocidade máxima",
            text = math.floor(maxSpeed),
            percentage = math.floor((100 * maxSpeed) / 300),
            text2 = "km/h"
        },
        {
            label = "Frenagem",
            text = math.floor(maxBraking),
            percentage = math.floor((100 * maxBraking) / 500),
            text2 = "N"
        },
        {
            label = "Tração",
            text = mathLegth(maxTraction),
            percentage = math.floor((100 * mathLegth(maxTraction)) / 50),
            text2 = "Kgf"
        },
        {
            label = "Capacidade de passageiros",
            text = math.floor(maxPassengers),
            percentage = math.floor((100 * maxPassengers) / 20),
            text2 = maxPassengers == 1 and "pessoa" or "pessoas"
        },
    }

    -- Special case
    local vehTrunk = VehicleChest(self.vehicleModel)
    vehicleData[#vehicleData + 1] = {
        label = "Capacidade do porta-malas",
        text = vehTrunk,
        percentage = math.floor((100 * vehTrunk) / 1000),
        text2 = "kg"
    }

    EmitNuiMessage("DEALERSHIP:SET_STATS", vehicleData)
end

--- Start the test drive
---@param vehModel number
---@return nil
function Showroom:initTestDrive(vehModel)
    if not self.vehicleEntity then return end
    if not DoesEntityExist(self.vehicleEntity) then return end
    self:deleteVehicleOnDisplay()

    SetNUIDisplay(false)

    self:startTestDriveThread(vehModel)
end

--- Start the test drive thread
---@return nil
function Showroom:startTestDriveThread(Data)
    self.isInTestDrive = true
    self.testDriveInitAt = GetNetworkTime()
    if vSERVER.CheckDrive() then
        SetNuiFocus(false, false)
        SetCursorLocation(0.5, 0.5)

        if LoadModel(Data) then
            if DoesEntityExist(Mount) then
                DeleteEntity(Mount)
            end

            Mount = CreateVehicle(Data, -53.28, -1110.93, 26.47, 68.04, false, false)
            SetVehicleBodyHealth(Mount, 1000.0)
            SetVehicleEngineHealth(Mount, 1000.0)
            SetVehiclePetrolTankHealth(Mount, 1000.0)
            SetVehicleFuelLevel(Mount, 100.0)
            SetEntityInvincible(Mount, true)
            SetPedIntoVehicle(Ped, Mount, -1)
            SetVehicleModKit(Mount, 0)
            SetVehicleMod(Mount, 0, GetNumVehicleMods(Mount, 0) - 1, false)
            SetVehicleMod(Mount, 1, GetNumVehicleMods(Mount, 1) - 1, false)
            SetVehicleMod(Mount, 2, GetNumVehicleMods(Mount, 2) - 1, false)
            SetVehicleMod(Mount, 3, GetNumVehicleMods(Mount, 3) - 1, false)
            SetVehicleMod(Mount, 4, GetNumVehicleMods(Mount, 4) - 1, false)
            SetVehicleMod(Mount, 5, GetNumVehicleMods(Mount, 5) - 1, false)
            SetVehicleMod(Mount, 6, GetNumVehicleMods(Mount, 6) - 1, false)
            SetVehicleMod(Mount, 7, GetNumVehicleMods(Mount, 7) - 1, false)
            SetVehicleMod(Mount, 8, GetNumVehicleMods(Mount, 8) - 1, false)
            SetVehicleMod(Mount, 9, GetNumVehicleMods(Mount, 9) - 1, false)
            SetVehicleMod(Mount, 10, GetNumVehicleMods(Mount, 10) - 1, false)
            SetVehicleMod(Mount, 11, GetNumVehicleMods(Mount, 11) - 1, false)
            SetVehicleMod(Mount, 12, GetNumVehicleMods(Mount, 12) - 1, false)
            SetVehicleMod(Mount, 13, GetNumVehicleMods(Mount, 13) - 1, false)
            SetVehicleMod(Mount, 14, 16, false)
            SetVehicleMod(Mount, 15, GetNumVehicleMods(Mount, 15) - 2, false)
            SetVehicleMod(Mount, 16, GetNumVehicleMods(Mount, 16) - 1, false)
            ToggleVehicleMod(Mount, 17, true)
            ToggleVehicleMod(Mount, 18, true)
            ToggleVehicleMod(Mount, 19, true)
            ToggleVehicleMod(Mount, 20, true)
            ToggleVehicleMod(Mount, 21, true)
            ToggleVehicleMod(Mount, 22, true)
            SetVehicleMod(Mount, 25, GetNumVehicleMods(Mount, 25) - 1, false)
            SetVehicleMod(Mount, 27, GetNumVehicleMods(Mount, 27) - 1, false)
            SetVehicleMod(Mount, 28, GetNumVehicleMods(Mount, 28) - 1, false)
            SetVehicleMod(Mount, 30, GetNumVehicleMods(Mount, 30) - 1, false)
            SetVehicleMod(Mount, 33, GetNumVehicleMods(Mount, 33) - 1, false)
            SetVehicleMod(Mount, 34, GetNumVehicleMods(Mount, 34) - 1, false)
            SetVehicleMod(Mount, 35, GetNumVehicleMods(Mount, 35) - 1, false)
            SetVehicleMod(Mount, 38, GetNumVehicleMods(Mount, 38) - 1, true)
            SetVehicleTyreSmokeColor(Mount, 155, 0, 0)
            SetVehicleWindowTint(Mount, 1)
            SetVehicleTyresCanBurst(Mount, false)
            SetVehicleNumberPlateTextIndex(Mount, 5)
            SetVehicleModColor_1(Mount, 155, 0, 0)
            SetVehicleModColor_2(Mount, 135, 135)
            SetVehicleColours(Mount, 1, 0)
            SetVehicleExtraColours(Mount, 1, 0)
            SetVehicleNeonLightEnabled(Mount, 0, true)
            SetVehicleNeonLightEnabled(Mount, 1, true)
            SetVehicleNeonLightEnabled(Mount, 2, true)
            SetVehicleNeonLightEnabled(Mount, 3, true)
            SetVehicleNeonLightsColour(Mount, 155, 0, 0)
            SetVehicleNumberPlateText(Mount, "COMPLEXO")
            SetPedIntoVehicle(PlayerPedId(), Mount, -1)
            SetEntityInvincible(Mount, true)
            SetModelAsNoLongerNeeded(Data)
            LocalPlayer["state"]:set("Commands", true, true)
            LocalPlayer["state"]:set("TestDrive", true, false)

            while true do
                local Ped = PlayerPedId()
                if not IsPedInAnyVehicle(Ped) then
                    vSERVER.RemoveDrive()
                    SetEntityCoords(Ped, -33.59, -1097.16, 27.26)
                    LocalPlayer["state"]:set("Commands", false, true)
                    LocalPlayer["state"]:set("TestDrive", false, false)

                    if DoesEntityExist(Mount) then
                        DeleteEntity(Mount)

                        break
                    end
                end

                Wait(1)
            end
        end
    end
end
