-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("initial",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEINITIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.VehicleInitial(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

            vRP.Query("vehicles/temporaryVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false", temporary = "true" })
            TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(vehName).."</b> concluído.",5000)
			Active[Passport] = nil
		end
	end
end

vRP.Prepare("vehicles/temporaryVehicles", "INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax,temporary) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 259200,UNIX_TIMESTAMP() + 604800,@temporary)")
