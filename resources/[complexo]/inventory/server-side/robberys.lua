-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKS
-----------------------------------------------------------------------------------------------------------------------------------------
local BanksPermission = "Policia"
local BanksRadio = "701"
local BanksNeed = 10
local BanksItem = "gold_pure"
local BanksAmount = math.random(150, 300)
local BanksWeaponRequired = "WEAPON_CROWBAR"
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local BarbershopPermission = "Policia"
local BarbershopRadio = "601"
local BarbershopNeed = 4
local BarbershopItem = "dollars2"
local BarbershopAmount = math.random(5000, 6000)
local BarbershopRequired = "card04"
local BarbershopRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
local WeaponPermission = "Policia"
local WeaponRadio = "101"
local WeaponNeed = 3
local WeaponItem = "dollars2"
local WeaponAmount = math.random(5000, 6000)
local WeaponRequired = "card02"
local WeaponRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLEECAS
-----------------------------------------------------------------------------------------------------------------------------------------
local FleecasPermission = "Policia"
local FleecasRadio = "301"
local FleecasNeed = 5
local FleecasItem = "dollars2"
local FleecasAmount = math.random(7000, 14000)
local FleecasRequired = "card03"
local FleecasRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPARTMENT
-----------------------------------------------------------------------------------------------------------------------------------------
local DepartmentPermission = "Policia"
local DepartmentRadio = "401"
local DepartmentNeed = 5
local DepartmentItem = "dollars2"
local DepartmentAmount = math.random(5000, 6000)
local DepartmentRequired = "card01"
local DepartmentRequiredAmount = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Robberys")
AddEventHandler("inventory:Robberys", function(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not RobberyType[Type] then
			RobberyType[Type] = os.time()
		end

		if os.time() >= RobberyType[Type] then
			if Type == "banks" then
				local Service, Total = vRP.NumPermission(BanksPermission)
				if Total >= BanksNeed then
					if vCLIENT.checkWeapon(source, BanksWeaponRequired) then
						if vRP.Device(source, 60) then
							TriggerClientEvent("Notify", source, "Atenção","Rádio da Negociação: <b>" .. BanksRadio .. "</b>", "azul", 10000)

							local Coords = vRP.GetEntityCoords(source)
							for Passports, Sources in pairs(Service) do
								async(function()
									TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

									TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo ao Banco", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. BanksRadio, blipColor = 22 })
								end)
							end

							vRPC.AnimActive(source)

							Active[Passport] = os.time() + 60
							RobberyType[Type] = os.time() + 3600
							TriggerClientEvent("Progress", source, "Roubando", 60000)

							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close", source)
							vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

							repeat
								if os.time() >= parseInt(Active[Passport]) then
									Active[Passport] = nil

									TriggerEvent("Wanted", source, Passport, 300)
									vRP.GenerateItem(Passport, BanksItem, BanksAmount, true)
									TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

									vRPC.stopAnim(source, false)
									vRP.UpgradeStress(Passport, math.random(2))
									Player(source)["state"]["Buttons"] = false
								end

								Wait(100)
							until not Active[Passport]
						else
							RobberyType[Type] = os.time() + 60
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName(BanksWeaponRequired) .. "</b> em mãos.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
				end
			elseif Type == "barbershop" then
				local Service, Total = vRP.NumPermission(BarbershopPermission)
				if Total >= BarbershopNeed then
					local Consult = vRP.InventoryItemAmount(Passport, BarbershopRequired)
					if Consult[1] >= BarbershopRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 60) then
								if vRP.TakeItem(Passport, Consult[2], BarbershopRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "Atenção","Rádio da Negociação: <b>" .. BarbershopRadio .. "</b>", "azul", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Barbearia", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. BarbershopRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 60
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 60000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, BarbershopItem, BarbershopAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 60
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(BarbershopRequired) .. "</b> danificado.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(BarbershopRequiredAmount) .. "x " .. itemName(BarbershopRequired) .. "</b>.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
				end
			elseif Type == "weaponshop" then
				local Service, Total = vRP.NumPermission(WeaponPermission)
				if Total >= WeaponNeed then
					local Consult = vRP.InventoryItemAmount(Passport, WeaponRequired)
					if Consult[1] >= WeaponRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 60) then
								if vRP.TakeItem(Passport, Consult[2], WeaponRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "Atenção","Rádio da Negociação: <b>" .. WeaponRadio .. "</b>", "azul", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Loja de Armas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. WeaponRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 60
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 60000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, WeaponItem, WeaponAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 60
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(WeaponRequired) .. "</b> danificado.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(WeaponRequiredAmount) .. "x " .. itemName(WeaponRequired) .. "</b>.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
				end
			elseif Type == "fleecas" then
				local Service, Total = vRP.NumPermission(FleecasPermission)
				if Total >= FleecasNeed then
					local Consult = vRP.InventoryItemAmount(Passport, FleecasRequired)
					if Consult[1] >= FleecasRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 60) then
								if vRP.TakeItem(Passport, Consult[2], FleecasRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "Atenção","Rádio da Negociação: <b>" .. FleecasRadio .. "</b>", "azul", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Banco Fleeca", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. FleecasRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 60
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 60000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, FleecasItem, FleecasAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 60
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(FleecasRequired) .. "</b> danificado.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(FleecasRequiredAmount) .. "x " .. itemName(FleecasRequired) .. "</b>.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
				end
			elseif Type == "departmentshop" then
				local Service, Total = vRP.NumPermission(DepartmentPermission)
				if Total >= DepartmentNeed then
					local Consult = vRP.InventoryItemAmount(Passport, DepartmentRequired)
					if Consult[1] >= DepartmentRequiredAmount then
						if not vRP.CheckDamaged(Consult[2]) then
							if vRP.Device(source, 60) then
								if vRP.TakeItem(Passport, Consult[2], DepartmentRequiredAmount, true) then
									TriggerClientEvent("Notify", source, "Atenção","Rádio da Negociação: <b>" .. DepartmentRadio .. "</b>", "azul", 10000)

									local Coords = vRP.GetEntityCoords(source)
									for Passports, Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("sounds:Private", Sources, "crime", 0.5)

											TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Loja de Departamento", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: " .. DepartmentRadio, blipColor = 22 })
										end)
									end

									vRPC.AnimActive(source)

									Active[Passport] = os.time() + 60
									RobberyType[Type] = os.time() + 3600
									TriggerClientEvent("Progress", source, "Roubando", 60000)

									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close", source)
									vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("Wanted", source, Passport, 300)
											vRP.GenerateItem(Passport, DepartmentItem, DepartmentAmount, true)
											TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")

											vRPC.stopAnim(source, false)
											vRP.UpgradeStress(Passport, math.random(2))
											Player(source)["state"]["Buttons"] = false
										end

										Wait(100)
									until not Active[Passport]
								end
							else
								RobberyType[Type] = os.time() + 60
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(DepartmentRequired) .. "</b> danificado.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>" .. parseInt(DepartmentRequiredAmount) .. "x " .. itemName(DepartmentRequired) .. "</b>.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
				end
			end
		else
			local Cooldown = MinimalTimers(RobberyType[Type] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
		end
	end
end)
