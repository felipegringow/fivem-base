local _internal_pos = nil
local _internal_rot = nil
local _internal_vecX = nil
local _internal_vecY = nil
local _internal_vecZ = nil
local _internal_camera = nil

function GetInitialCameraPosition()
	if _G.CAMERA_SETTINGS.KEEP_POSITION and _internal_pos then
		return _internal_pos
	end

	return GetGameplayCamCoord()
end

function GetInitialCameraRotation()
	if _G.CAMERA_SETTINGS.KEEP_ROTATION and _internal_rot then
		return _internal_rot
	end

	local rot = GetGameplayCamRot()
	return vector3(rot.x,0.0,rot.z)
end

function GetFreecamPosition()
	return _internal_pos
end

function SetFreecamPosition(x,y,z)
	local pos = vector3(x,y,z)
	local int = GetInteriorAtCoords(pos)

	LoadInterior(int)
	SetFocusArea(pos)
	LockMinimapPosition(x,y)
	SetCamCoord(_internal_camera,pos)

	_internal_pos = pos
end

function GetFreecamRotation()
	return _internal_rot
end

function SetFreecamRotation(x,y,z)
	local rotX,rotY,rotZ = ClampCameraRotation(x,y,z)
	local vecX,vecY,vecZ = EulerToMatrix(rotX,rotY,rotZ)
	local rot = vector3(rotX,rotY,rotZ)

	LockMinimapAngle(math.floor(rotZ))
	SetCamRot(_internal_camera,rot)

	_internal_rot  = rot
	_internal_vecX = vecX
	_internal_vecY = vecY
	_internal_vecZ = vecZ
end

function SetFreecamFov(fov)
	local fov = Clamp(fov,0.0,90.0)
	SetCamFov(_internal_camera,fov)
end

function GetFreecamMatrix()
	return _internal_vecX,_internal_vecY,_internal_vecZ,_internal_pos
end

function IsFreecamActive()
	return IsCamActive(_internal_camera) == 1
end

function SetFreecamActive(active)
	if active == IsFreecamActive() then
		return
	end

	local enableEasing = _G.CAMERA_SETTINGS.ENABLE_EASING
	local easingDuration = _G.CAMERA_SETTINGS.EASING_DURATION

	if active then
		local pos = GetInitialCameraPosition()
		local rot = GetInitialCameraRotation()

		_internal_camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)

		SetFreecamFov(_G.CAMERA_SETTINGS.FOV)
		SetFreecamPosition(pos.x,pos.y,pos.z)
		SetFreecamRotation(rot.x,rot.y,rot.z)
	else
		DestroyCam(_internal_camera)
		ClearFocus()
		UnlockMinimapPosition()
		UnlockMinimapAngle()
	end

	LocalPlayer["state"]["Freecam"] = active

	SetPlayerControl(PlayerId(),not active)
	RenderScriptCams(active,enableEasing,easingDuration)
end

local SETTINGS = _G.CONTROL_SETTINGS
local CONTROLS = _G.CONTROL_MAPPING

local function GetSpeedMultiplier()
	local fastNormal = GetSmartControlNormal(CONTROLS.MOVE_FAST)
	local slowNormal = GetSmartControlNormal(CONTROLS.MOVE_SLOW)

	local baseSpeed = SETTINGS.BASE_MOVE_MULTIPLIER
	local fastSpeed = 1 + ((SETTINGS.FAST_MOVE_MULTIPLIER - 1) * fastNormal)
	local slowSpeed = 1 + ((SETTINGS.SLOW_MOVE_MULTIPLIER - 1) * slowNormal)

	local frameMultiplier = GetFrameTime() * 60
	local speedMultiplier = baseSpeed * fastSpeed / slowSpeed

	return speedMultiplier * frameMultiplier
end

function UpdateCamera()
	local vecX,vecY = GetFreecamMatrix()
	local vecZ = vector3(0,0,1)

	local pos = GetFreecamPosition()
	local rot = GetFreecamRotation()

	local speedMultiplier = GetSpeedMultiplier()

	local lookX = GetSmartControlNormal(CONTROLS.LOOK_X)
	local lookY = GetSmartControlNormal(CONTROLS.LOOK_Y)

	local moveX = GetSmartControlNormal(CONTROLS.MOVE_X)
	local moveY = GetSmartControlNormal(CONTROLS.MOVE_Y)
	local moveZ = GetSmartControlNormal(CONTROLS.MOVE_Z)

	local rotX = rot.x + (-lookY * SETTINGS.LOOK_SENSITIVITY_X)
	local rotZ = rot.z + (-lookX * SETTINGS.LOOK_SENSITIVITY_Y)
	local rotY = rot.y

	pos = pos + (vecX *  moveX * speedMultiplier)
	pos = pos + (vecY * -moveY * speedMultiplier)
	pos = pos + (vecZ *  moveZ * speedMultiplier)

	rot = vector3(rotX,rotY,rotZ)

	SetFreecamPosition(pos.x,pos.y,pos.z)
	SetFreecamRotation(rot.x,rot.y,rot.z)

	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if #(Coords - vec3(pos.x,pos.y,pos.z)) >= 10 then
		SetFreecamActive(false)
	end
end

RegisterNetEvent("freecam:Active")
AddEventHandler("freecam:Active",function()
	SetFreecamActive(not IsFreecamActive())
end)

Citizen.CreateThread(function ()
	while true do
		local TimeDistance = 999
		if IsFreecamActive() and not IsPauseMenuActive() then
			TimeDistance = 0
			UpdateCamera()
		end

		Wait(TimeDistance)
	end
end)

AddEventHandler("onResourceStop",function(Resource)
	if Resource == GetCurrentResourceName() then
		SetFreecamActive(false)
	end
end)