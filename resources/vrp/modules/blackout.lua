-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Blackout()
    if GlobalState.Blackout then
        SetTimeout(BlackoutTime, function()
            GlobalState.Blackout = false
            TriggerClientEvent("Notify", -1, "azul", BlackoutText, "Central de Eletricidade", 10000)
        end)
    end
end