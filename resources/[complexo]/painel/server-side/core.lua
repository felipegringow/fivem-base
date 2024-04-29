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
Tunnel.bindInterface("painel",Creative)
vCLIENT = Tunnel.getInterface("painel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Panels = {}
local PremiumPrice = 35000
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel",function(source,Message)
	local Passport = vRP.Passport(source)
    local Permission = Message[1] or Panels[Passport][1]
    if Permission and Permission ~= "Premium" then
        if vRP.HasPermission(Passport,Permission) then
            local Hierarchy = vRP.Hierarchy(Permission)
            local GroupData = vRP.DataGroups(Permission)
            local Members = {}

            for PlayerId, HierarchyId in pairs(GroupData) do 
                local Identity = vRP.Identity(PlayerId)
                Members[#Members + 1] = { ["name"] = Identity["name"].." "..Identity["name2"], ["phone"] = Identity["phone"], ["online"] = vRP.Source(PlayerId) or false, ["id"] = tonumber(PlayerId), ["role"] = Hierarchy[HierarchyId], ["role_id"] = HierarchyId }
            end
            
            Panels[Passport] = { Permission, GroupData[tostring(Passport)] }
            
            local Data = { groupName = Permission, members = Members, client_role = PlayerHierarchy }

            vCLIENT.Open(source,Data,false,PremiumPrice)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ClosePainel()
    local source = source
    local Passport = vRP.Passport(source)
    if Panels[Passport] then
        Panels[Passport] = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Invite(OtherId)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Data = Panels[Passport]
        if Data then
            local Permission = Data[1]
            local PlayerHierarchy = Data[2] 
            if vRP.HasPermission(Passport, Permission, 1) then
                local OtherSource = vRP.Source(OtherId)
                if OtherSource then
                    local Identity = vRP.Identity(Passport)

                    TriggerClientEvent("Notify",source,"verde","O convite foi enviado.")

                    if vRP.Request(OtherSource,"<b>" .. Identity["name"] .. " " .. Identity["name2"] .. " te convidou para se juntar a sua organização, você aceita esse convite?","Sim, aceito","Não, obrigado") then
                        vRP.SetPermission(OtherId,Permission)
                        TriggerClientEvent("Notify", source, "verde", "O convite foi aceito.")

                        local OtherIdentity = vRP.Identity(OtherId)
                        local Hierarchy = vRP.Hierarchy(Permission)

                        return { ["name"] = OtherIdentity["name"].." "..OtherIdentity["name2"], ["phone"] = OtherIdentity["phone"], ["online"] = OtherSource or false, ["id"] = tonumber(OtherId), ["role"] = Hierarchy[#Hierarchy], ["role_id"] = #Hierarchy }
                    end

                    TriggerClientEvent("Notify", source, "vermelho", "O convite não foi aceito.")

                    return false
                end

                TriggerClientEvent("Notify", source, "vermelho", "O convidado não está presente na cidade.")
                
                return false
            end

            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para convidar uma pessoa para sua organização.")

            return false
        end

        return false
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Hierarchy(OtherId, Type)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Data = Panels[Passport]
        if Data then
            local Permission = Data[1]
            local PlayerHierarchy = Data[2] 
            
            local Datatable = vRP.GetSrvData("Permissions:" .. Permission)
            if Datatable then 
                local currentHierarchy = Datatable[tostring(OtherId)]
                if not (PlayerHierarchy < currentHierarchy) then
                    TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para fazer isto.")

                    return false
                end
                
                local newHierarchy = currentHierarchy - 1
                if Type == "Demote" then
                    newHierarchy = currentHierarchy + 1
                end

                local Hierarchy = vRP.Hierarchy(Permission)
                local newRole = Hierarchy[newHierarchy]

                if newHierarchy == 0 or (newHierarchy > #Hierarchy) then
                    local message = "Não foi possível promover, pois este integrante já está no topo da hierarquia."
                    if Type == "Demote" then
                        message = "Não foi possível rebaixar, pois este integrante está no nível mais baixo da hierarquia."
                    end

                    TriggerClientEvent("Notify", source, "vermelho", message)

                    return false
                end

                if OtherSource then
                    local color = "verde"
                    local message = "Você foi promovido para " 
                    if Type == "Demote" then
                        color = "vermelho"
                        message = "Você foi rebaixado para "
                    end

                    TriggerClientEvent("Notify", OtherSource, color, message .. newRole)
                end

                local OtherIdentity = vRP.Identity(OtherId)
                local OtherName = OtherIdentity["name"] .. " " .. OtherIdentity["name2"]

                local message = "Você promoveu o integrante "
                if Type == "Demote" then
                    message = "Você rebaixou o integrante "
                end

                TriggerClientEvent("Notify", source, "verde", message .. OtherName .. " para " .. newRole .. " com sucesso.")

                vRP.SetPermission(OtherId, Permission, newHierarchy)

                return { newRole, newHierarchy }
            end

            return false
        end

        return false
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMISS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismiss(OtherId)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Data = Panels[Passport]
        if Data then
            local Permission = Data[1]
            local PlayerHierarchy = Data[2]
            local Datatable = vRP.GetSrvData("Permissions:" .. Permission)
            local currentHierarchy = Datatable[tostring(OtherId)]
            if not (PlayerHierarchy < currentHierarchy) then
                TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para fazer isto.")

                return false
            end

            vRP.RemovePermission(OtherId, Permission)

            TriggerClientEvent("Notify", source, "verde", "O integrante foi demitido com sucesso.")

            local OtherSource = vRP.Source(OtherId)
            if OtherSource then
                TriggerClientEvent("Notify", OtherSource, "vermelho", "Você foi demitido da organização " .. Permission .. ".")
            end

            return true
        end

        return false
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Transactions(Id)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Permission = Panels[Passport][1]
        local BalanceData = vRP.GetSrvData("Balances:"..Permission)
        print(json.encode(BalanceData))
        local Balance = BalanceData["Value"] or 0
        local Transactions = vRP.Query("painel/List", { Permission = Permission, Limit = 12 }) or {}
        local result = { Balance = Balance, Transactions = Transactions }

        return result
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Deposit(Value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Active[Passport] == nil and parseInt(Value) > 0 then
        Active[Passport] = true
        local Permission = Panels[Passport][1]
        if Permission then
            local CurrentBalanceData = vRP.GetSrvData("Balances:"..Permission)
            local CurrentBalance = CurrentBalanceData["Value"] or 0
            if vRP.ConsultItem(Passport,"dollars",Value) and vRP.TakeItem(Passport,"dollars",Value) then
                vRP.Query("painel/Add", { Permission = Permission, Type = "entry", Value = Value })
                vRP.SetSrvData("Balances:"..Permission, { Value = CurrentBalance + Value }, true)

                TriggerClientEvent("Notify", source, "verde", "Depósito efetuado com sucesso.")

                Active[Passport] = nil
                return true
            end

            TriggerClientEvent("Notify", source, "vermelho", "Saldo insuficiente.")
            Active[Passport] = nil
            return false
        end

        Active[Passport] = nil
        return false
	end

    Active[Passport] = nil
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Withdraw(Value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Active[Passport] == nil and parseInt(Value) > 0 then
        Active[Passport] = true
        local Permission = Panels[Passport][1]
        if vRP.HasPermission(Passport, Permission, 1) then
            if Permission then
                local CurrentBalanceData = vRP.GetSrvData("Balances:"..Permission)
                local CurrentBalance = CurrentBalanceData["Value"] or 0
                if CurrentBalance >= Value then
                    vRP.Query("painel/Add", { Permission = Permission, Type = "exit", Value = Value })
                    vRP.SetSrvData("Balances:"..Permission, { Value = CurrentBalance - Value })
                    vRP.GenerateItem(Passport, "dollars", Value, true)

                    TriggerClientEvent("Notify", source, "verde", "Depósito efetuado com sucesso.")

                    Active[Passport] = nil
                    return true
                end

                TriggerClientEvent("Notify", source, "vermelho", "Saldo insuficiente.")
                Active[Passport] = nil
                return false
            end

            Active[Passport] = nil
            return false
        end

        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para fazer isto.")

        Active[Passport] = nil
        return false
	end

    Active[Passport] = nil
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy()
    local source = source
    TriggerClientEvent("Notify", source, "amarelo", "Em breve...", 2500)
end
vRP.Prepare("painel/List","SELECT * FROM painel WHERE Permission = @Permission ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("painel/Add","INSERT INTO painel(Permission,Type,Value) VALUES(@Permission,@Type,@Value)")
