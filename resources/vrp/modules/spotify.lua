-----------------------------------------------------------------------------------------------------------------------------------------
-- SET:SPOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetSpotify(source)
    if Characters[source] then
        vRP.Query("accounts/setSpotify",{ license = Characters[source]["license"], spotify = os.time() + 2592000 })
        Characters[source]["spotify"] = parseInt(os.time() + 2592000)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADE:SPOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeSpotify(source)
    if Characters[source] then
        vRP.Query("accounts/updateSpotify",{ license = Characters[source]["license"] })
        Characters[source]["spotify"] = Characters[source]["spotify"] + 2592000
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER:SPOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserSpotify(Passport)
    local Source =  vRP.Source(Passport)
    local HasPermission = vRP.HasPermission(Passport,"Spotify")
    if Characters[Source] then
        if Characters[Source]["spotify"] < os.time() then
            if HasPermission then
                vRP.RemovePermission(Passport,"Spotify")
            end
            return false
        elseif not HasPermission then
            vRP.SetPermission(Passport,"Spotify")
        end
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSE:SPOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicenseSpotify(License)
    local Account = vRP.Account(License)
    if Account and Account["spotify"] >= os.time() then
        return true
    end
    return false
end