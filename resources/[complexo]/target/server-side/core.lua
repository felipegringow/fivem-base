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
Tunnel.bindInterface("target",Creative)
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckIn()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetHealth(source) <= 100 then
			if vRP.Request(source,"Prosseguir o tratamento por <b>$950</b> dólares?","Sim, iniciar tratamento","Não, volto mais tarde") then
				if vRP.PaymentBank(Passport,975) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,20)
					TriggerEvent("Reposed",source,Passport,900)

					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		else
			if vRP.Request(source,"Prosseguir o tratamento por <b>$750</b> dólares?","Sim, iniciar tratamento","Não, volto mais tarde") then
				if vRP.PaymentBank(Passport,750) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,20)
					TriggerEvent("Reposed",source,Passport,900)

					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:CALLWORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Calls = {}
RegisterServerEvent("target:CallWorks")
AddEventHandler("target:CallWorks",function(Perm)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,Perm) then
		if not Calls[Perm] then
			Calls[Perm] = os.time()
		end

		if os.time() >= Calls[Perm] then
			if Perm == "Paramedic" then
				TriggerClientEvent("Notify",-1,"amarelo","<b>Centro Médico de Energy informa:</b> Estamos em busca de doadores de sangue, seja solidário e ajude o próximo, procure um de nossos profissionais.",15000)
			else
				TriggerClientEvent("Notify",-1,"amarelo","<b>"..Perm.." informa:</b> Estamos em busca de trabalhadores, compareça ao estabelecimento, procure um de nossos funcionários e consulte nosso serviço de entregas.",15000)
			end

			Calls[Perm] = os.time() + 600
		else
			local Cooldown = parseInt(Calls[Perm] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
		end
	end
end)

RegisterNetEvent("hup:phoneObject")
AddEventHandler("hup:phoneObject",function ()
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport) 
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)
	
	local Service = vRP.NumPermission("Police")
	for Passport,Sources in pairs(Service) do
		-- print(Passport,Sources)
		-- if vRP.HasService(Sources,"Police") then
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = "192", name = Identity["name"].." "..Identity["name2"].."  "..vRP.Identity(Passport).phone,phone = vRP.Identity(Passport).phone, title = "SOS TELEFONES", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "EMERGENCIA", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
			end)
		-- end
	end
end)