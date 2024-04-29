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
Tunnel.bindInterface("party",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Config = { 
    ["Rooms"] = {},
    ["RoomsAmount"] = 0,
    ["CurrentUsersRooms"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROOMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetRooms()
    local source = source 
    local Passport = vRP.Passport(source)
    if Passport then
        local Rooms = {}
        for Index,v in pairs(Config["Rooms"]) do
            Rooms[#Rooms + 1] = {
                ["Id"] = Index,
                ["Identity"] = v["Identity"],
                ["Name"] = v["Name"],
                ["Password"] = v["Password"] or false,
                ["Users"] = CountTable(v["Users"])
            }
        end

        return {
            ["group"] = Config["CurrentUsersRooms"][Passport] or false,
            ["room"] = Rooms
        }
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMEMBERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetMembers(Number)
    local source = source 
    local Passport = vRP.Passport(source)
    if Passport and Config["Rooms"][Number] and Config["Rooms"][Number]["Users"] then
        local Room = {}
        for OtherPassport,v in pairs(Config["Rooms"][Number]["Users"]) do
            local Identity = vRP.Identity(OtherPassport)
            Room[#Room + 1] = {
                ["Id"] = OtherPassport,
                ["Name"] = Identity["name"].. " " ..Identity["name2"],
                ["Passport"] = OtherPassport
            }
        end

        return {
            ["Id"] = Number,
            ["Members"] = Room,
            ["Created"] = Config["Rooms"][Number]["Created"],
            ["Identity"] = Config["Rooms"][Number]["Identity"],
            ["Name"] = Config["Rooms"][Number]["Name"],
            ["Users"] = CountTable(Config["Rooms"][Number]["Users"])
        }
    end 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateRoom(Name,Password)
    local source = source 
    local Passport = vRP.Passport(source)
    if Passport and not Config["CurrentUsersRooms"][Passport] then
        Config["RoomsAmount"] = Config["RoomsAmount"] + 1

        Config["Rooms"][Config["RoomsAmount"]] = {
            ["Id"] = Config["RoomsAmount"],
            ["Created"] = Passport,
            ["Identity"] = vRP.Identity(Passport).name.. "  "..vRP.Identity(Passport).name2,
            ["Name"] = Name, 
            ["Password"] = Password,
            ["Users"] = {
                [Passport] = source
            }
        }

        Config["CurrentUsersRooms"][Passport] = Config["RoomsAmount"]
        TriggerClientEvent("party:ResetNui", source)
        return { 
            ["room"] = Config["Rooms"][Config["RoomsAmount"]]
        }
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVEROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.LeaveRoom(s)
    local source = source or s
    local Passport = vRP.Passport(source)
    local Number = Config["CurrentUsersRooms"][Passport] 

    if Passport and Number then
        Config["Rooms"][Number]["Users"][Passport] = nil
        Config["CurrentUsersRooms"][Passport] = nil 

        if CountTable(Config["Rooms"][Number]["Users"]) < 1 then 
            Config["Rooms"][Number] = nil
        end

        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.EnterRoom(Number)
    local source = source 
    local Passport = vRP.Passport(source)

    if Passport and not Config["CurrentUsersRooms"][Passport] then
        Config["Rooms"][Number]["Users"][Passport] = source
        Config["CurrentUsersRooms"][Passport] = Number 

        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKROOM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.KickRoom(Number,Id)
    local source = source 
    local Passport = vRP.Passport(source)
    local Room = Config["Rooms"][Number]
    if Passport and Room["Created"] == Passport and Room["Users"][Id] and Id ~= Passport then       
        Room["Users"][Id] = nil
        Config["CurrentUsersRooms"][Id] = nil 

        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
    local source = source

    Creative.LeaveRoom(source)
end)