-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
    { ["Name"] = "Policia",          ["Coords"] = vec3(-949.5, -2045.96, 9.4),     ["Mode"] = "1" }, -- DP do SUL
    { ["Name"] = "Judiciario",       ["Coords"] = vec3(-533.63, -193.97, 38.22),   ["Mode"] = "1" }, -- DP do SUL
    { ["Name"] = "Policia",          ["Coords"] = vec3(361.42, -1600.04, 25.44),   ["Mode"] = "1" }, -- Davis
    { ["Name"] = "PoliciaNorte",     ["Coords"] = vec3(-445.38, 6019.65, 37.38),   ["Mode"] = "1" }, -- DP do NORTE
    { ["Name"] = "PRF",              ["Coords"] = vec3(2609.04, 5344.4, 47.57),    ["Mode"] = "1" }, -- DP do NORTE
    { ["Name"] = "MecanicaNorte",    ["Coords"] = vec3(2726.31, 3505.42, 55.25),   ["Mode"] = "1" }, -- DP do NORTE
    { ["Name"] = "Civil",            ["Coords"] = vec3(831.09, -1304.07, 19.85),   ["Mode"] = "1" }, -- Civil
    { ["Name"] = "Paramedico",       ["Coords"] = vec3(-1869.77, -303.44, 49.47),  ["Mode"] = "2" },
    { ["Name"] = "Paramedico",       ["Coords"] = vec3(-261.46, 6312.02, 32.42),   ["Mode"] = "2" },
    { ["Name"] = "Burgershot",       ["Coords"] = vec3(-1196.71, -901.33, 13.88),  ["Mode"] = "2" },
    { ["Name"] = "BurgershotTray01", ["Coords"] = vec3(-1190.85, -894.39, 14.05),  ["Mode"] = "3" },
    { ["Name"] = "BurgershotTray02", ["Coords"] = vec3(-1192.82, -893.83, 14.0),   ["Mode"] = "3" },
    { ["Name"] = "BurgershotTray03", ["Coords"] = vec3(-1194.79, -893.33, 14.04),  ["Mode"] = "3" },
    { ["Name"] = "BurgershotTray04", ["Coords"] = vec3(-1196.81, -892.8, 14.08),   ["Mode"] = "3" },
    { ["Name"] = "Bennys",           ["Coords"] = vec3(834.03, -934.43, 26.47),    ["Mode"] = "2" },
    { ["Name"] = "Customs",          ["Coords"] = vec3(883.24, -2100.55, 30.46),   ["Mode"] = "2" },
    { ["Name"] = "Customs",          ["Coords"] = vec3(886.17, -2097.33, 34.88),   ["Mode"] = "4" },
    { ["Name"] = "Tuners",           ["Coords"] = vec3(146.11, -3007.79, 6.6),     ["Mode"] = "2" },
    { ["Name"] = "Tuners",           ["Coords"] = vec3(147.63, -3007.95, 10.7),    ["Mode"] = "4" },
    { ["Name"] = "Maconha",          ["Coords"] = vec3(1321.77, -182.69, 108.61),  ["Mode"] = "2" },
    { ["Name"] = "Maconha",          ["Coords"] = vec3(1258.45, -203.22, 105.55),  ["Mode"] = "4" },
    { ["Name"] = "Ecstasy",          ["Coords"] = vec3(2766.49, 2688.85, 60.36),   ["Mode"] = "2" },
    { ["Name"] = "Ecstasy",          ["Coords"] = vec3(2775.3, 2674.5, 59.45),     ["Mode"] = "4" },
    { ["Name"] = "Cocaina",          ["Coords"] = vec3(1312.2, -735.54, 66.27),    ["Mode"] = "2" },
    { ["Name"] = "Cocaina",          ["Coords"] = vec3(1341.28, -816.84, 85.93),   ["Mode"] = "4" },
    { ["Name"] = "Lean",             ["Coords"] = vec3(-1821.66, 4521.13, 5.27),   ["Mode"] = "2" },
    { ["Name"] = "Lean",             ["Coords"] = vec3(-1823.06, 4509.2, 5.29),    ["Mode"] = "4" },
    { ["Name"] = "Metanfetamina",    ["Coords"] = vec3(-1255.85, 2883.67, 50.67),  ["Mode"] = "2" },
    { ["Name"] = "Metanfetamina",    ["Coords"] = vec3(-1256.1, 2885.2, 47.26),    ["Mode"] = "4" },
    { ["Name"] = "Metanfetamina2",   ["Coords"] = vec3(1506.43, -2476.98, 72.62),  ["Mode"] = "2" },
    { ["Name"] = "Metanfetamina2",   ["Coords"] = vec3(1505.29, -2473.64, 80.05),  ["Mode"] = "4" },
    { ["Name"] = "Metanfetamina3",   ["Coords"] = vec3(960.37, -2391.32, 22.33),   ["Mode"] = "2" },
    { ["Name"] = "Metanfetamina3",   ["Coords"] = vec3(993.31, -2360.0, 21.21),    ["Mode"] = "4" },
    { ["Name"] = "Arma4",            ["Coords"] = vec3(2328.29, 4026.09, 40.95),   ["Mode"] = "2" },
    { ["Name"] = "Arma4",            ["Coords"] = vec3(2157.45, 3868.87, 34.95),   ["Mode"] = "4" },
    { ["Name"] = "Desmanche2",       ["Coords"] = vec3(1033.06, -2542.03, 32.28),  ["Mode"] = "2" },
    { ["Name"] = "Desmanche2",       ["Coords"] = vec3(1029.05, -2545.0, 28.29),   ["Mode"] = "4" },
    { ["Name"] = "Maconha2",         ["Coords"] = vec3(1046.06, 3330.4, 49.65),    ["Mode"] = "2" },
    { ["Name"] = "Maconha2",         ["Coords"] = vec3(1059.86, 3281.02, 48.60),   ["Mode"] = "4" },
    { ["Name"] = "Ilegal2",          ["Coords"] = vec3(-2940.73, 36.45, 11.61),    ["Mode"] = "2" },
    { ["Name"] = "Ilegal2",          ["Coords"] = vec3(-3028.65, 85.23, 12.82),    ["Mode"] = "4" },
    { ["Name"] = "Municao",          ["Coords"] = vec3(1401.87, 1132.26, 114.33),  ["Mode"] = "2" },
    { ["Name"] = "Municao",          ["Coords"] = vec3(1391.56, 1158.82, 114.33),  ["Mode"] = "4" },
    { ["Name"] = "Ilegal",           ["Coords"] = vec3(-1365.34, -617.06, 30.31),  ["Mode"] = "2" },
    { ["Name"] = "Ilegal",           ["Coords"] = vec3(-1368.19, -614.33, 30.31),  ["Mode"] = "4" },
    { ["Name"] = "Arma2",            ["Coords"] = vec3(-1886.51, 2062.4, 140.98),  ["Mode"] = "2" },
    { ["Name"] = "Arma2",            ["Coords"] = vec3(-1869.07, 2066.35, 140.97), ["Mode"] = "4" },
    { ["Name"] = "Arma",             ["Coords"] = vec3(-2670.75, 1336.28, 140.88), ["Mode"] = "2" },
    { ["Name"] = "Arma",             ["Coords"] = vec3(-2675.73, 1304.87, 152.15), ["Mode"] = "4" },
    { ["Name"] = "Lavagem",          ["Coords"] = vec3(1002.95, 56.48, 75.05),     ["Mode"] = "2" },
    { ["Name"] = "Lavagem",          ["Coords"] = vec3(997.8, 52.65, 75.07),       ["Mode"] = "4" },
    { ["Name"] = "Lavagem2",         ["Coords"] = vec3(121.71, -1279.83, 29.47),   ["Mode"] = "2" },
    { ["Name"] = "Lavagem2",         ["Coords"] = vec3(94.09, -1290.96, 29.27),    ["Mode"] = "4" },
    { ["Name"] = "Lavagem3",         ["Coords"] = vec3(-1793.48, 449.82, 128.5),   ["Mode"] = "2" },
    { ["Name"] = "Lavagem3",         ["Coords"] = vec3(-1795.59, 422.39, 125.21),  ["Mode"] = "4" },
    { ["Name"] = "Lavagem4",         ["Coords"] = vec3(401.66, 242.33, 92.05),     ["Mode"] = "2" },
    { ["Name"] = "Lavagem4",         ["Coords"] = vec3(399.93, 242.87, 92.05),     ["Mode"] = "4" },
    { ["Name"] = "Municao2",         ["Coords"] = vec3(388.26, -10.2, 86.68),      ["Mode"] = "2" },
    { ["Name"] = "Municao2",         ["Coords"] = vec3(397.46, 0.39, 84.92),       ["Mode"] = "4" },
    { ["Name"] = "Arma3",            ["Coords"] = vec3(542.05, -2783.06, 6.15),    ["Mode"] = "4" },
    { ["Name"] = "Arma3",            ["Coords"] = vec3(554.84, -2769.87, 6.08),    ["Mode"] = "2" },
    { ["Name"] = "Municao3",         ["Coords"] = vec3(354.48, -2711.7, 1.7),      ["Mode"] = "2" },
    { ["Name"] = "Municao3",         ["Coords"] = vec3(345.24, -2708.82, 1.7),     ["Mode"] = "4" },
    { ["Name"] = "Exercito",         ["Coords"] = vec3(-1798.21, 3102.95, 32.84),  ["Mode"] = "2" },
    { ["Name"] = "Ilegal3",          ["Coords"] = vec3(-1510.2, 840.56, 176.99),   ["Mode"] = "2" },
    { ["Name"] = "Ilegal3",          ["Coords"] = vec3(-1513.13, 835.17, 186.19),  ["Mode"] = "4" },
    { ["Name"] = "Ilegal4",          ["Coords"] = vec3(-391.04, 1620.41, 365.91),  ["Mode"] = "2" },
    { ["Name"] = "Ilegal4",          ["Coords"] = vec3(-347.44, 1523.27, 373.8),   ["Mode"] = "4" },
    { ["Name"] = "K92",              ["Coords"] = vec3(1736.3, -1586.67, 116.18),  ["Mode"] = "2" },
    { ["Name"] = "K92",              ["Coords"] = vec3(1737.45, -1591.59, 120.07), ["Mode"] = "4" },
    { ["Name"] = "Municao4",         ["Coords"] = vec3(-1474.87, -34.62, 57.9),    ["Mode"] = "2" },
    { ["Name"] = "Municao4",         ["Coords"] = vec3(-1473.7, -27.42, 57.9),     ["Mode"] = "4" },
    { ["Name"] = "Attachs",          ["Coords"] = vec3(-1200.51, 296.19, 69.72),   ["Mode"] = "2" },
    { ["Name"] = "Attachs",          ["Coords"] = vec3(-1183.04, 302.84, 73.67),   ["Mode"] = "4" },
    { ["Name"] = "Municao5",         ["Coords"] = vec3(-1030.73, 309.84, 71.66),   ["Mode"] = "2" },
    { ["Name"] = "Municao5",         ["Coords"] = vec3(-1047.23, 300.93, 71.66),   ["Mode"] = "4" },
    { ["Name"] = "Cocaina2",         ["Coords"] = vec3(-2360.87, 1758.8, 212.12),  ["Mode"] = "2" },
    { ["Name"] = "Cocaina2",         ["Coords"] = vec3(-2364.43, 1747.76, 215.48), ["Mode"] = "4" },
    { ["Name"] = "Lean2",            ["Coords"] = vec3(178.45, 674.21, 207.59),    ["Mode"] = "2" },
    { ["Name"] = "Lean2",            ["Coords"] = vec3(177.05, 679.31, 210.69),    ["Mode"] = "4" },
    { ["Name"] = "Lean3",            ["Coords"] = vec3(3196.84, 5193.57, 51.39),   ["Mode"] = "2" },
    { ["Name"] = "Lean3",            ["Coords"] = vec3(3272.13, 5155.96, 34.68),   ["Mode"] = "4" },
    { ["Name"] = "Arma5",            ["Coords"] = vec3(891.92, -3227.86, -98.23),  ["Mode"] = "2" },
    { ["Name"] = "Arma5",            ["Coords"] = vec3(885.16, -3212.87, -98.2),   ["Mode"] = "4" },
    { ["Name"] = "K9",               ["Coords"] = vec3(5010.62, -5757.28, 15.48),  ["Mode"] = "2" },
    { ["Name"] = "K9",               ["Coords"] = vec3(5014.38, -5751.28, 29.23),  ["Mode"] = "4" },
    { ["Name"] = "Arma6",            ["Coords"] = vec3(2341.26, 3307.44, 54.31),   ["Mode"] = "2" },
    { ["Name"] = "Arma6",            ["Coords"] = vec3(2280.15, 3323.94, 60.81),   ["Mode"] = "4" },
    { ["Name"] = "Arma7",            ["Coords"] = vec3(-298.5, 1846.69, 194.48),   ["Mode"] = "2" },
    { ["Name"] = "Arma7",            ["Coords"] = vec3(-296.88, 1850.68, 197.83),  ["Mode"] = "4" },
    { ["Name"] = "Municao6",         ["Coords"] = vec3(-905.45, -1447.91, 7.53),   ["Mode"] = "2" },
    { ["Name"] = "Municao6",         ["Coords"] = vec3(-875.76, -1458.34, 7.53),   ["Mode"] = "4" },
    { ["Name"] = "Cupula",           ["Coords"] = vec3(-1029.94, -433.58, 72.45),  ["Mode"] = "2" },
    { ["Name"] = "Ecstasy2",         ["Coords"] = vec3(-1704.93, 4362.53, 68.97),  ["Mode"] = "2" },
    { ["Name"] = "Ecstasy2",         ["Coords"] = vec3(-1700.5, 4366.65, 74.48),   ["Mode"] = "4" },
    { ["Name"] = "Arma8",            ["Coords"] = vec3(-1553.74, 81.17, 53.87),    ["Mode"] = "2" },
    { ["Name"] = "Arma8",            ["Coords"] = vec3(-1545.61, 136.17, 60.79),   ["Mode"] = "4" },
    { ["Name"] = "Arma9",            ["Coords"] = vec3(-84.71, 1004.97, 234.4),    ["Mode"] = "2" },
    { ["Name"] = "Arma9",            ["Coords"] = vec3(-85.81, 995.13, 234.4),     ["Mode"] = "4" },
    { ["Name"] = "Municao7",         ["Coords"] = vec3(501.29, -896.37, 9.18),     ["Mode"] = "2" },
    { ["Name"] = "Municao7",         ["Coords"] = vec3(477.97, -916.32, 9.07),     ["Mode"] = "4" },
    { ["Name"] = "Lavagem5",         ["Coords"] = vec3(-3194.87, 834.7, 8.96),     ["Mode"] = "2" },
    { ["Name"] = "Lavagem5",         ["Coords"] = vec3(-3236.12, 817.09, 14.1),    ["Mode"] = "4" },
    { ["Name"] = "Bombeiro",         ["Coords"] = vec3(-1676.03, 50.95, 63.34),    ["Mode"] = "4" },
    { ["Name"] = "Maconha3",         ["Coords"] = vec3(-715.16, 631.8, 159.18),    ["Mode"] = "2" },
    { ["Name"] = "Maconha3",         ["Coords"] = vec3(-693.71, 642.99, 159.18),   ["Mode"] = "4" },
    --Casas
    { ["Name"] = "Mansao1",          ["Coords"] = vec3(-555.49, 807.96, 197.55),   ["Mode"] = "Home" },
    -- { ["Name"] = "Mansao2",          ["Coords"] = vec3(-715.16, 631.8, 159.18),    ["Mode"] = "Home" },
    { ["Name"] = "Mansao3",          ["Coords"] = vec3(-96.48, 829.05, 231.33),    ["Mode"] = "Home" }, -- nao  foi adicionado
    { ["Name"] = "Mansao4",          ["Coords"] = vec3(-525.86, 507.0, 108.07),    ["Mode"] = "Home" },
    -- { ["Name"] = "Mansao5",          ["Coords"] = vec3(-84.69, 1005.02, 234.4),    ["Mode"] = "Home" },
    { ["Name"] = "Mansao6",          ["Coords"] = vec3(-763.49, 813.21, 216.99),   ["Mode"] = "Home" },
    { ["Name"] = "Mansao8",          ["Coords"] = vec3(-1125.86, 362.99, 74.93),   ["Mode"] = "Home" },
    { ["Name"] = "Mansao9",          ["Coords"] = vec3(-810.22, 257.69, 82.8),     ["Mode"] = "Home" },
    { ["Name"] = "Mansao17",         ["Coords"] = vec3(-298.1, -730.64, 125.46),   ["Mode"] = "Home" },
    { ["Name"] = "Mansao11",         ["Coords"] = vec3(-2715.61, -65.76, 21.74),   ["Mode"] = "Home" },
    { ["Name"] = "Mansao13",         ["Coords"] = vec3(-2617.75, 1715.07, 142.36), ["Mode"] = "Home" },
    { ["Name"] = "Mansao14",         ["Coords"] = vec3(-854.24, -35.61, 40.56),    ["Mode"] = "Home" },

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
    ["1"] = {
        {
            event = "chest:Open",
            label = "Compartimento Geral",
            tunnel = "shop",
            service = "Normal"
        }, {
        event = "chest:Open",
        label = "Compartimento Pessoal",
        tunnel = "shop",
        service = "Personal"
    }
    },
    ["2"] = {
        {
            event = "chest:Open",
            label = "Abrir",
            tunnel = "shop",
            service = "Normal"
        }
    },
    ["3"] = {
        {
            event = "chest:Open",
            label = "Abrir",
            tunnel = "shop",
            service = "Tray"
        }
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    for Name, v in pairs(Chests) do
        exports["target"]:AddCircleZone("Chest:" .. Name, v["Coords"], 0.25, {
            name = "Chest:" .. Name,
            heading = 0.0,
            useZ = true
        }, {
            Distance = 1.35,
            shop = v["Name"],
            options = Labels[v["Mode"]]
        })
    end
end)

CreateThread(function()
    local Tables = {}
    for Name, v in pairs(Chests) do
        Tables[#Tables + 1] = { v["Coords"]["x"], v["Coords"]["y"], v["Coords"]["z"], 1.5, "E", "Baú",
            "Pressione para abrir" }
    end
    TriggerEvent("hoverfy:Insert", Tables)
end)

CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local idle = 999
        for k, v in pairs(Chests) do
            local Distance = GetDistanceBetweenCoords(Coords, v["Coords"], true)
            if Distance <= 1.5 then
                idle = 1
                if v["Mode"] == '4' then
                    exports["markers"]:CustomMarker("chestlider", v["Coords"])
                else
                    exports["markers"]:CustomMarker("chest", v["Coords"])
                end
                if IsControlJustPressed(0, 38) then
                    if vSERVER.ChestPermissions(v["Name"], v["Mode"]) then
                        TriggerEvent("chest:openSystem", v["Name"], v["Mode"], k)
                    end
                end
            end
        end
        Wait(idle)
    end
end)

RegisterNetEvent('chest:openSystem')
AddEventHandler("chest:openSystem", function(Name, Mode, Id)
    chestOpen = Name
    chestId = Id
    setChestData(chestOpen)
end)

function setChestData(Chest)
    local chestData, chestWeight = vSERVER.openStackChest(Chest)
    SendNUIMessage({
        action = "setOtherInventory",
        payload = {
            title = "Baú",
            weight = chestWeight,
            inventory = chestData,
            slots = 90
        }
    })
    ExecuteCommand("moc")
end
