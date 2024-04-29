-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("garages", Creative)
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawn = {}
local Signal = {}
local Searched = {}
local Propertys = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["GlobalPlates"] = {}
GlobalState["Plates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ServerVehicle(Model, x, y, z, Heading, Plate, Nitrox, Doors, Body, Fuel)
	local Vehicle = CreateVehicle(Model, x, y, z, Heading, true, true)

	while not DoesEntityExist(Vehicle) do
		Wait(100)
	end

	if DoesEntityExist(Vehicle) then
		if Plate ~= nil then
			SetVehicleNumberPlateText(Vehicle, Plate)
		else
			Plate = vRP.GeneratePlate()
			SetVehicleNumberPlateText(Vehicle, Plate)
		end

		SetVehicleBodyHealth(Vehicle, Body + 0.0)

		if not Fuel then
			TriggerEvent("engine:tryFuel", Plate, 100)
		end

		if Doors then
			local Doors = json.decode(Doors)
			if Doors ~= nil then
				for Number, Status in pairs(Doors) do
					if Status then
						SetVehicleDoorBroken(Vehicle, parseInt(Number), true)
					end
				end
			end
		end

		local Network = NetworkGetNetworkIdFromEntity(Vehicle)

		if Model ~= "iak_wheelchair" then
			local Network = NetworkGetEntityFromNetworkId(Network)
			SetVehicleDoorsLocked(Network, 2)

			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = Nitrox or 0
			GlobalState:set("Nitro", Nitro, true)
		end

		return true, Network, Vehicle
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("signalRemove", function(Plate)
	if not Signal[Plate] then
		Signal[Plate] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateReveryone", function(Plate)
	if GlobalState["Plates"][Plate] then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = nil
		GlobalState:set("Plates", Plates, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateEveryone", function(Plate)
	local Plates = GlobalState["Plates"]
	Plates[Plate] = true
	GlobalState:set("Plates", Plates, true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("platePlayers", function(Plate, Passport)
	if not vRP.PassportPlate(Plate) then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = Passport
		GlobalState:set("Plates", Plates, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicles(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if string.sub(Number, 1, 9) == "Propertys" then
			local Consult = vRP.Query("propertys/Exist", { name = Number })
			if Consult[1] then
				if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport, "propertys-" .. Consult[1]["Serial"]) then
					if os.time() > Consult[1]["Tax"] then
						TriggerClientEvent("Notify", source, "amarelo",
							"Aluguel atrasado, procure um <b>Corretor de Imóveis</b>.", "Atenção", 5000)
						return false
					end
					local Vehicle = {}
					local Consult = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
					for _, v in pairs(Consult) do
						if VehicleExist(v["vehicle"]) then
							if v["work"] == "false" then
								Vehicle[#Vehicle + 1] = {
									["model"] = v["vehicle"],
									["name"] = VehicleName(v["vehicle"]),
									["type"] = VehicleMode(v["vehicle"]),
									["engine"] = v["engine"],
									["chassi"] = v["health"],
									["body"] = v["body"],
									["gas"] = v["fuel"],
									["chest"] = VehicleChest(v["vehicle"]),
									["tax"] = VehiclePrice(v["vehicle"]) * 0.3
								}
							end
						end
					end
					return Vehicle
				else
					TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para acessar esta garagem.",
						"Atenção", 5000)
					return false
				end
			end
		end


		local garageData = GaragesCoords[Number]
		if garageData == nil then
			return false
		end

		local GarageName = garageData.config

		if Garages[GarageName] and Garages[GarageName]["perm"] then
			local hasGroup = false
			for k, v in pairs(Garages[GarageName]["perm"]) do
				if vRP.HasGroup(Passport, v) then
					hasGroup = true
					break
				end
			end
			if not hasGroup then
				TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para acessar esta garagem.",
					"Atenção", 5000)
				return false
			end
		end

		local Vehicle = {}
		if Garages[GarageName]["garagemType"] == "Org" then
			if vRP.GroupHasPremium(GarageName) then
				for _, v in pairs(PremiumGaragesVehicles) do
					local VehicleResult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = v })
					if VehicleExist(v) then
						if VehicleResult[1] then
							Vehicle[#Vehicle + 1] = {
								["model"] = v,
								["name"] = VehicleName(v),
								["type"] = VehicleMode(v),
								["engine"] = VehicleResult[1]["engine"],
								["chassi"] = VehicleResult[1]["health"],
								["body"] = VehicleResult[1]["body"],
								["gas"] = VehicleResult[1]["fuel"],
								["chest"] = VehicleChest(v),
								["tax"] = VehiclePrice(v) * 0.3
							}
						else
							Vehicle[#Vehicle + 1] = {
								["model"] = v,
								["name"] = VehicleName(v),
								["type"] = VehicleMode(v),
								["engine"] = 1000,
								["chassi"] = 1000,
								["body"] = 1000,
								["gas"] = 100,
								["chest"] = VehicleChest(v),
								["tax"] = VehiclePrice(v) * 0.3
							}
						end
					end
				end
			end
			local Consult = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
			for _, v in pairs(Consult) do
				if VehicleExist(v["vehicle"]) then
					if v["work"] == "false" then
						Vehicle[#Vehicle + 1] = {
							["model"] = v["vehicle"],
							["name"] = VehicleName(v["vehicle"]),
							["type"] = VehicleMode(v["vehicle"]),
							["engine"] = v["engine"],
							["chassi"] = v["health"],
							["body"] = v["body"],
							["gas"] = v["fuel"],
							["chest"] = VehicleChest(v["vehicle"]),
							["tax"] = VehiclePrice(v["vehicle"]) * 0.3
						}
					end
				end
			end
			return Vehicle
		end
		if Garages[GarageName]["garagemType"] == "Work" then
			for _, v in pairs(Garages[GarageName]["garagemConfig"]["vehicles"]) do
				local VehicleResult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = v })

				if VehicleExist(v) then
					if VehicleResult[1] then
						Vehicle[#Vehicle + 1] = {
							["model"] = v,
							["name"] = VehicleName(v),
							["type"] = VehicleMode(v),
							["engine"] = VehicleResult[1]["engine"],
							["chassi"] = VehicleResult[1]["health"],
							["body"] = VehicleResult[1]["body"],
							["gas"] = VehicleResult[1]["fuel"],
							["chest"] = VehicleChest(v),
							["tax"] = VehiclePrice(v) * 0.3
						}
					else
						Vehicle[#Vehicle + 1] = {
							["model"] = v,
							["name"] = VehicleName(v),
							["type"] = VehicleMode(v),
							["engine"] = 1000,
							["chassi"] = 1000,
							["body"] = 1000,
							["gas"] = 100,
							["chest"] = VehicleChest(v),
							["tax"] = VehiclePrice(v) * 0.3
						}
					end
				end
			end
		else
			local Consult = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
			for _, v in pairs(Consult) do
				if VehicleExist(v["vehicle"]) then
					if v["work"] == "false" then
						Vehicle[#Vehicle + 1] = {
							["model"] = v["vehicle"],
							["name"] = VehicleName(v["vehicle"]),
							["type"] = VehicleMode(v["vehicle"]),
							["engine"] = v["engine"],
							["chassi"] = v["health"],
							["body"] = v["body"],
							["gas"] = v["fuel"],
							["chest"] = VehicleChest(v["vehicle"]),
							["tax"] = VehiclePrice(v["vehicle"]) * 0.3,
							["price"] = VehiclePrice(v["vehicle"]),
							["renovation"] = v["tax"]
						}
					end
				end
			end
		end

		return Vehicle
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicles = {}
		local Vehicle = vRP.Query("vehicles/UserVehicles", { Passport = Passport })

		for Number, v in ipairs(Vehicle) do
			if v["arrest"] >= os.time() then
				Vehicles[#Vehicles + 1] = {
					["Model"] = Vehicle[Number]["vehicle"],
					["name"] = VehicleName(Vehicle[Number]["vehicle"])
				}
			end
		end
		return Vehicles
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound", function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local VehiclePrice = VehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem", source)

		if vRP.Request(source, "Garagem", "A liberação do veículo tem o custo de <b>$" .. parseFormat(VehiclePrice * 0.03) .. "</b> dólares, deseja prosseguir com a liberação do mesmo?") then
			if vRP.PaymentFull(Passport, VehiclePrice * 0.03) then
				vRP.Query("vehicles/paymentArrest", { Passport = Passport, vehicle = vehName })
				TriggerClientEvent("Notify", source, "verde", "Veículo liberado.", "Sucesso", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Tax(Name, Half)
	local source = source
	local Passport = vRP.Passport(source)
	local hasTax = true
	local hasDismantle = false
	if Passport then
		local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
		if Consult[1] then
			local Price = (VehiclePrice(Name) / 100) * 3
			if Consult[1]["tax"] <= os.time() then
				hasTax = true
			elseif Consult[1]["dismantle"] then
				hasDismantle = false
			end
			if hasTax and hasDismantle then
				if vRP.Request(source, "Imposto", "Seu veiculo esta com imposto <b>atrasado</b>, deseja pagar <b>$" .. parseFormat(Price * 2) .. "</b> Dólares para liberar?") then
					if vRP.PaymentFull(Passport, Price * 2) then
						vRP.Query("vehicles/updateVehiclesTax", { Passport = Passport, vehicle = Name })
						-- vRP.Query("vehicles/setVehicleDismantle", { user_id = Passport, vehicle = Name })
						TriggerClientEvent("Notify", source, "verde", "Pagamento de imposto concluído.",
							"Sucesso", 5000)
						return true
					else
						TriggerClientEvent("Notify", source, "vermelho",
							"<b>Dinheiro</b> insuficiente. Total necessario é de : " .. Price * 2, "Aviso", 5000)
					end
				end
			elseif hasTax then
				if vRP.PaymentFull(Passport, Price) then
					vRP.Query("vehicles/updateVehiclesTax", { Passport = Passport, vehicle = Name })
					-- vRP.Query("vehicles/setVehicleDismantle", { user_id = Passport, vehicle = Name })
					TriggerClientEvent("Notify", source, "verde", "Pagamento de imposto concluído.", "Sucesso", 5000)
					return true
				else
					TriggerClientEvent("Notify", source, "vermelho",
						"<b>Dinheiro</b> insuficiente. Total necessario é de : " .. Price, "Aviso", 5000)
				end
			elseif hasTax and Half then
				if vRP.PaymentFull(Passport, Price / 2) then
					vRP.Query("vehicles/updateVehiclesTaxHalf", { Passport = Passport, vehicle = Name })
					TriggerClientEvent("Notify", source, "verde", "Voce pagou metade do imposto (15 dias).", "Sucesso",
						5000)
					return true
				else
					TriggerClientEvent("Notify", source, "vermelho",
						"<b>Dinheiro</b> insuficiente. Total necessario é de : " .. Price, "Aviso", 5000)
				end
			elseif hasDismantle then
				if vRP.Request(source, "Desmanche", "Seu veiculo foi <b>desmanchado</b>, deseja pagar <b>$" .. parseFormat(Price) .. "</b> Dólares para recuperar?") then
					if vRP.PaymentFull(Passport, Price) then
						-- vRP.Query("vehicles/setVehicleDismantle", { user_id = Passport, vehicle = Name })
						vRP.Query("vehicles/updateVehiclesTax", { Passport = Passport, vehicle = Name })
						TriggerClientEvent("Notify", source, "verde", "Pagamento de desmontagem concluído.", "Sucesso",
							5000)
						return false
					else
						TriggerClientEvent("Notify", source, "vermelho",
							"<b>Dinheiro</b> insuficiente. Total necessario é de : " .. Price, "Aviso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Seu veiculo não possui imposto atrasado.", "Aviso",
					5000)
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL/Transfer
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Sell(Data)
	local source = source
	local Passport = vRP.Passport(source)
	local Name = Data.model
	local OtherPassport = Data.target
	local SelectedPrice = Data.value
	if Passport then
		if OtherPassport then
			local myVehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
			if myVehicle[1] then
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					local Mode = VehicleMode(Name)
					if Mode == "rental" or Mode == "work" or Mode == "Rental" then
						TriggerClientEvent("Notify", source, "amarelo",
							"<b>Este veiculo nao pode ser transferido</b>",
							"Atenção", 5000)
						return
					end
					local transerMessage = "Aceitar o veículo <b>" ..
						VehicleName(Name) ..
						"</b> de <b>" .. vRP.FullName(Passport) .. "</b> por <b>" .. SelectedPrice .. "</b>?"
					if not vRP.Request(vRP.Source(parseInt(OtherPassport)), "Garagem", transerMessage) then
						TriggerClientEvent("Notify", source, "amarelo",
							"<b>" .. vRP.FullName(OtherPassport) .. "</b> recusou a transferência.",
							"Atenção", 5000)
						return
					end

					if not vRP.PaymentFull(OtherPassport, SelectedPrice) then
						TriggerClientEvent("Notify", source, "amarelo",
							"<b>" ..
							vRP.FullName(OtherPassport) .. "</b> não possui dinheiro suficiente.",
							"Atenção", 5000)
						return
					end

					local Vehicle = vRP.Query("vehicles/selectVehicles",
						{ Passport = parseInt(OtherPassport), vehicle = Name })
					if Vehicle[1] then
						TriggerClientEvent("Notify", source, "amarelo",
							"<b>" ..
							vRP.FullName(OtherPassport) .. "</b> já possui este modelo de veículo.",
							"Atenção", 5000)
					else
						vRP.Query("vehicles/moveVehicles",
							{ Passport = Passport, OtherPassport = parseInt(OtherPassport), vehicle = Name })

						local Datatable = vRP.Query("entitydata/GetData",
							{ dkey = "Mods:" .. Passport .. ":" .. Name })
						if parseInt(#Datatable) > 0 then
							vRP.Query("entitydata/SetData",
								{
									dkey = "Mods:" .. OtherPassport .. ":" .. Name,
									dvalue = Datatable[1]
										["dvalue"]
								})
							vRP.Query("entitydata/RemoveData", { dkey = "Mods:" .. Passport .. ":" .. Name })
						end

						vRP.GiveBank(Passport, SelectedPrice)

						local Datatable = vRP.GetSrvData("Chest:" .. Passport .. ":" .. Name)
						vRP.SetSrvData("Chest:" .. OtherPassport .. ":" .. Name, Datatable)
						vRP.RemSrvData("Chest:" .. Passport .. ":" .. Name)

						TriggerClientEvent("Notify", source, "verde", "Transferência concluída.", "Sucesso",
							5000)
						return true
					end
				end
			end
		else
			local Mode = VehicleMode(Name)
			if Mode == "rental" or Mode == "work" or Mode == "Work" or Mode == "Rental" then
				TriggerClientEvent("Notify", source, "amarelo",
					"<b>Este veiculo nao pode ser vendido</b>",
					"Atenção", 5000)
				return
			end
			local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
			if Consult[1] then
				local Price = VehiclePrice(Name) * 0.50
				local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
				if Consult[1] then
					vRP.GiveBank(Passport, Price)
					vRP.Query("vehicles/removeVehicles", { Passport = Passport, vehicle = Name })
					vRP.Query("entitydata/RemoveData", { dkey = "Mods:" .. Passport .. ":" .. Name })
					vRP.Query("entitydata/RemoveData", { dkey = "Chest:" .. Passport .. ":" .. Name })
					return true
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Spawn(Name, Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Gemstone = VehicleGems(Name)
		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
		local GlobalPlates = GlobalState["Plates"]

		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				TriggerClientEvent("garages:Close", source)

				if Garages[GaragesCoords[Number].config]["garagemType"] == "Org" or vRP.Request(source, "Garagem", "Alugar o veículo <b>" .. VehicleName(Name) .. "</b> por <b>" .. Gemstone .. "</b> gemas?") then
					if Garages[GaragesCoords[Number].config]["garagemType"] == "Org" or vRP.PaymentGems(Passport, Gemstone) then
						vRP.Query("vehicles/rentalVehicles",
							{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify", source, "verde",
							"Aluguel do veículo <b>" .. VehicleName(Name) .. "</b> concluído.", "Sucesso", 5000)
						vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
					else
						TriggerClientEvent("Notify", source, "vermelho", "<b>Gemas</b> insuficientes.", "Aviso", 5000)
						return
					end
				else
					return
				end
			else
				TriggerClientEvent("garages:Close", source)

				local VehiclePrice = VehiclePrice(Name)
				if parseInt(VehiclePrice) > 0 then
					if Garages[GaragesCoords[Number].config]["garagemType"] == "Org" or vRP.Request(source, "Garagem", "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. parseFormat(VehiclePrice) .. "</b> dólares?") then
						if Garages[GaragesCoords[Number].config]["garagemType"] == "Org" or vRP.PaymentFull(Passport, VehiclePrice) then
							vRP.Query("vehicles/addVehicles",
								{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
							vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
						end
					else
						return
					end
				else
					vRP.Query("vehicles/addVehicles",
						{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
				end
			end
		end

		vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })

		if vehicle[1] then
			local Plate = vehicle[1]["plate"]

			if Spawn[Plate] then
				-- if not Signal[Plate] then
				if not Searched[Passport] then
					Searched[Passport] = os.time()
				end

				if os.time() >= parseInt(Searched[Passport]) then
					Searched[Passport] = os.time() + 60

					local Network = Spawn[Plate][3]
					local Network = NetworkGetEntityFromNetworkId(Network)
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						vCLIENT.SearchBlip(source, GetEntityCoords(Network))
						TriggerClientEvent("Notify", source, "default",
							"Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",
							false, 10000)
					else
						if Spawn[Plate] then
							Spawn[Plate] = nil
						end

						if GlobalPlates[Plate] then
							GlobalPlates[Plate] = nil
							GlobalState:set("Plates", GlobalPlates, true)
						end

						TriggerClientEvent("Notify", source, "verde",
							"A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",
							"Sucesso", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "azul",
						"Rastreador só pode ser ativado a cada <b>60</b> segundos.", "Observação", 5000)
				end
				-- else
				-- 	TriggerClientEvent("Notify", source, "amarelo", "Rastreador está desativado.", "Atenção", 5000)
				-- end
			else
				if vehicle[1]["tax"] * 2 <= os.time() then
					TriggerClientEvent("Notify", source, "amarelo", "Taxa do veículo atrasada.", "Atenção", 5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify", source, "amarelo",
						"Veículo apreendido, dirija-se até o <b>Guincho</b> e efetue o pagamento da liberação do mesmo.",
						"Atenção", 10000)
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							vRP.Query("vehicles/rentalVehiclesUpdate", { Passport = Passport, vehicle = Name })
						end
					end


					local Coords = vCLIENT.SpawnPosition(source, Number)
					if Coords then
						local Mods = nil
						local Datatable = vRP.Query("entitydata/GetData", { dkey = "Mods:" .. Passport .. ":" .. Name })
						if parseInt(#Datatable) > 0 then
							Mods = Datatable[1]["dvalue"]
						end

						if string.sub(Number, 1, 9) == "Propertys" then
							TriggerClientEvent("garages:Close", source)
							local Exist, Network, Vehicle = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3],
								Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"])

							if Exist then
								vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"],
									Mods, vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["brakes"])
								TriggerEvent("engine:tryFuel", Plate, vehicle[1]["fuel"])
								TriggerEvent("engine:insertBrakes", Network, vehicle[1]["brakes"])
								Spawn[Plate] = { Passport, Name, Network }

								GlobalPlates[Plate] = Passport
								GlobalState:set("Plates", GlobalPlates, true)

								local state = Entity(Vehicle).state
								state.plate = Passport

								return
							end
							return
						end

						local GarageName = GaragesCoords[Number].config

						if Garages[GarageName]["garagemConfig"]["payment"] then
							if vRP.UserPremium(Passport) then
								if Garages[GarageName]["garagemConfig"]["closeUIAfterVehicleSpawn"] then
									TriggerClientEvent("garages:Close", source)
								end

								local Exist, Network, Vehicle = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords
									[3],
									Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"])

								if Exist then
									vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"],
										Mods, vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["brakes"],
										Garages[GarageName]["garagemConfig"]["spawnInsideVehicle"])
									if Garages[GarageName]["garagemConfig"]["SendTaxsNotify"] then
										TriggerClientEvent("Notify", source, "azul",
											CompleteTimers(vehicle[1]["tax"] - os.time()), "Próximo pagamento", 5000)
									end
									TriggerEvent("engine:tryFuel", Plate, vehicle[1]["fuel"])
									TriggerEvent("engine:insertBrakes", Network, vehicle[1]["brakes"])
									Spawn[Plate] = { Passport, Name, Network }

									GlobalPlates[Plate] = Passport
									GlobalState:set("Plates", GlobalPlates, true)

									local state = Entity(Vehicle).state
									state.plate = Passport
								end
							else
								if vehicle[1]["mode"] == "normal" then
									if Garages[GarageName]["garagemConfig"]["closeUIAfterVehicleSpawn"] then
										TriggerClientEvent("garages:Close", source)
									end
									local ableToSpawn = false
									local paymentConfig = Garages[GarageName]["garagemConfig"]["paymentConfig"]
									local VehiclePrice = VehiclePrice(Name)

									if paymentConfig.type == 2 then
										VehiclePrice = paymentConfig.value
									elseif paymentConfig.type == 1 then
										VehiclePrice = (VehiclePrice / 100) * paymentConfig.value
									end

									if VehiclePrice < 0 then VehiclePrice = 0 end
									if VehiclePrice == 0 then ableToSpawn = true end

									if not ableToSpawn then
										if vRP.Request(source, "Garagem", "Retirar o veículo por <b>$" .. parseFormat(VehiclePrice) .. "</b> dólares?") then
											if paymentConfig.paymentType == 2 then
												if vRP.PaymentFull(Passport, VehiclePrice) then
													ableToSpawn = true
												else
													TriggerClientEvent("Notify", source, "vermelho",
														"<b>Dinheiro</b> insuficiente.", "Aviso", 5000)
												end
											elseif paymentConfig.paymentType == 1 then
												if vRP.TakeItem(Passport, 'dollars', VehiclePrice) then
													vRP.RemoveItem(Passport, 'dollars', VehiclePrice)
													ableToSpawn = true
												else
													TriggerClientEvent("Notify", source, "vermelho",
														"<b>Dinheiro</b> insuficiente.", "Aviso", 5000)
												end
											end
										end
									end

									if ableToSpawn then
										TriggerClientEvent("dynamic:closeSystem", source)
										local Exist, Network, Vehicle = Creative.ServerVehicle(Name, Coords[1], Coords[2],
											Coords[3], Coords[4], Plate, vehicle[1]["nitro"], vehicle[1]["doors"],
											vehicle[1]["body"])

										if Exist then
											vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"],
												vehicle[1]["health"], Mods, vehicle[1]["windows"], vehicle[1]["tyres"],
												vehicle[1]["brakes"],
												Garages[GarageName]["garagemConfig"]["spawnInsideVehicle"])
											if Garages[GarageName]["garagemConfig"]["SendTaxsNotify"] then
												TriggerClientEvent("Notify", source, "azul",
													CompleteTimers(vehicle[1]["tax"] - os.time()), "Próximo pagamento",
													5000)
											end
											TriggerEvent("engine:tryFuel", Plate, vehicle[1]["fuel"])
											TriggerEvent("engine:insertBrakes", Network, vehicle[1]["brakes"])
											Spawn[Plate] = { Passport, Name, Network }

											GlobalPlates[Plate] = Passport
											GlobalState:set("Plates", GlobalPlates, true)

											local state = Entity(Vehicle).state
											state.plate = Passport
										end
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem", source)
							local Exist, Network, Vehicle = Creative.ServerVehicle(Name, Coords[1], Coords[2], Coords[3],
								Coords[4],
								Plate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"])

							if Exist then
								vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["engine"], vehicle[1]["health"], Mods,
									vehicle[1]["windows"], vehicle[1]["tyres"], vehicle[1]["brakes"],
									Garages[GarageName]["garagemConfig"]["spawnInsideVehicle"])
								if Garages[GarageName]["garagemConfig"]["SendTaxsNotify"] then
									TriggerClientEvent("Notify", source, "azul",
										CompleteTimers(vehicle[1]["tax"] - os.time()), "Próximo pagamento", 5000)
								end
								TriggerEvent("engine:tryFuel", Plate, vehicle[1]["fuel"])
								TriggerEvent("engine:insertBrakes", Network, vehicle[1]["brakes"])
								Spawn[Plate] = { Passport, Name, Network }

								GlobalPlates[Plate] = Passport


								GlobalState:set("Plates", GlobalPlates, true)

								local state = Entity(Vehicle).state
								state.plate = Passport
							end
						end
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if (vRP.HasGroup(Passport, "Admin", 3) and Message[1]) then
			local VehicleName = Message[1]
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			local Plate = "VEH" .. (10000 + Passport)
			local Exist, Network, Vehicle = Creative.ServerVehicle(VehicleName, Coords["x"], Coords["y"], Coords["z"],
				Heading, Plate, 2000, nil, 1000)

			if not Exist then
				return
			end

			vCLIENT.CreateVehicle(-1, VehicleName, Network, 1000, 1000, nil, false, false, { 1.25, 0.75, 0.95 })
			Spawn[Plate] = { Passport, VehicleName, Network }
			TriggerEvent("engine:insertBrakes", Network, "")
			TriggerEvent("engine:tryFuel", Plate, 100)
			SetPedIntoVehicle(Ped, Vehicle, -1)

			local Plates = GlobalState["Plates"]
			Plates[Plate] = Passport
			GlobalState:set("Plates", Plates, true)

			local state = Entity(Vehicle).state
			state.plate = Passport
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv", function(source)
	local Passport = vRP.Passport(source)
	if Passport and (vRP.HasGroup(Passport, "Admin") or vRP.HasService(Passport, "Paramedico", 1) or vRP.HasService(Passport, "Bombeiro", 1) or vRP.HasService(Passport, "Bennys", 1) or vRP.HasService(Passport, "Customs", 1)) then
		TriggerClientEvent("garages:Delete", source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Key")
AddEventHandler("garages:Key", function(entity)
	local source = source
	local Plate = entity[1]
	local Passport = vRP.Passport(source)

	if Passport and GlobalState["Plates"][Plate] == Passport then
		vRP.GenerateItem(Passport, "vehkey-" .. Plate, 1, true, false)
	else
		TriggerClientEvent("Notify", source, "negado",
			"Você não tem as chaves deste veículo. Pertence ao passaporte", "Atenção",
			5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Lock")
AddEventHandler("garages:Lock", function(Network, Plate)
	local source = source
	local Passport = vRP.Passport(source)
	local entity = NetworkGetEntityFromNetworkId(Network)
	if DoesEntityExist(entity) and not IsPedAPlayer(entity) then
		local state = Entity(entity).state
		if state.plate == Passport then
			TriggerEvent("garages:LockVehicle", source, Network)
		elseif Passport and GlobalState["Plates"][Plate] == Passport then
			TriggerEvent("garages:LockVehicle", source, Network)
		end
		local nRelationship = vRP.GetRelationship(Passport)
		if nRelationship == 2 then
			local nPassportSpouse = vRP.GetSpouse(Passport)
			local nSource = vRP.Source(nPassportSpouse)
			if state.plate == parseInt(nPassportSpouse) then
				TriggerEvent("garages:LockVehicle", source, Network)
			elseif nPassportSpouse and GlobalState["Plates"][Plate] == parseInt(nPassportSpouse) then
				TriggerEvent("garages:LockVehicle", source, Network)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:LockVehicle", function(source, Network)
	local Network = NetworkGetEntityFromNetworkId(Network)
	local Doors = GetVehicleDoorLockStatus(Network)

	if parseInt(Doors) <= 1 then
		TriggerClientEvent("Notify", source, "locked", "O veículo foi <b>trancado</b>.", "locked", 5000)
		TriggerClientEvent("sounds:Private", source, "locked", 0.7)
		SetVehicleDoorsLocked(Network, 2)
	else
		TriggerClientEvent("Notify", source, "unlocked", "O veículo foi <b>destrancado</b>.", "unlocked", 5000)
		TriggerClientEvent("sounds:Private", source, "unlocked", 0.7)
		SetVehicleDoorsLocked(Network, 1)
	end

	if not vRP.InsideVehicle(source) then
		vRPC.playAnim(source, true, { "anim@mp_player_intmenu@key_fob@", "fob_click" }, false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delete(Network, Health, Engine, Body, Fuel, Doors, Windows, Tyres, Plate, Brake)
	if Spawn[Plate] then
		local Passport = Spawn[Plate][1]
		local vehName = Spawn[Plate][2]

		if parseInt(Engine) <= 100 then
			Engine = 100
		end

		if parseInt(Body) <= 100 then
			Body = 100
		end

		if parseInt(Fuel) >= 100 then
			Fuel = 100
		end

		if parseInt(Fuel) <= 0 then
			Fuel = 0
		end

		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.Query("vehicles/updateVehicles",
				{
					Passport = Passport,
					vehicle = vehName,
					nitro = GlobalState["Nitro"][Plate] or 0,
					engine = parseInt(Engine),
					body = parseInt(Body),
					health = parseInt(Health),
					fuel = parseInt(Fuel),
					doors = json.encode(Doors),
					windows = json.encode(Windows),
					tyres = json.encode(Tyres),
					brakes = json.encode(Brake)
				})
		end
	end

	TriggerEvent("garages:deleteVehicle", Network, Plate)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(Network,Plate)
	if Network ~= nil and Plate ~= nil then
		if GlobalState["Plates"][Plate] then
			local Plates = GlobalState["Plates"]
			Plates[Plate] = nil
			GlobalState:set("Plates",Plates,true)
		end

		if GlobalState["Nitro"][Plate] then
			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = nil
			GlobalState:set("Nitro",Nitro,true)
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		if string.sub(Plate,1,4) == "DISM" then
			local Passport = parseInt(string.sub(Plate,5,8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				TriggerClientEvent("inventory:Disreset",source)
				TriggerClientEvent("Notify",source,"amarelo","O veículo do seu contrato foi encaminhado para o <b>Impound</b> e o <b>Lester</b> disse que você pode assinar um novo contrato quando quiser.","Aviso",10000)
			end
		end

		local Network = NetworkGetEntityFromNetworkId(Network)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys", function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:closeSystem", source)
		TriggerClientEvent("Notify", source, "amarelo", "Selecione o local da garagem.", "Atenção", 5000)

		local Hash = "prop_offroad_tyres02"
		local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
		if Application then
			if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
				TriggerClientEvent("Notify", source, "amarelo", "Selecione o local do veículo.", "Atenção", 5000)

				local Open = Coords
				local Hash = "patriot"
				local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
				if Application then
					if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
						local New = {
							["1"] = { mathLength(Open["x"]), mathLength(Open["y"]), mathLength(Open["z"] + 1) },
							["2"] = { mathLength(Coords["x"]), mathLength(Coords["y"]), mathLength(Coords["z"] + 1),
								mathLength(Heading) }
						}

						Garages[Name] = { name = "Garage", payment = false }

						Propertys[Name] = {
							["x"] = New["1"][1],
							["y"] = New["1"][2],
							["z"] = New["1"][3],
							["1"] = New["2"]
						}

						vRP.Query("propertys/Garage", { name = Name, garage = json.encode(New) })
						TriggerClientEvent("garages:Propertys", -1, Propertys)
					else
						TriggerClientEvent("Notify", source, "vermelho", "A garagem precisa ser próximo da entrada.",
							"Aviso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "A garagem precisa ser próximo da entrada.", "Aviso",
					5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("propertys/Garages")
	for _, v in pairs(Consult) do
		local Name = v["Name"]
		if not Propertys[Name] and v["Garage"] ~= "{}" then
			local Table = json.decode(v["Garage"])
			Garages[Name] = { name = "Garage", payment = false }

			Propertys[Name] = {
				["x"] = Table["1"][1],
				["y"] = Table["1"][2],
				["z"] = Table["1"][3],
				["1"] = Table["2"]
			}
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Signal", function(Plate)
	return Signal[Plate]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("garages:Propertys", source, Propertys)
end)