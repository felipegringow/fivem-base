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
Tunnel.bindInterface("megazord",Creative)
GlobalState.Resources = Resources
GlobalState:set("Resources", GlobalState.Resources, true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Warning(Warn)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Warn then
        local Identity = vRP.Identity(Passport)
        if Identity then
            Discord("**Source:** " .. source .. [[

            **Passaporte:** ]] .. vRP.Passport(source) .. [[
            
            **Motivo:** ]] .. Warn .. [[
            
            **Address:** ]] .. GetPlayerEndpoint(source))
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPLOSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("explosionEvent", function(source, event)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and Explodes[event.explosionType] then
        Discord("**Source:** " .. source .. [[

        **Passaporte:** ]] .. vRP.Passport(source) .. [[
        
        **Motivo:** ]] .. Explodes[event.explosionType] .. [[
        
        **Address:** ]] .. GetPlayerEndpoint(source))
        
        CancelEvent()
    end
    -- if not GlobalState.ExplosionEvents[source] then
    --     GlobalState.ExplosionEvents[source] = {
    --         Count = 1,
    --         Time = os.time() + 10
    --     }
    -- else
    --     GlobalState.ExplosionEvents[source].Count = GlobalState.ExplosionEvents[source].Count + 1
    --     if os.time() >= GlobalState.ExplosionEvents[source].Time then
    --         GlobalState.ExplosionEvents[source] = nil
    --     elseif GlobalState.ExplosionEvents[source].Count >= 10 and Passport then
    --         Discord("**Source:** " .. source .. [[

    --         **Passaporte:** ]] .. vRP.Passport(source) .. [[
            
    --         **Motivo:** ExplosionEvents
            
    --         **Address:** ]] .. GetPlayerEndpoint(source))
    --         CancelEvent()
    --     end
    -- end                
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Discord
-----------------------------------------------------------------------------------------------------------------------------------------
function Discord(Message)
    PerformHttpRequest(
        Webhook,
        function(err, text, headers)
        end,
        "POST",
        json.encode(
            {
                username = "Megazord",
                embeds = {{color = 3092790, description = Message}}
            }
        ),
        {["Content-Type"] = "application/json"}
    )
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
	GlobalState:set("Resources",Resource,true)

	if "megazord" == Resource then
		print("Megazord autenticado com sucesso.")
	end 
end)