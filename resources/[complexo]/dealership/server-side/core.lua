-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("dealership", Creative)
vCLIENT = Tunnel.getInterface("dealership")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true
			if VehicleMode(Name) == "Rental" or not VehicleMode(Name) then
				Active[Passport] = nil
				local VehiclePrice = VehicleGemstone(Name)
				local Text = "Alugar o veículo <b>" ..
					VehicleName(Name) .. "</b> por <b>" .. VehiclePrice .. "</b> Gemas?"
				if vRP.ConsultItem(Passport, "rentalveh", 1) then
					Text = "Alugar o veículo <b>" .. VehicleName(Name) .. "</b> usando o vale?"
				end
				if vRP.Request(source, Text, '') then
					if vRP.TakeItem(Passport, "rentalveh", 1, true) or vRP.PaymentGems(Passport, VehiclePrice) then
						local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
						if vehicle[1] then
							if vehicle[1]["rental"] <= os.time() then
								vRP._Query("vehicles/rentalVehiclesUpdate", { Passport = Passport, vehicle = Name })
								TriggerClientEvent("Notify", source, "verde",
									"Compra do veículo <b>" .. VehicleName(Name) .. "</b> atualizado.", "Sucesso", 5000)
							else
								exports['logs']:customLogs('dealershipvip', {
									Passport = Passport,
									fields = {
										{ ['name'] = 'Passaporte', ['value'] = Passport },
										{ ['name'] = 'Carro',      ['value'] = Name },
										{ ['name'] = 'Valor',      ['value'] = VehiclePrice },
										{ ['name'] = 'Tipo',       ['value'] = "Rental" }
									},
									discord = false,
									screenshot = false,
									coords = false,
									ip = false
								})
								vRP._Query("vehicles/rentalVehiclesDays", { Passport = Passport, vehicle = Name })
								TriggerClientEvent("Notify", source, "amarelo",
									"Compra do veiculo <b>" .. VehicleName(Name) .. "</b> concluida!!.", "Atenção",
									5000)
							end
						else
							vRP._Query("vehicles/rentalVehicles",
								{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
							TriggerClientEvent("Notify", source, "verde",
								"Compra do veículo <b>" .. VehicleName(Name) .. "</b> concluído.", "Sucesso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "verde", "Gemas insuficientes", "Sucesso", 5000)
					end
				end
				return
			end

			local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
			if vehicle[1] then
				TriggerClientEvent("Notify", source, "amarelo", "Já possui um <b>" .. VehicleName(Name) .. "</b>.", 3000)
				Active[Passport] = nil
				return
			else
				if VehicleMode(Name) == "work" then
					if vRP.PaymentFull(Passport, VehiclePrice(Name)) then
						vRP._Query("vehicles/addVehicles",
							{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
						exports['logs']:customLogs('dealership', {
							Passport = Passport,
							fields = {
								{ ['name'] = 'Passaporte', ['value'] = Passport },
								{ ['name'] = 'Carro',      ['value'] = Name },
								{ ['name'] = 'Valor',      ['value'] = VehiclePrice(Name) },
								{ ['name'] = 'Tipo',       ['value'] = "Work" }
							},
							discord = false,
							screenshot = false,
							coords = false,
							ip = false
						})
						TriggerClientEvent("Notify", source, "verde", "Compra concluída.", 5000)
					else
						TriggerClientEvent("Notify", source, "vermelho", "<b>Dólares</b> insuficientes.", 5000)
					end
				else
					local VehiclePrice = VehiclePrice(Name)
					if vRP.Request(source, "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. parseFormat(VehiclePrice) .. "</b> dólares?", "Sim, concluír pagamento", "Não, mudei de ideia") then
						if vRP.PaymentFull(Passport, VehiclePrice) then
							vRP._Query("vehicles/addVehicles",
								{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
							exports['logs']:customLogs('dealership', {
								Passport = Passport,
								fields = {
									{ ['name'] = 'Passaporte', ['value'] = Passport },
									{ ['name'] = 'Carro',      ['value'] = Name },
									{ ['name'] = 'Valor',      ['value'] = VehiclePrice },
									{ ['name'] = 'Tipo',       ['value'] = "Dollars" }
								},
								discord = false,
								screenshot = false,
								coords = false,
								ip = false
							})
							TriggerClientEvent("Notify", source, "verde", "Compra concluída.", 5000)
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>Dólares</b> insuficientes.", 5000)
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDrive()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if not Active[Passport] then
            Active[Passport] = true

			if vRP.Request(source, "Iniciar o teste por <b>$100</b> dólares?", "Sim, iniciar o teste", "Não, volto depois") then
				if vRP.PaymentFull(Passport, 100) then
                    TriggerEvent("vRP:BucketServer", source, "Enter", Passport)
                    Active[Passport] = nil

                    return true
                else
                    TriggerClientEvent("Notify", source, "vermelho", "<b>Dólares</b> insuficientes.", 5000)
                end
            end

            Active[Passport] = nil
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("vRP:BucketServer", source, "Exit")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)