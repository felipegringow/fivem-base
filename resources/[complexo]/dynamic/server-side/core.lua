-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("dynamic",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {
	["Driver"] = "Motorista",
	["Delivery"] = "Entregador",

	["Dismantle"] = "Desmanche",
	["Tows"] = "Reboque",

	["Transporter"] = "Transportador",
	["Lumberman"] = "Lenhador"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	local Datatable = vRP.Datatable(Passport)
	if Passport and Datatable then
		local Experiences = {}

		for Index,v in pairs(Works) do
			if Datatable[Index] then
				Experiences[v] = Datatable[Index]
			else
				Experiences[v] = 0
			end
		end

		return Experiences
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCLUSIVAS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Exclusivas()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Clothes = {}
		local Consult = vRP.GetSrvData("Exclusivas:"..Passport)

		for Index,v in pairs(Consult) do
			Clothes[#Clothes + 1] = { ["name"] = Index, ["id"] = v["id"], ["texture"] = v["texture"] or 0, ["type"] = v["type"] }
		end

		return Clothes
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EMERGENCYANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EmergencyAnnounce")
AddEventHandler("dynamic:EmergencyAnnounce", function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local identity = vRP.Identity(source)
        if vRP.HasGroup(Passport, "Police") or vRP.HasGroup(Passport, "Paramedic") then
            TriggerClientEvent("dynamic:closeSystem", source)
            local Keyboard = vKEYBOARD.keyTertiary(source, "Mensagem:", "Cor:", "Tempo (em MS):")
            if Keyboard then
                local playerName = identity["name"] .. " " .. identity["name2"]
                local originalMessage = Keyboard[1]
                local finalMessage = originalMessage .. "\n\n\nMensagem Enviada Por: " .. playerName
                TriggerClientEvent("Notify", -1, Keyboard[2], finalMessage, Keyboard[3])
            end
        end
    end
end)