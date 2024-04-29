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
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vANIM = Tunnel.getInterface("animacoes")
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
tvRP = Tunnel.getInterface("VRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
local Blips = false
local Checkpoint = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport,"Admin",1 or 2) then
		if Passport and Message[1] and Message[2] then
			vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2], plate = vRP.GeneratePlate(), work = tostring(false) })
			TriggerClientEvent("Notify",source,"verde","Adicionado o veiculo <b>"..Message[2].."</b> na garagem de ID <b>"..Message[1].."</b>.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport,"Admin",1 or 2) then
		if Passport and Message[1] and Message[2] then
			vRP.Query("vehicles/removeVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2]})
			TriggerClientEvent("Notify",source,"verde","Retirado o veiculo <b>"..Message[2].."</b> da garagem de ID <b>"..Message[1].."</b>.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
local LastSave = os.time() + 300
CreateThread(function()
	while true do
		Wait(60000)

		if os.time() >= LastSave then
			TriggerEvent("SaveServer",true)
			LastSave = os.time() + 300
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RaceConfig(Left,Center,Right,Distance)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Archive(Passport..".txt","{")

		vRP.Archive(Passport..".txt","['Left'] = vec3("..mathLength(Left["x"])..","..mathLength(Left["y"])..","..mathLength(Left["z"]).."),")
		vRP.Archive(Passport..".txt","['Center'] = vec3("..mathLength(Center["x"])..","..mathLength(Center["y"])..","..mathLength(Center["z"]).."),")
		vRP.Archive(Passport..".txt","['Right'] = vec3("..mathLength(Right["x"])..","..mathLength(Right["y"])..","..mathLength(Right["z"]).."),")
		vRP.Archive(Passport..".txt","['Distance'] = "..Distance)

		vRP.Archive(Passport..".txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"default",History:sub(9),"Prefeitura",60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("flash", function(source, args)
	local source = source
	local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 2) then
            TriggerClientEvent("admin:Flash", source)
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Seu Passport não pôde ser encontrado.", "Erro", 5000)
    end
end,false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil

				TriggerClientEvent("Notify",source,"amarelo","Modo espião desativado.","Atenção",5000)
			else
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					local OtherPassport = vRP.Passport(OtherSource)
					local OtherIdentity = vRP.Identity(OtherPassport)
					if OtherPassport and OtherIdentity then
						if vRP.Request(source,"Administração","Você realmente deseja espionar <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>?") then
							local Ped = GetPlayerPed(OtherSource)
							if DoesEntityExist(Ped) then
								SetEntityDistanceCullingRadius(Ped,999999999.0)
								Wait(1000)
								TriggerClientEvent("admin:initSpectate",source,OtherSource)
								Spectate[Passport] = OtherSource

								TriggerClientEvent("Notify",source,"verde","Você está espiando <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>.","Sucesso",5000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("quake",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>60</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.","Terromoto",60000)
			GlobalState["Quake"] = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = tostring(Passport)
		local Messages = ""
		
		if Message[1] and vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) then
			OtherPassport = Message[1]
			Messages = "<b>Passaporte:</b> "..Message[1].."<br>"
			
			if parseInt(OtherPassport) <= 0 then
				return
			end
		end
		
		local Groups = vRP.Groups()
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherPassport] then
				Messages = Messages..Permission.."<br>"
			end
		end
		
		if Messages ~= "" then
			TriggerClientEvent("Notify",source,"verde",Messages,10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("admindebug",function(source,args,rawCommand)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2) then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3) and parseInt(Message[1]) > 0 then
			TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
			vRP.ClearInventory(Message[1])
			
			TriggerEvent("Discord","Admin","**clearinv**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearchest",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2) and Message[1] then
			local Consult = vRP.Query("chests/GetChests",{ name = Message[1] })
			if Consult[1] then
				TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
				vRP.SetSrvData("Chest:"..Message[1],{},true)
				
				TriggerEvent("Discord","Admin","**clearchest**\n\n**Passaporte:** "..Passport.."\n**Chest:** "..Message[2],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addgem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.UpgradeGemstone(OtherPassport,Amount)
				
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					TriggerClientEvent("Notify",OtherSource,"azul","Você recebeu <b>"..Amount.."x Gemas</b>.",5000)
				end
				
				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remgem",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1 or 2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
            local Amount = parseInt(Message[2])
            local OtherPassport = parseInt(Message[1])
            local Identity = vRP.Identity(OtherPassport)
            if Identity then
                TriggerClientEvent("Notify",source,"verde","Gemas removidas.",5000)
                vRP.RemoveGems(OtherPassport,Amount)
                
                local OtherSource = vRP.Source(OtherPassport)
                if OtherSource then
                    TriggerClientEvent("Notify",OtherSource,"azul","Foi removido <b>"..Amount.."x Gemas</b>.",5000)
                end
                
                TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {}
RegisterCommand("blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) then
			local Text = ""
			
			if not Blips[Passport] then
				Blips[Passport] = true
				Text = "Ativado"
			else
				Blips[Passport] = nil
				Text = "Desativado"
			end
			
			vRPC.BlipAdmin(source)
			
			TriggerEvent("Discord","Admin","**blips**\n\n**Passaporte:** "..Passport.."\n**Situação:** "..Text,3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
	local Passport = vRP.Passport(source)
	local List = vRP.Players()
	local OtherPlayer = parseInt(Message[1])
	local text = parseInt(Message[1])
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3)  then
			if Message[1] then
				if Message[1] == "all" then
					local Text = ""
					for OtherPlayer,OtherSource in pairs(List) do
						async(function()
							vRP.UpgradeThirst(OtherPlayer,100)
							vRP.UpgradeHunger(OtherPlayer,100)
							vRP.DowngradeStress(OtherPlayer,100)
							vRP.Revive(OtherSource,200)
							
							TriggerClientEvent("paramedic:Reset",OtherSource)
							
							if Text == "" then
								Text = OtherPlayer
							else
								Text = Text..", "..OtherPlayer
							end
						end)
					end
				else
					
					local ClosestPed = vRP.Source(OtherPlayer)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPlayer,100)
						vRP.UpgradeHunger(OtherPlayer,100)
						vRP.DowngradeStress(OtherPlayer,100)
						vRP.Revive(ClosestPed,200)
						TriggerClientEvent("hud:Active",OtherPlayer,true)
						
						TriggerClientEvent("paramedic:Reset",ClosestPed)
					end
				end
			else
				vRP.Revive(source,200)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				TriggerClientEvent("hud:Active",Passport,true)
				TriggerClientEvent("paramedic:Reset",source)
				
				vRPC.removeObjects(source)
			end
			
			if List then
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..text,3553599)
			elseif OtherPlayer then
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPlayer,3553599)
			else
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Passport,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GODA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("goda",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3) then
			local Range = parseInt(Message[1])
			if Range then
				local Text = ""
				local Players = vRPC.ClosestPeds(source,Range)
				for _,v in pairs(Players) do
					async(function()
						local OtherPlayer = vRP.Passport(v)
						vRP.UpgradeThirst(OtherPlayer,100)
						vRP.UpgradeHunger(OtherPlayer,100)
						vRP.DowngradeStress(OtherPlayer,100)
						vRP.Revive(v,200)
						TriggerClientEvent("hud:Active",OtherPlayer,true)
						TriggerClientEvent("paramedic:Reset",v)
						
						if Text == "" then
							Text = OtherPlayer
						else
							Text = Text..", "..OtherPlayer
						end
					end)
				end
				
				TriggerEvent("Discord","Admin","**goda**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3)   then
			if Message[1] and Message[2] and itemBody(Message[1]) ~= nil then
				local Amount = parseInt(Message[2])
				vRP.GenerateItem(Passport,Message[1],Amount,true)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerEvent("Discord","Admin","**item**\n\n**Passaporte:** "..Passport.."\n**Item:** "..Amount.."x "..itemName(Message[1]),3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3) and Message[3] and itemBody(Message[1]) then
			local OtherPassport = parseInt(Message[3])
			if OtherPassport > 0 then
				local Amount = parseInt(Message[2])
				local Item = itemName(Message[1])
				vRP.GenerateItem(Message[3],Message[1],Amount,true)
				TriggerClientEvent("Notify",source,"verde","Você enviou <b>"..Amount.."x "..Item.."</b> para o passaporte <b>"..OtherPassport.."</b>.",5000)
				
				TriggerEvent("Discord","Admin","**item2*\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Item:** "..Amount.."x "..Item,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3)   then
			local OtherPassport = parseInt(Message[1])
			if OtherPassport > 0 then
				vRP.Query("characters/removeCharacter",{ id = OtherPassport })
				TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)
				
				TriggerEvent("Discord","Admin","**delete**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
local Noclip = {}
RegisterCommand("nc",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if Passport == 1 or vRP.HasGroup(Passport,"Admin",1 or 2 or 3) then
		
			local Text = ""
			
			if not Noclip[Passport] then
				Noclip[Passport] = true
				Text = "Ativado"
				TriggerClientEvent("Notify",source,"verde","NoClip Ativado",5000)
			else
				Noclip[Passport] = nil
				Text = "Desativado"
				TriggerClientEvent("Notify",source,"vermelho","NoClip Desativado",5000)
			end
			
			vRPC.noClip(source)
			
			TriggerEvent("Discord","Admin","**nc**\n\n**Passaporte:** "..Passport.."\n**Situação:** "..Text,3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if Passport == 1 or vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4 or 5) and parseInt(Message[1]) > 0 then
			local OtherSource = vRP.Source(Message[1])
			if OtherSource then
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..Message[1].."</b> expulso.",5000)
				vRP.Kick(OtherSource,"Expulso da cidade.")
				
				TriggerEvent("Discord","Admin","**kick**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if Passport == 1 or vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Days = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = Days })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.",5000)
				TriggerEvent("Discord","Admin","**ban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Tempo:** "..Days.." dias",3553599)
				
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vRP.Kick(OtherSource,"Banido.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)
				
				TriggerEvent("Discord","Admin","**unban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("al",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4 or 5) and OtherPassport > 0 then
			vRP.Query("accounts/updateWhitelist",{ id = Message[1], whitelist = 1 })
			TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> Aprovado.",5000)
			TriggerEvent("Discord","Admin","**al**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unal",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4 or 5) and OtherPassport > 0 then
			vRP.Query("accounts/updateWhitelist",{ id = OtherPassport, whitelist = 0 })
			TriggerClientEvent("Notify",source,"vermelho","Passaporte <b>"..OtherPassport.."</b> Cancelado a wl.",5000)
			TriggerEvent("Discord","Admin","**unal**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4)   then
			local Keyboard = vKEYBOARD.keySingle(source,"Coordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
				TriggerEvent("Discord","Admin","**tpcds**\n\n**Passaporte:** "..Passport.."\n**Cds:** "..Split[1] or 0,Split[2] or 0,Split[3] or 0,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4)   then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)
			vKEYBOARD.keyCopy(source,"Coordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if  parseInt(Message[1]) > 0 and Message[2] and parseInt(Message[3]) then
			if Passport == 1 or vRP.HasGroup(Passport,"Admin",1 or 2 or 3) then
				TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)
				vRP.SetPermission(Message[1],Message[2],Message[3])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
	if vRP.HasGroup(Passport,"Admin",1 or 2 or 3) and parseInt(Message[1]) > 0 and Message[2] then
		if (Message[2] == "Admin" or Message[2] == "Premium") and not vRP.HasGroup(Passport,"Admin",1 or 2) then
			return
		end
			
		local Groups = vRP.Groups()
		if Groups[Message[2]] then
			vRP.RemovePermission(Message[1],Message[2])
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..Message[2].."</b> do passaporte <b>"..Message[1].."</b>.",5000)
					
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					TriggerClientEvent("player:Relationship",OtherSource,Message[2],true)
				end
					
				TriggerEvent("Discord","Admin","**ungroup**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1].."\n**Grupo:** "..Message[2],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if  vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
					
				vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])
				TriggerEvent("Discord","Admin","**tptome**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if  vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(ClosestPed)
				local Coords = GetEntityCoords(Ped)
				vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
				TriggerEvent("Discord","Admin","**tpto**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) then
			local vehicle = vRPC.VehicleHash(source)
			if vehicle then
				vKEYBOARD.keyCopy(source,"Hash:",vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
			if Vehicle then
				TriggerClientEvent("admin:vehicleTuning",source,Network,Plate)
				TriggerEvent("Discord","Admin","**tuning**\n\n**Passaporte:** "..Passport.."\n**Placa:** "..Plate,3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) then
			local Vehicle,Network,Plate,vehName = vRPC.VehicleList(source,10)
			if Vehicle then
				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("inventory:repairAdmin",v,Network,Plate)
						TriggerEvent("CleanVehicle",v,Network,Plate)
					end)
				end
					
				if VehicleExist(vehName) then
					TriggerEvent("Discord","Admin","**fix**\n\n**Passaporte:** "..Passport.."\n**Veículo:** "..VehicleName(vehName).."\n**Placa:** "..Plate,3553599)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limpararea", function(source, args)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin",2) then
            local Ped = GetPlayerPed(source)
            local Coords = GetEntityCoords(Ped)
            vCLIENT.Limparea(source, Coords)
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Area Limpa.", 5000)
    end
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4 or 5) then
			return
		end
	end
		
	if source ~= 0 then
		TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices()..".",5000)
	else
		print("^2Jogadores Conectados:^7 "..GetNumPlayerIndices())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4 or 5) and parseInt(Message[1]) > 0 then
			local Identity = vRP.Identity(Message[1])
			if Identity then
				TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> "..Message[1].."<br><b>Nome:</b> "..Identity["name"].." "..Identity["name2"].."<br><b>Telefone:</b> "..Identity["phone"].."<br><b>Banco:</b> $"..parseFormat(Identity["bank"]),5000)
				TriggerEvent("Discord","Admin","**id**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("source",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local Source = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Admin",1) and Source > 0 then
			local OtherPassport = vRP.Passport(Source)
			if OtherPassport then
				TriggerClientEvent("Notify",source,"azul","<b>Source:</b> "..Source.."<br><b>Passaporte:</b> "..OtherPassport,5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4)   then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)
				
			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2 or 3 or 4) and Message[1] then
			TriggerClientEvent("Notify",-1,"amarelo","<b>Prefeitura:</b> "..History:sub(9),60000)
				
			TriggerEvent("Discord","Admin","**announce**\n\n**Passaporte:** "..Passport.."\n**Text:** "..History:sub(9),3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1 or 2 or 3) then
			return
		end
			
		TriggerEvent("Discord","Admin","**kickall**\n\n**Passaporte:** "..Passport,3553599)
	end
		
	local List = vRP.Players()
	for _,Sources in pairs(List) do
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end
		
	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",1 or 2 or 3) then
			return
		end
			
		TriggerEvent("Discord","Admin","**save**\n\n**Passaporte:** "..Passport,3553599)
	end
		
	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1 or 2) then
			local Text = ""
			local List = vRP.Players()
				
			for OtherPlayer,_ in pairs(List) do
				async(function()
					if Text == "" then
						Text = OtherPlayer
					else
						Text = Text..", "..OtherPlayer
					end
						
					vRP.GenerateItem(OtherPlayer,Message[1],Message[2],true)
				end)
			end
				
			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)
					
			TriggerEvent("Discord","Admin","**itemall**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text.."\n**Item:** "..Message[2].."x "..itemName(Message[1]),3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------		
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil

				TriggerClientEvent("Notify",source,"amarelo","Modo espião desativado.","Atenção",5000)
			else
				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					local OtherPassport = vRP.Passport(OtherSource)
					local OtherIdentity = vRP.Identity(OtherPassport)
					if OtherPassport and OtherIdentity then
						if vRP.Request(source,"Administração","Você realmente deseja espionar <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>?") then
							local Ped = GetPlayerPed(OtherSource)
							if DoesEntityExist(Ped) then
								SetEntityDistanceCullingRadius(Ped,999999999.0)
								Wait(1000)
								TriggerClientEvent("admin:initSpectate",source,OtherSource)
								Spectate[Passport] = OtherSource

								TriggerClientEvent("Notify",source,"verde","Você está espiando <b>"..OtherIdentity["Name"].." "..OtherIdentity["Lastname"].."</b>.","Sucesso",5000)
							end
						end
					end
				end
			end
		end
	end
end)