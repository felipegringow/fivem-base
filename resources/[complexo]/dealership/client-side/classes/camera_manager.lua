Cam = {}
setmetatable(Cam, { __index = Cam, __call = function(self) return self:__construct() end })

--- Construct the class and starts the camera transition
---@return nil
function Cam:__construct()
    self.vehicleCam = false
    self.playerCam = false

    self:createPlayerHeadCam()
    self:createVehicleCam()
    self:startCamTransition()
    return self
end

--- Destruct the class and reset all variables
---@return nil
function Cam:__destruct()
    self:resetVariables()
    self = nil
end

--- Destroy cams, set them to false and reset the render
---@return nil
function Cam:resetVariables()
    if IsCamActive(self.vehicleCam) then
        RenderScriptCams(false, false, 0, true, true)
        SetCamActive(self.vehicleCam, false)
    end

    if IsCamActive(self.playerCam) then
        RenderScriptCams(false, false, 0, true, true)
        SetCamActive(self.playerCam, false)
    end

    if self.vehicleCam then
        if DoesCamExist(self.vehicleCam) then
            DestroyCam(self.vehicleCam, false)
        end
        self.vehicleCam = false
    end

    if self.playerCam then
        if DoesCamExist(self.playerCam) then
            DestroyCam(self.playerCam, false)
        end
        self.playerCam = false
    end
end

--- Creates the player head cam to transition from
---@return nil
function Cam:createPlayerHeadCam()
    local ply = PlayerPedId()
    local playerCoords = GetEntityCoords(ply)
    local playerRotation = GetEntityRotation(ply, 2)

    self.playerCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(self.playerCam, playerCoords.x, playerCoords.y, playerCoords.z)
    SetCamRot(self.playerCam, playerRotation.x, playerRotation.y, playerRotation.z, 2)
    SetCamFov(self.playerCam, 50.0)
end

--- Creates the vehicle cam to transition to and points it at the vehicle spawn
---@return nil
function Cam:createVehicleCam()
    local camCoord = CONFIG.SHOWROOM_CAMERA_COORDS
    self.vehicleCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(self.vehicleCam, camCoord.x, camCoord.y, camCoord.z)
    SetCamRot(self.vehicleCam, 0.0, 0.0, 0.0, 2)
    SetCamFov(self.vehicleCam, 65.0)
    PointCamAtEntity(self.vehicleCam, Showroom.vehicleEntity, 0.0, 0.0, 0.0, true)
end

--- Starts the camera transition from player head cam to vehicle cam
---@return nil
function Cam:startCamTransition()
    SetCamActive(self.playerCam, true)
    RenderScriptCams(true, false, 0, true, true)
    SetCamActiveWithInterp(self.vehicleCam, self.playerCam, 2500, 1000, 1000)
end
