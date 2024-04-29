--- Changes the visibility of the dealership menu.
---@param status boolean
---@return nil
function SetNUIDisplay(status)
    EmitNuiMessage("DEALERSHIP:SET_VISIBLE", status)
    SetNuiFocus(status, status)

    if status then
        Showroom:changeVehicleOnDisplay("adder")
        Cam:__construct()
        TriggerEvent("hud:active", false)
    else
        Showroom:__destruct()
        Cam:__destruct()
        vRP.removeObjects()
        TriggerEvent("hud:active", true)
    end
end

--- Closes the dealership menu.
---@return nil
RegisterNUICallback("DEALERSHIP:CLOSE", function(_, cb)
    SetNUIDisplay(false)
    cb("ok")
end)

--- Change the vehicle on display.
---@return nil
RegisterNUICallback("DEALERSHIP:CHANGEVEHICLE", function(data, cb)
    if type(data) ~= "string" then return end
    Showroom:changeVehicleOnDisplay(data)
    cb("ok")
end)

--- Init the test drive.
---@return nil
RegisterNUICallback("DEALERSHIP:TESTDRIVE", function(data, cb)
    if type(data) ~= "string" then return end
    Showroom:initTestDrive(data)
    cb(false)
end)

--- Rotate the vehicle on display.
---@return nil
RegisterNUICallback("DEALERSHIP:ROTATEVEHICLE", function(data, cb)
    if type(data) ~= "boolean" then return end
    Showroom:rotateVehicle(data)
    cb("ok")
end)

--- Buy the vehicle on display.
RegisterNUICallback("DEALERSHIP:BUY", function(data, cb)
    if type(data) ~= "string" then return end
    SetNUIDisplay(false)
    Showroom:buyVehicle(data)
    cb("ok")
end)

--- Select the color of the vehicle on display.
RegisterNUICallback("DEALERSHIP:SELECTCOLOR", function(data, cb)
    if type(data) ~= "number" then return end
    Showroom:updateVehicleColor(data)
    cb("ok")
end)

--- Emit a message to the NUI.
---@param type string
---@param payload table
---@return nil
function EmitNuiMessage(type, payload)
    SendNUIMessage({
        type = type,
        payload = payload and { payload } or {}
    })
end
