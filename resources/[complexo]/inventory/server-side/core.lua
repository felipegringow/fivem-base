-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("inventory", Creative)
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vTASKBAR = Tunnel.getInterface("taskbar")
vDELIVER = Tunnel.getInterface("deliver")
vCLIENT = Tunnel.getInterface("inventory")
vMEMORY = Tunnel.getInterface("memory")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
vT3LOCK = Tunnel.getInterface("t3_lockpick")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drops = {}
Drugs = {}
Carry = {}
Ammos = {}
Loots = {}
Boxes = {}
Active = {}
Trashs = {}
Armors = {}
Plates = {}
Trunks = {}
Healths = {}
Whistle = {}
Animals = {}
Attachs = {}
Pumpjack = {}
Scanners = {}
Temporary = {}
AtmTimers = {}
Dismantle = {}
Registers = {}
TheftTimers = {}
verifyObjects = {}
verifyAnimals = {}
Channels = {}
Electricity = {}
ScubedPlayers = {}
slots = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
DrugsList = {
	["cokesack"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
	["meth"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
	["joint"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
	["lean"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
	["ecstasy"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
	["k9"] = {
		Price = { ["Min"] = 1050, ["Max"] = 1300 },
		Amount = { ["Min"] = 3, ["Max"] = 7 }
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {
	["1"] = { x = 594.59, y = 146.52, z = 97.30, h = 70.04, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["2"] = { x = 660.44, y = 268.29, z = 102.04, h = 152.09, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["3"] = { x = 552.54, y = -198.45, z = 53.75, h = 89.32, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["4"] = { x = 339.75, y = -580.95, z = 73.42, h = 67.19, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["5"] = { x = 696.12, y = -965.69, z = 23.26, h = 271.33, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["6"] = { x = -2235.42, y = 363.52, z = 173.91, h = 23.73, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["7"] = { x = 1382.1, y = -2081.97, z = 51.25, h = 220.16, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["8"] = { x = 589.32, y = -2802.73, z = 5.32, h = 328.01, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["9"] = { x = -453.19, y = -2810.47, z = 6.56, h = 225.82, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["10"] = { x = -1007.18, y = -2836.12, z = 13.20, h = 149.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["11"] = { x = -2018.21, y = -361.03, z = 47.36, h = 324.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["12"] = { x = -1727.77, y = 250.26, z = 61.65, h = 24.7, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["13"] = { x = -1089.6, y = 2717.05, z = 18.33, h = 40.52, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["14"] = { x = 321.27, y = 2874.98, z = 42.71, h = 27.62, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["15"] = { x = 1163.47, y = 2722.09, z = 37.26, h = 179.11, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["16"] = { x = 1745.86, y = 3326.69, z = 40.30, h = 115.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["17"] = { x = 2013.4, y = 3934.36, z = 31.65, h = 236.38, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["18"] = { x = 2526.3, y = 4191.6, z = 44.53, h = 236.44, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["19"] = { x = 2874.05, y = 4861.57, z = 61.35, h = 87.57, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["20"] = { x = 1985.16, y = 6200.39, z = 41.33, h = 330.21, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["21"] = { x = 1552.97, y = 6610.24, z = 2.12, h = 145.64, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["22"] = { x = -298.32, y = 6392.66, z = 29.87, h = 302.99, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["23"] = { x = -813.88, y = 5384.45, z = 33.77, h = 356.87, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["24"] = { x = -1606.5, y = 5259.26, z = 1.35, h = 114.45, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["25"] = { x = -199.22, y = 3638.8, z = 63.70, h = 39.84, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["26"] = { x = -1487.45, y = 2688.99, z = 2.94, h = 317.89, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["27"] = { x = -3266.12, y = 1139.82, z = 1.91, h = 249.17, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["28"] = { x = 170.71, y = -1070.94, z = 28.5, h = 339.6, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["29"] = { x = 487.23, y = -1093.93, z = 28.71, h = 0.74, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["30"] = { x = 584.63, y = -1419.69, z = 18.52, h = 180.41, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["31"] = { x = 694.07, y = -1453.5, z = 19.03, h = 0.45, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["32"] = { x = 892.49, y = -2490.3, z = 28.88, h = 175.48, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["33"] = { x = 1463.09, y = -2613.91, z = 48.17, h = 76.65, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["34"] = { x = 1877.42, y = -1065.71, z = 80.22, h = 97.79, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["35"] = { x = 2557.67, y = -598.5, z = 64.23, h = 12.71, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["36"] = { x = 2546.8, y = 395.31, z = 107.92, h = 268.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["37"] = { x = 2074.59, y = 1403.29, z = 74.88, h = 300.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["38"] = { x = 2405.44, y = 2903.85, z = 39.67, h = 217.41, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["39"] = { x = 2895.84, y = 3735.4, z = 43.5, h = 289.37, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["40"] = { x = 1677.25, y = 4882.36, z = 46.62, h = 59.7, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["41"] = { x = -437.08, y = 6339.84, z = 12.06, h = 216.59, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["42"] = { x = 431.15, y = 6472.57, z = 28.08, h = 140.5, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["43"] = { x = -2303.74, y = 3389.16, z = 30.56, h = 324.26, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["44"] = { x = -2096.92, y = 3258.17, z = 32.12, h = 239.97, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["45"] = { x = -1773.55, y = 2995.46, z = 32.11, h = 330.02, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["46"] = { x = -2086.61, y = 2816.89, z = 32.27, h = 354.52, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },
	["47"] = { x = -1511.83, y = 1520.27, z = 114.59, h = 255.31, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode =
	"Medic" },

	["48"] = { x = 574.01, y = 132.56, z = 98.48, h = 70.99, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["49"] = { x = 344.79, y = 929.2, z = 202.44, h = 268.09, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["50"] = { x = -123.8, y = 1896.67, z = 196.34, h = 358.95, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["51"] = { x = -1099.85, y = 2703.51, z = 21.99, h = 221.35, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["52"] = { x = -2198.91, y = 4243.21, z = 46.92, h = 128.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["53"] = { x = -1487.02, y = 4983.14, z = 62.67, h = 174.11, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["54"] = { x = 1346.49, y = 6396.73, z = 32.42, h = 90.94, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["55"] = { x = 2535.72, y = 4661.39, z = 33.08, h = 316.4, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["56"] = { x = 1155.62, y = -1334.48, z = 33.72, h = 174.97, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["57"] = { x = 1116.06, y = -2498.07, z = 32.37, h = 193.39, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["58"] = { x = 261.06, y = -3135.82, z = 4.8, h = 88.83, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["59"] = { x = -1619.81, y = -1035.0, z = 12.16, h = 50.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["60"] = { x = -3420.87, y = 977.0, z = 10.91, h = 226.29, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["61"] = { x = -1909.53, y = 4624.93, z = 56.07, h = 135.57, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["62"] = { x = 894.51, y = 3211.45, z = 38.09, h = 273.04, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["63"] = { x = 1791.71, y = 4602.84, z = 36.69, h = 185.86, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["64"] = { x = 464.8, y = 6462.03, z = 28.76, h = 334.71, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["65"] = { x = 63.22, y = 6323.67, z = 37.87, h = 301.22, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["66"] = { x = -736.64, y = 5594.98, z = 40.66, h = 268.78, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["67"] = { x = 720.76, y = 2330.87, z = 50.76, h = 179.99, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["68"] = { x = 1909.47, y = 611.47, z = 177.41, h = 65.57, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["69"] = { x = 1796.6, y = -1350.06, z = 98.75, h = 61.5, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["70"] = { x = 955.32, y = -3101.26, z = 4.91, h = 266.38, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["71"] = { x = -1306.41, y = -3387.9, z = 12.95, h = 59.92, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["72"] = { x = -1219.66, y = -2079.82, z = 13.16, h = 351.04, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["73"] = { x = -1203.53, y = -1804.25, z = 2.91, h = 245.4, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["74"] = { x = -720.47, y = -399.49, z = 33.9, h = 351.27, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["75"] = { x = -503.39, y = -1438.17, z = 13.16, h = 346.71, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["76"] = { x = 1398.24, y = 2117.57, z = 104.02, h = 131.36, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["77"] = { x = -1811.62, y = 3104.09, z = 31.85, h = 60.36, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["78"] = { x = -1812.86, y = 3101.95, z = 31.85, h = 62.1, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["79"] = { x = -1850.29, y = 3156.66, z = 31.82, h = 150.22, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["80"] = { x = -2052.86, y = 3173.31, z = 31.82, h = 240.03, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["81"] = { x = -2409.94, y = 3355.95, z = 31.83, h = 61.29, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },
	["82"] = { x = -2450.39, y = 2946.63, z = 31.97, h = 330.0, object = "prop_mb_crate_01a", item = "", Distance = 50, mode =
	"Weapons" },

	["83"] = { x = -257.5, y = -966.54, z = 30.22, h = 26.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["84"] = { x = -2682.86, y = 2304.87, z = 20.85, h = 164.19, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["85"] = { x = -1282.33, y = 2559.98, z = 17.4, h = 148.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["86"] = { x = 159.65, y = 3118.8, z = 42.44, h = 16.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["87"] = { x = 1061.43, y = 3527.62, z = 33.15, h = 255.93, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["88"] = { x = 2370.22, y = 3156.55, z = 47.21, h = 221.77, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["89"] = { x = 2520.51, y = 2637.83, z = 36.95, h = 314.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["90"] = { x = 2572.37, y = 477.44, z = 107.68, h = 269.49, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["91"] = { x = 1223.15, y = -1079.56, z = 37.53, h = 123.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["92"] = { x = 1048.49, y = -247.53, z = 68.66, h = 149.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["93"] = { x = 499.41, y = -529.38, z = 23.76, h = 262.13, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["94"] = { x = 592.53, y = -2115.87, z = 4.76, h = 100.96, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["95"] = { x = 523.43, y = -2578.67, z = 13.82, h = 318.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["96"] = { x = -2.98, y = -1299.67, z = 28.28, h = 359.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["97"] = { x = 183.11, y = -1086.93, z = 28.28, h = 348.57, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["98"] = { x = 713.88, y = -850.95, z = 23.3, h = 271.63, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["99"] = { x = -2438.82, y = 2999.82, z = 32.07, h = 194.35, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["100"] = { x = -2440.04, y = 2999.46, z = 32.07, h = 194.41, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["101"] = { x = -2092.59, y = 3113.14, z = 31.82, h = 240.25, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["102"] = { x = -1824.95, y = 3016.0, z = 31.82, h = 329.62, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["103"] = { x = -202.03, y = 3651.99, z = 50.74, h = 192.39, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["104"] = { x = -203.41, y = 3651.71, z = 50.74, h = 192.96, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["105"] = { x = 2007.81, y = 4964.86, z = 40.71, h = 158.28, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["106"] = { x = 1904.26, y = 4930.73, z = 47.97, h = 156.61, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["107"] = { x = 1702.14, y = 4819.3, z = 40.96, h = 97.05, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["108"] = { x = 2030.66, y = 4727.43, z = 40.61, h = 294.35, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["109"] = { x = 2122.12, y = 4784.69, z = 39.98, h = 116.71, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["110"] = { x = 2177.23, y = 2169.39, z = 116.31, h = 229.64, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["111"] = { x = 2395.2, y = 2032.72, z = 90.35, h = 318.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["112"] = { x = 2619.31, y = 1691.36, z = 26.6, h = 270.01, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["113"] = { x = 1454.52, y = -1680.69, z = 65.03, h = 25.31, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["114"] = { x = 1453.05, y = -1681.37, z = 64.96, h = 24.93, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["115"] = { x = 240.42, y = -1864.8, z = 25.82, h = 49.31, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["116"] = { x = -139.01, y = -1995.56, z = 21.81, h = 181.56, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["117"] = { x = -343.54, y = -1333.09, z = 36.31, h = 89.4, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["118"] = { x = -350.99, y = -1333.15, z = 36.31, h = 269.98, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["119"] = { x = -346.45, y = -1337.38, z = 36.31, h = 359.9, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },
	["120"] = { x = -267.45, y = -971.56, z = 30.22, h = 25.86, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode =
	"Supplies" },

	-- ROBBERY CLOTHESHOP
	["121"] = { x = 70.27, y = -1389.11, z = 29.13, h = 90.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["122"] = { x = -706.01, y = -150.49, z = 37.17, h = 28.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["123"] = { x = -167.66, y = -301.67, z = 39.49, h = 161.34, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["124"] = { x = -821.69, y = -1067.22, z = 11.08, h = 31.23, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["125"] = { x = -1186.62, y = -772.55, z = 17.09, h = 215.93, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["126"] = { x = -1446.85, y = -240.38, z = 49.57, h = 316.88, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["127"] = { x = 5.53, y = 6506.07, z = 31.63, h = 222.68, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["128"] = { x = 1699.51, y = 4819.72, z = 41.82, h = 277.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["129"] = { x = 117.83, y = -223.56, z = 54.31, h = 70.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["130"] = { x = 621.58, y = 2765.81, z = 41.84, h = 275.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["131"] = { x = 1200.46, y = 2715.37, z = 37.98, h = 0.24, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["132"] = { x = -3178.48, y = 1044.46, z = 20.62, h = 66.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["133"] = { x = -1102.05, y = 2716.93, z = 18.86, h = 40.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["134"] = { x = 430.72, y = -810.01, z = 29.25, h = 270.35, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY WEAPONSSHOP
	["135"] = { x = 1688.78, y = 3759.13, z = 34.46, h = 47.5, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["136"] = { x = 256.35, y = -47.51, z = 69.7, h = 249.76, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["137"] = { x = 846.13, y = -1036.62, z = 27.95, h = 178.74, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["138"] = { x = -335.18, y = 6083.29, z = 31.21, h = 45.57, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["139"] = { x = -665.98, y = -932.24, z = 21.58, h = 358.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["140"] = { x = -1301.93, y = -391.36, z = 36.45, h = 255.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["141"] = { x = -1122.59, y = 2698.25, z = 18.31, h = 42.82, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["142"] = { x = 2571.67, y = 291.28, z = 108.49, h = 180.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["143"] = { x = 2571.66, y = 291.29, z = 108.49, h = 181.06, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["144"] = { x = 19.57, y = -1103.0, z = 29.55, h = 339.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["145"] = { x = 813.92, y = -2160.34, z = 29.37, h = 179.33, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY BARBERSHOP
	["146"] = { x = -807.9, y = -180.83, z = 37.32, h = 299.3, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["147"] = { x = 139.56, y = -1704.12, z = 29.05, h = 320.25, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["148"] = { x = -1278.11, y = -1116.66, z = 6.75, h = 270.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["149"] = { x = 1928.89, y = 3734.04, z = 32.6, h = 29.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["150"] = { x = 1217.05, y = -473.45, z = 65.96, h = 255.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["151"] = { x = -34.08, y = -157.01, z = 56.83, h = 159.63, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["152"] = { x = -274.5, y = 6225.27, z = 31.45, h = 225.27, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY TATTOOSHOP
	["153"] = { x = 1327.98, y = -1654.78, z = 52.03, h = 218.71, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["154"] = { x = -1149.04, y = -1428.64, z = 4.71, h = 215.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["155"] = { x = 322.01, y = 186.24, z = 103.34, h = 339.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["156"] = { x = -3175.64, y = 1075.54, z = 20.58, h = 65.96, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["157"] = { x = 1866.01, y = 3748.07, z = 32.79, h = 299.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["158"] = { x = -295.51, y = 6199.21, z = 31.24, h = 133.05, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- OTHER OBJECTS
	["9998"] = { x = -584.12, y = -1062.95, z = 22.38, h = 33.14, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 },
	["9999"] = { x = -1188.9, y = -897.82, z = 13.95, h = 130.04, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 }
}

local craftList = {
	["lixeiroShop"] = {
        ["list"] = {
            ["glass"] = {
                ["amount"] = 5,
                ["destroy"] = false,
                ["require"] = {
                    ["glassbottle"] = 1
                }
            },
            ["plastic"] = {
                ["amount"] = 5,
                ["destroy"] = false,
                ["require"] = {
                    ["plasticbottle"] = 1
                }
            },
            ["rubber"] = {
                ["amount"] = 5,
                ["destroy"] = false,
                ["require"] = {
                    ["elastic"] = 1
                }
            },
            ["aluminum"] = {
                ["amount"] = 5,
                ["destroy"] = false,
                ["require"] = {
                    ["metalcan"] = 1
                }
            },
            ["copper"] = {
                ["amount"] = 5,
                ["destroy"] = false,
                ["require"] = {
                    ["battery"] = 1
                }
            }
        }
    },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["paper"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "woodlog", ["amount"] = 3 }
			},
			["needAmount"] = 1,
			["item"] = "paper",
			["itemAmount"] = 1
		}
	},
	["tablecoke"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "sulfuric", ["amount"] = 1 },
				{ ["item"] = "cokebud",  ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "cocaine",
			["itemAmount"] = 3
		}
	},
	["tablemeth"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "saline",  ["amount"] = 1 },
				{ ["item"] = "acetone", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "meth",
			["itemAmount"] = 3
		}
	},
	["tableweed"] = {
		{
			["timer"] = 20,
			["need"] = {
				{ ["item"] = "silk",    ["amount"] = 1 },
				{ ["item"] = "weedbud", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "joint",
			["itemAmount"] = 1
		}
	},
	["milkBottle"] = {
		{ ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		{ ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "roadsigns",  ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "syringe",    ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plate",      ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "aluminum",   ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "copper",     ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "lighter",    ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "battery",    ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "metalcan",   ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		{ ["timer"] = 5, ["item"] = "silk",               ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cotton",             ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plaster",            ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "pouch",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "WEAPON_SWITCHBLADE", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "joint",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "acetone",            ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "slipper",            ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "water",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "copper",             ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cigarette",          ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "lighter",            ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "elastic",            ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "rose",               ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "teddy",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "binoculars",         ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "camera",             ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "silvercoin",         ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "goldcoin",           ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "watch",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "bracelet",           ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "WEAPON_BRICK",       ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "WEAPON_SHOES",       ["itemAmount"] = 2 },
		{ ["timer"] = 5, ["item"] = "dices",              ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cup",                ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		{ ["timer"] = 10, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		{ ["timer"] = 10, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		{ ["timer"] = 10, ["need"] = "meat", ["needAmount"] = 1, ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		{ ["timer"] = 2, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "water", ["itemAmount"] = 1 }
	},
	["packagebox"] = {
		{ ["timer"] = 5, ["item"] = "packagebox", ["itemAmount"] = 1 }
	},
	["foodjuice"] = {
		{ ["timer"] = 10, ["item"] = "foodjuice", ["itemAmount"] = 1 }
	},
	["foodburger"] = {
		{ ["timer"] = 10, ["item"] = "foodburger", ["itemAmount"] = 1 }
	},
	["foodbox"] = {
		{
			["timer"] = 10,
			["need"] = {
				{ ["item"] = "foodjuice",  ["amount"] = 1 },
				{ ["item"] = "foodburger", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "foodbox",
			["itemAmount"] = 1
		}
	},
	["foodboxtoy"] = {
		{
			["timer"] = 10,
			["need"] = {
				{ ["item"] = "drugtoy", ["amount"] = 1 }
			},
			["needAmount"] = 1,
			["item"] = "foodboxtoy",
			["itemAmount"] = 1
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
StealPeds = {
	{ ["Item"] = "dollars2", ["Min"] = 250, ["Max"] = 350 },
	{ ["Item"] = "dollars2", ["Min"] = 450, ["Max"] = 650 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
StealItens = {
	{ ["Item"] = "dollars2", ["Min"] = 250, ["Max"] = 350 },
	{ ["Item"] = "dollars2", ["Min"] = 450, ["Max"] = 650 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
LootItens = {
	["Medic"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "alcohol",     ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "codeine",     ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "amphetamine", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "acetone",     ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "saline",      ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sulfuric",    ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "syringe",     ["min"] = 2, ["max"] = 4 }
		}
	},
	["Weapons"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "roadsigns",  ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "techtrash",  ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sheetmetal", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "explosives", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "aluminum",   ["min"] = 6, ["max"] = 8 },
			{ ["item"] = "copper",     ["min"] = 6, ["max"] = 8 }
		}
	},
	["Supplies"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "tarp",       ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "techtrash",  ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sheetmetal", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "roadsigns",  ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "sulfuric",   ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "saline",     ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "alcohol",    ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "explosives", ["min"] = 2, ["max"] = 4 },
			{ ["item"] = "aluminum",   ["min"] = 4, ["max"] = 8 },
			{ ["item"] = "copper",     ["min"] = 4, ["max"] = 8 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSINFLUENCE
-----------------------------------------------------------------------------------------------------------------------------------------
DrugsInfluence = {
	{ -224.18,  123.53,   69.67, 250 },
	{ 994.01,   -1771.79, 31.78, 250 },
	{ 388.3,    2650.57,  44.48, 250 },
	{ -216.42,  6317.71,  31.49, 250 },
	{ -930.63,  -2033.11, 19.9,  250 },
	{ -2189.11, 3172.74,  37.32, 250 },
	{ 849.31,   -1296.38, 18.97, 250 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MICROSCOPE
-----------------------------------------------------------------------------------------------------------------------------------------
Microscope = {
	{ 482.95,  -988.61,  30.68 },
	{ 312.47,  -562.1,   43.29 },
	{ 368.33,  -1592.01, 25.44 },
	{ 1772.18, 2577.82,  45.73 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inv = {}
		local Inventory = vRP.Inventory(Passport)
		for Index, v in pairs(Inventory) do
			if (parseInt(v["amount"]) <= 0 or not itemBody(v["item"])) then
				vRP.RemoveItem(Passport, v["item"], parseInt(v["amount"]), false)
			else
				v["amount"] = parseInt(v["amount"])
				v["name"] = itemName(v["item"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["max"] = itemMaxAmount(v["item"])
				v["desc"] = itemDescription(v["item"])
				v["economy"] = parseFormat(itemEconomy(v["item"]))
				v["key"] = v["item"]
				v["slot"] = Index

				local Split = splitString(v["item"], "-")
				if Split[2] ~= nil then
					if Split[1] == "identity" or Split[1] == "fidentity" or string.sub(v["item"], 1, 5) == "badge" then
						local Number = parseInt(Split[2])
						local Identity = vRP.Identity(Number)

						if Split[1] == "fidentity" then
							Identity = vRP.FalseIdentity(Number)
						end

						if Identity then
							v["idPort"] = "Não"
							v["Passport"] = Number
							v["idPremium"] = "Nenhum"
							v["idRolepass"] = "Inativo"
							v["idMedicPlan"] = "Inativo"
							v["idBlood"] = Sanguine(Identity["blood"])
							v["idName"] = Identity["name"] .. " " .. Identity["name2"]

							if Number == Passport and Split[1] == "identity" then
								if Identity["premium"] > os.time() then
									v["idPremium"] = MinimalTimers(Identity["premium"] - os.time())
								end

								if Identity["rolepass"] > 0 then
									v["idRolepass"] = "Ativo"
								end

								if Identity["gunlicense"] == 1 then
									v["idPort"] = "Sim"
								end
							end
						end
					end

					if Split[1] == "bankcard" then
						v["desc"] = "Saldo bancário disponível: <green>$" ..
							parseFormat(vRP.GetBank(source)) .. "</green>."
					end

					if Split[1] == "vehkey" then
						v["Vehkey"] = Split[2]
					end

					if Split[1] == "notepad" and Split[2] then
						v["desc"] = vRP.GetSrvData(v["item"])
					end

					if Split[1] == "paper" and Split[2] then
						v["desc"] = vRP.GetSrvData(v["item"])
					end

					if Split[1] == "suitcase" then
						v["Suitcase"] = parseFormat(Split[2])
					end

					if itemType(Split[1]) == "Armamento" and Split[3] then
						if not v["desc"] then
							v["desc"] = "<br><description>Nome de registro: <green>" .. vRP.FullName(Split[3]) ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Nome de registro: <green>" .. vRP.FullName(Split[3]) ..
								"</green>.</description>"
						end
					end


					if Split[1] == "silverring" then
						if not v["desc"] then
							v["desc"] = "<br><description>Namorando com: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Namorando com: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						end
					end

					if Split[1] == "oab" then
						if not v["desc"] then
							v["desc"] = "<br><description>OAB gerada por: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>OAB gerada por: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						end
					end

					if Split[1] == "goldring" then
						if not v["desc"] then
							v["desc"] = "<br><description>Casado com: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Casado com: <green>" .. vRP.FullName(Split[2]) ..
								"</green>.</description>"
						end
					end


					if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
						if not v["desc"] then
							v["desc"] = "<br><description>Tipo sanguíneo encontrado: <green>" ..
								Sanguine(vRP.Identity(Split[2])["blood"]) .. "</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Tipo sanguíneo encontrado: <green>" ..
								Sanguine(vRP.Identity(Split[2])["blood"]) .. "</green>.</description>"
						end
					end

					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = itemDurability(v["item"])
					else
						v["durability"] = 0
						v["days"] = 1
					end
				else
					v["durability"] = 0
					v["days"] = 1
				end

				if Split[1] == "weedclone" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = "A pureza " .. Item .. " se encontra em <green>" .. (Split[2] or 0) .. "%</green>."
				end

				Inv[Index] = v
			end
		end
		local Identity = vRP.Identity(Passport)
		local isPremium = vRP.UserPremium(Passport)
		local vipDuration = Identity["premium"] > os.time()
		local vipType = "platinum","silver"
		
		if isPremium then
			local Groups = vRP.Hierarchy("Premium")
			local Number = vRP.HasPermission(Passport, "Premium")
			vipType = Groups[Number]
		
			if vipType == "Premium" and Number == 1 then
				vipType = "platinum"
			elseif vipType == "Premium" and Number == 2 then
				vipType = "silver"
			end
		end
		
		local slots
		if isPremium then 
			slots = 48
		else
			slots = 25
		end
		
		return Inv, vRP.InventoryWeight(Passport), (slots or 30), {
			name = Identity["name"] .. " " .. Identity["name2"],
			passport = Passport,
			gems = vRP.Account(vRP.Identities(source)).gems,
			isVip = isPremium,
			vipType = vipType
		}			
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestCrafting(craftType)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v["require"]) do
				table.insert(craftList,{ name = itemName(k), amount = v })
			end

			table.insert(inventoryShop,{ name = itemName(k), index = itemIndex(k), key = k, peso = itemWeight(k), list = craftList, amount = parseInt(v["amount"]), desc = itemDescription(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.Inventory(Passport)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(Passport),vRP.getWeight(Passport)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Evidence(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Color = 0
		if Mode == "Yellow" then
			Color = 1
		elseif Mode == "Red" then
			Color = 2
		elseif Mode == "Green" then
			Color = 3
		elseif Mode == "Blue" then
			Color = 4
		end
		-- exports["inventory"]:DropsServer(vRPC.EntityCoordsZ(source),
		-- 	"evidence0" .. Color .. "-" .. Passport .. "-" .. vRP.Identity(Passport)["license"], 1,
		-- 	Player(source)["state"]["Route"])
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DropServer(Coords, Item, Amount)
	local Number = 0

	repeat
		Number = Number + 1
	until not Drops[tostring(Number)]

	Drops[tostring(Number)] = {
		["key"] = Item,
		["amount"] = Amount,
		["Coords"] = { Coords["x"], Coords["y"], Coords["z"] },
		["name"] = itemName(Item),
		["peso"] = itemWeight(Item),
		["index"] = itemIndex(Item),
		["days"] = 1,
		["durability"] = 0,
		["charges"] = nil
	}

	TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
end

exports("DropsServer", function(Coords, Item, Amount, Route)
	local Number = 0

	repeat
		Number = Number + 1
	until not Drops[tostring(Number)]

	Drops[tostring(Number)] = {
		["key"] = Item,
		["amount"] = Amount,
		["Coords"] = { Coords["x"], Coords["y"], Coords["z"] },
		["name"] = itemName(Item),
		["peso"] = itemWeight(Item),
		["index"] = itemIndex(Item),
		["days"] = 1,
		["durability"] = 0,
		["charges"] = nil
	}

	TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Drops(Item, Slot, Amount, x, y, z)
	local source = source
	local Slot = tostring(Slot)
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRPC.InsideVehicle(source) and GetPlayerRoutingBucket(source) < 900000 then
			TriggerClientEvent("inventory:Update", source, "Backpack")

			TriggerClientEvent("inventory:verifyWeapon", source, Item)


			if vRP.TakeItem(Passport, Item, Amount, false, Slot) then
				local Days = 1
				local Number = 0
				local Charges = nil
				local Durability = 0
				local Split = splitString(Item, "-")
				repeat
					Number = Number + 1
				until not Drops[tostring(Number)]
				if Split[2] ~= nil then
					if itemDurability(Item) then
						Durability = parseInt(os.time() - Split[2])
						Days = itemDurability(Item)
					end
				end


				--[[ exports['logs']:customLogs('dropitem', {
					Passport = Passport,
					fields = {
						{ name = "Passport", value = Passport },
						{ name = "Item",     value = Item },
						{ name = "Amount",   value = Amount }
					}
				}) ]]


				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["Coords"] = { x, y, z },
					["name"] = itemName(Item),
					["peso"] = itemWeight(Item),
					["index"] = itemIndex(Item),
					["days"] = Days,
					["durability"] = Durability,
					["charges"] = Charges
				}
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				if not vRPC.InsideVehicle(source) then
					vRPC.playAnim(source, false, { "pickup_object", "pickup_low" }, false)
					Active[Passport] = os.time() + 100

					SetTimeout(1000, function()
						vRPC.Destroy(source)
						Active[Passport] = nil
					end)
				end
				TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update", source, "Backpack")
				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
			end
		else
			TriggerClientEvent("inventory:Update", source, "Backpack")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Pickup(Number, Amount, Slot)
	if Amount <= 0 then return end
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] and GetPlayerRoutingBucket(source) < 900000 then
			if not Drops[Number] then
				TriggerClientEvent("inventory:Update", source, "Backpack")
				return
			else
				if (vRP.InventoryWeight(Passport) + itemWeight(Drops[Number]["key"]) * Amount) <= vRP.GetWeight(Passport) then
					if not Drops[Number] or Drops[Number]["amount"] < Amount then
						TriggerClientEvent("inventory:Update", source, "Backpack")
						return
					end

					if vRP.MaxItens(Passport, Drops[Number]["key"], Amount) then
						TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
						TriggerClientEvent("inventory:Update", source, "Backpack")
						return
					end

					if Drops[Number] then
						local inventory = vRP.Inventory(Passport)
						if inventory[Slot] and Drops[Number]["key"] then
							if inventory[Slot]["item"] == Drops[Number]["key"] then
								vRP.GiveItem(Passport, Drops[Number]["key"], Amount, false, Slot)
								--[[ exports['logs']:customLogs('pickupitem', {
									Passport = Passport,
									fields = {
										{ name = "Passport", value = Passport },
										{ name = "Item",     value = Drops[Number]["key"] },
										{ name = "Amount",   value = Amount }
									}
								}) ]]
							else
								vRP.GiveItem(Passport, Drops[Number]["key"], Amount, false)
								--[[ exports['logs']:customLogs('pickupitem', {
									Passport = Passport,
									fields = {
										{ name = "Passport", value = Passport },
										{ name = "Item",     value = Drops[Number]["key"] },
										{ name = "Amount",   value = Amount }
									}
								}) ]]
							end
						else
							if Drops[Number] then
								vRP.GiveItem(Passport, Drops[Number]["key"], Amount, false, Slot)
								--[[ exports['logs']:customLogs('pickupitem', {
									Passport = Passport,
									fields = {
										{ name = "Passport", value = Passport },
										{ name = "Item",     value = Drops[Number]["key"] },
										{ name = "Amount",   value = Amount }
									}
								}) ]]
							end
						end

						Drops[Number]["amount"] = Drops[Number]["amount"] - Amount
						if Drops[Number]["amount"] <= 0 then
							TriggerClientEvent("drops:Remover", -1, Number)
							Drops[Number] = nil
						else
							TriggerClientEvent("drops:Atualizar", -1, Number, Drops[Number]["amount"])
						end

						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						if not vRPC.InsideVehicle(source) then
							vRPC.playAnim(source, false, { "pickup_object", "pickup_low" }, false)
							Active[Passport] = os.time() + 100

							SetTimeout(1000, function()
								vRPC.Destroy(source)
								Active[Passport] = nil
							end)
						end

						TriggerClientEvent("inventory:Update", source, "Backpack")
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
					else
						TriggerClientEvent("inventory:Update", source, "Backpack")
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					TriggerClientEvent("inventory:Update", source, "Backpack")
					return
				end
			end
		else
			TriggerClientEvent("inventory:Update", source, "Backpack")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SendItem(Slot, Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and GetPlayerRoutingBucket(source) < 900000 then
		local ClosestPed = vRPC.ClosestPed(source, 2)
		if ClosestPed then
			Active[Passport] = os.time() + 100

			local inventory = vRP.Inventory(Passport)
			if not inventory[Slot] or not inventory[Slot]["item"] then
				Active[Passport] = nil
				return
			end

			if Amount <= 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

			if vRP.CheckDamaged(Item) then
				Active[Passport] = nil
				return
			end

			local OtherPassport = vRP.Passport(ClosestPed)
			if not vRP.MaxItens(OtherPassport, Item, Amount) then
				if (vRP.InventoryWeight(OtherPassport) + itemWeight(Item) * Amount) <= vRP.GetWeight(OtherPassport) then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					Player(ClosestPed)["state"]["Cancel"] = true
					Player(ClosestPed)["state"]["Buttons"] = true
					vRPC.createObjects(source, "mp_safehouselost@", "package_dropoff", "prop_paper_bag_small", 16, 28422,
						0.0, -0.05, 0.05, 180.0, 0.0, 0.0)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.Destroy(source)
							Player(source)["state"]["Cancel"] = false
							Player(source)["state"]["Buttons"] = false
							Player(ClosestPed)["state"]["Cancel"] = false
							Player(ClosestPed)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport, Item, Amount, true, Slot) then
								vRP.GiveItem(OtherPassport, Item, Amount, true)
								TriggerClientEvent("inventory:Update", source, "Backpack")
								TriggerClientEvent("inventory:Update", ClosestPed, "Backpack")
								--[[ exports['logs']:customLogs('senditem', {
									Passport = Passport,
									fields = {
										{ name = "Passport",      value = Passport },
										{ name = "OtherPassport", value = OtherPassport },
										{ name = "Item",          value = Item },
										{ name = "Amount",        value = Amount }
									}
								}) ]]
							end
						end
						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 3000)
			end

			Active[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Deliver(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 100

		if Work == "Lumberman" then
			if not vRPC.LastVehicle(source, "ratloader") then
				TriggerClientEvent("Notify", source, "amarelo", "Precisa utilizar o veículo do <b>Lenhador</b>.",
					"Atenção", 5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport, "woodlog", 5, false, Slot) then
				local Experience = vRP.GetExperience(Passport, "Lumberman")
				local Level = ClassCategory(Experience)
				local Valuation = 150 + (Level * 10)

				local Party, UsersAmount = exports['party']:PartyDistance(Passport, 10)

				if parseInt(UsersAmount) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.GenerateItem(Passport, "dollars", Valuation, true)
				vRP.PutExperience(Passport, "Lumberman", 1)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Transporter" then
			if not vRPC.LastVehicle(source, "stockade") then
				TriggerClientEvent("Notify", source, "amarelo", "Precisa utilizar o veículo do <b>Transportador</b>.",
					"Atenção", 5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport, "pouch", 1, false, Slot) then
				local Experience = vRP.GetExperience(Passport, "Transporter")
				local Level = ClassCategory(Experience)
				local Valuation = 60

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 15
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 25
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 35
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 45
				elseif Level == 10 then
					Valuation = Valuation + 50
				end

				local Members = exports["party"]:Room(Passport, source, 10)
				if parseInt(#Members) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.GenerateItem(Passport, "dollars", Valuation, true)
				vRP.PutExperience(Passport, "Transporter", 1)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Burgershot" then
			if vRP.TakeItem(Passport, "foodbox", 1, false, Slot) then
				local Experience = vRP.GetExperience(Passport, "Delivery")
				local Level = ClassCategory(Experience)
				local Valuation = 140

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 20
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 30
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 40
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 50
				elseif Level == 10 then
					Valuation = Valuation + 60
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.TakeItem(Passport, "dollars2", 500) then
					Valuation = Valuation + 300
				end

				vRP.GenerateItem(Passport, "dollars", Valuation, true)
				vRP.PutExperience(Passport, "Delivery", 1)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Ballas" or Work == "Families" or Work == "Vagos" or Work == "Aztecas" or Work == "Bloods" then
			vRP.GenerateItem(Passport, "dollars3", 100, true)
			Active[Passport] = nil

			return true
		end

		Active[Passport] = nil
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UseItem(Slot, Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Amount <= 0 then Amount = 1 end

		local Inventory = vRP.Inventory(Passport)
		if not Inventory[Slot] or not Inventory[Slot]["item"] then
			return
		end

		local Split = splitString(Inventory[Slot]["item"], "-")
		local Full = Inventory[Slot]["item"]
		local Item = Split[1]

		if itemDurability(Full) then
			if vRP.CheckDamaged(Full) then
				TriggerClientEvent("Notify", source, "vermelho", "<b>" .. itemName(Item) .. "</b> danificado.", "Aviso",
					5000)
				return
			end
		end

		if (vCLIENT.checkWater(source) and Item ~= "soap") or (not vCLIENT.checkWater(source) and Item == "soap") then
			return
		end

		if itemType(Full) == "Armamento" and parseInt(Slot) <= 5 then
			if vCLIENT.CheckArms(source) then
				TriggerClientEvent("Notify", source, "vermelho", "Mão machucada.", "Aviso", 5000)
				return
			end

			if vRPC.InsideVehicle(source) then
				if not itemVehicle(Full) then
					return
				end
			end

			if vCLIENT.returnWeapon(source) then
				local Check, Ammo, Hash = vCLIENT.storeWeaponHands(source)

				if Check then
					local wHash = itemAmmo(Hash)
					if wHash then
						if Ammo > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][wHash] = Ammo
						else
							if Ammos[Passport] and Ammos[Passport][wHash] then
								Ammos[Passport][wHash] = nil
							end
						end
					end

					TriggerClientEvent("itensNotify", source, { "-", itemIndex(Hash), 1, "guardou" })
					exports["inventory"]:CleanWeapons(Passport, false)
				end
			else
				Ammo = 0
				local wHash = itemAmmo(Item)
				if wHash then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					if not Ammos[Passport][wHash] then
						Ammos[Passport][wHash] = 0
					else
						Ammo = Ammos[Passport][wHash]
					end
				end

				if not Attachs[Passport] then
					Attachs[Passport] = {}
				end

				if not Attachs[Passport][Item] then
					Attachs[Passport][Item] = {}
				end

				if vCLIENT.putWeaponHands(source, Item, Ammo, Attachs[Passport][Item]) then
					TriggerClientEvent("itensNotify", source, { "+", itemIndex(Full), 1, "equipou" })
				end
			end
		elseif itemType(Full) == "Munição" then
			local Weapon, Hash, Ammo = vCLIENT.rechargeCheck(source, Item)
			if Weapon then
				if Hash == "WEAPON_PETROLCAN" then
					if (Ammo + Amount) > 4500 then
						Amount = 4500 - Ammo
					end
				else
					if (Ammo + Amount) > 250 then
						Amount = 250 - Ammo
					end
				end

				if Item ~= itemAmmo(Hash) or Amount <= 0 then
					return
				end

				if vRP.TakeItem(Passport, Full, Amount, false, Slot) then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					Ammos[Passport][Item] = Ammo + Amount

					TriggerClientEvent("itensNotify", source, { "-", itemIndex(Full), Amount, itemName(Full) })
					TriggerClientEvent("inventory:Update", source, "Backpack")
					vCLIENT.rechargeWeapon(source, Hash, Amount)
				end
			end
		elseif itemType(Full) == "Throwing" then
			if vCLIENT.returnWeapon(source) then
				local Check, Ammo, Hash = vCLIENT.storeWeaponHands(source)

				if Check then
					local wHash = itemAmmo(Hash)
					if wHash then
						if Ammo > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][wHash] = Ammo
						else
							if Ammos[Passport] and Ammos[Passport][wHash] then
								Ammos[Passport][wHash] = nil
							end
						end
					end

					TriggerClientEvent("itensNotify", source, { "+", itemIndex(Hash), 1, itemName(Hash) })
					exports["inventory"]:CleanWeapons(Passport, false)
				end
			else
				if vCLIENT.putWeaponHands(source, Item, 1, nil, Full) then
					TriggerClientEvent("itensNotify", source, { "-", itemIndex(Full), 1, itemName(Full) })
				end
			end
		elseif Item == "ATTACH_FLASHLIGHT" or Item == "ATTACH_CROSSHAIR" or Item == "ATTACH_SILENCER" or Item == "ATTACH_MAGAZINE" or Item == "ATTACH_GRIP" then
			local Weapon = vCLIENT.returnWeapon(source)
			if Weapon then
				if vCLIENT.CheckAttachs(source, Item, Weapon) then
					if not Attachs[Passport] then
						Attachs[Passport] = {}
					end

					if not Attachs[Passport][Weapon] then
						Attachs[Passport][Weapon] = {}
					end

					if not Attachs[Passport][Weapon][Item] then
						if vRP.TakeItem(Passport, Full, 1, false, Slot) then
							TriggerClientEvent("itensNotify",source, { "-", itemIndex(Full), 1, itemName(Full) })
							TriggerClientEvent("inventory:Update", source, "Backpack")
							Attachs[Passport][Weapon][Item] = true
							vCLIENT.putAttachs(source, Item, Weapon)
						end
					else
						TriggerClientEvent("Notify", source, "vermelho", "O armamento não possui suporte ao componente.",
							"Aviso", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "O armamento já possui o componente equipado.",
						"Aviso", 5000)
				end
			end
		elseif Item and Use[Item] then
			Use[Item](source, Passport, Amount, Slot, Full, Item, Split)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:saveTemporary", function(Passport)
	exports["inventory"]:CleanWeapons(Passport, false)

	if not Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Temporary[Passport] = {
			["Ammos"] = Ammos[Passport],
			["Attachs"] = Attachs[Passport]
		}

		Attachs[Passport] = {
			["WEAPON_COMBATPISTOL"] = {
				["ATTACH_FLASHLIGHT"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["ATTACH_FLASHLIGHT"] = true,
				["ATTACH_CROSSHAIR"] = true
			}
		}

		Ammos[Passport] = {
			["WEAPON_PISTOL_AMMO"] = 250
		}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:applyTemporary", function(Passport)
	exports["inventory"]:CleanWeapons(Passport, true)

	if Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Attachs[Passport] = Temporary[Passport]["Attachs"]
		Ammos[Passport] = Temporary[Passport]["Ammos"]
		Temporary[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] ~= nil then
			Active[Passport] = nil
			vGARAGE.UpdateHotwired(source, false)
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress", source, "Cancelando", 1000)

			if verifyObjects[Passport] then
				local Model = verifyObjects[Passport][1]
				local Hash = verifyObjects[Passport][2]

				if Trashs[Model] then
					if Trashs[Model][Hash] then
						Trashs[Model][Hash] = nil
					end
				end

				if Pumpjack[Model] then
					if Pumpjack[Model][Hash] then
						Pumpjack[Model][Hash] = nil
					end
				end

				verifyObjects[Passport] = nil
			end

			if verifyAnimals[Passport] then
				local Model = verifyAnimals[Passport][1]

				if Animals[Model] then
					local netObjects = verifyAnimals[Passport][2]

					if Animals[Model][netObjects] then
						Animals[Model][netObjects] = Animals[Model][netObjects] - 1
						verifyAnimals[Passport] = nil
					end
				end
			end

			if Loots[Passport] then
				local myLoots = Loots[Passport]

				if Boxes[myLoots] then
					if Boxes[myLoots][Passport] then
						Boxes[myLoots][Passport] = nil
					end
				end

				Loots[Passport] = nil
			end
		end

		if Carry[Passport] then
			if vRP.Passport(Carry[Passport]) then
				TriggerClientEvent("inventory:Carry", Carry[Passport], nil, "Detach")
				Player(Carry[Passport])["state"]["Carry"] = false
				vRPC.Destroy(Carry[Passport])
			end

			Carry[Passport] = nil
		end

		if Scanners[Passport] then
			TriggerClientEvent("inventory:updateScanner", source, false)
			TriggerClientEvent("inventory:ScannerBlips", source)
			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Scanner"] = false
			Scanners[Passport] = nil
		end

		vRPC.Destroy(source)

		if GetPlayerRoutingBucket(source) > 900000 then
			TriggerEvent("arena:Cancel", source, Passport)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] ~= nil then
		return false
	end

	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.VerificarArma(Item, Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.ConsultItem(Passport, Item, 1) then
		local Ammunation = itemAmmo(Item)
		if Ammunation and Ammos[Passport] and Ammos[Passport][Ammunation] then
			if Ammo and Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			end

			if Ammos[Passport][Ammunation] > 0 then
				vRP.GenerateItem(Passport, Ammunation, Ammos[Passport][Ammunation])
				Ammos[Passport][Ammunation] = nil
			end
		end

		if Attachs[Passport] and Attachs[Passport][Item] then
			for Component, _ in pairs(Attachs[Passport][Item]) do
				vRP.GenerateItem(Passport, Component, 1)
			end

			Attachs[Passport][Item] = nil
		end

		TriggerClientEvent("inventory:Update", source, "Backpack")
		exports["inventory"]:CleanWeapons(Passport, false)

		return false
	end

	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.dropWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		if not vRP.ConsultItem(Passport, Item, 1) then
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.removeThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport, Item, 1)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PreventWeapons(Item, Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Ammos[Passport] then
		local Ammunation = itemAmmo(Item)

		if Ammunation and Ammos[Passport][Ammunation] then
			if Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			else
				Ammos[Passport][Ammunation] = nil
				exports["inventory"]:CleanWeapons(Passport, false)
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.VerifyObjects(Entity, Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Service == "Parkimeter" then
			local consultNails = vRP.InventoryItemAmount(Passport, "WEAPON_NAIL_AMMO")
			if consultNails[1] <= 0 then
				TriggerClientEvent("Notify", source, "vermelho",
					"Precisa de <b>1x " .. itemName("WEAPON_NAIL_AMMO") .. "</b>.", "Aviso", 5000)
				return
			end
		elseif Service == "Pumpjack" then
			if not vCLIENT.checkWeapon(source, "WEAPON_CROWBAR") then
				TriggerClientEvent("Notify", source, "amarelo",
					"Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção", 5000)
				return
			end
		end
		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local Hash = Entity[1]
			local Model = Entity[2]
			local Coords = Entity[4]
			if not verifyObjects[Passport] then
				if not Trashs[Model] then
					Trashs[Model] = {}
				end

				if not Pumpjack[Model] then
					Pumpjack[Model] = {}
				end
				for k, v in pairs(Trashs[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end
				for k, v in pairs(Pumpjack[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end
				if Service == "Parkimeter" then
					vRP.RemoveItem(Passport, "WEAPON_NAIL_AMMO", 1, true)
				end
				if Service == "CarWreck" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.playAnim(source, false,
						{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				elseif Service == "Pumpjack" then
					Active[Passport] = os.time() + 60
					TriggerClientEvent("vRP:Explosion", source, Coords)
					TriggerClientEvent("Progress", source, "Roubando", 60000)
					vRPC.playAnim(source, false,
						{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources,
								{
									code = 31,
									title = "Roubo de Petróleo",
									x = Coords["x"],
									y = Coords["y"],
									z = Coords["z"],
									criminal = "Alarme de segurança",
									time = "Recebido às " .. os.date("%H:%M"),
									blipColor = 44
								})
						end)
					end
				elseif Service == "Bricks" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.playAnim(source, false,
						{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources,
								{
									code = 31,
									title = "Roubo de Materiais",
									x = Coords["x"],
									y = Coords["y"],
									z = Coords["z"],
									criminal = "Alarme de segurança",
									time = "Recebido às " .. os.date("%H:%M"),
									blipColor = 44
								})
						end)
					end
				else
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress", source, "Vasculhando", 10000)
					vRPC.playAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)
				end

				verifyObjects[Passport] = { Model, Hash }
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close", source)

				if Service == "Pumpjack" then
					Pumpjack[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 7200 }
				else
					Trashs[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 3600 }
				end
				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source, false)
						Player(source)["state"]["Buttons"] = false
						local itemSelect = { "", 1 }
						if Service == "Lixeiro" then
							if vRPC.LastVehicle(source, "trash") then
								local randItem = math.random(90)
								if parseInt(randItem) >= 61 and parseInt(randItem) <= 70 then
									itemSelect = { "metalcan", math.random(1, 3) }
								elseif parseInt(randItem) >= 51 and parseInt(randItem) <= 60 then
									itemSelect = { "battery", math.random(1, 3) }
								elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 50 then
									itemSelect = { "elastic", math.random(1, 3) }
								elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
									itemSelect = { "plasticbottle", math.random(1, 3) }
								elseif parseInt(randItem) <= 20 then
									itemSelect = { "glassbottle", math.random(1, 3) }
								end
							else
								itemSelect = { "recyclable", math.random(6, 12) }
							end
						elseif Service == "Jornaleiro" then
							itemSelect = { "newspaper", math.random(3) }
						elseif Service == "Parkimeter" then
							local randPark = math.random(70)
							if parseInt(randPark) >= 31 and parseInt(randPark) <= 60 then
								itemSelect = { "goldcoin", math.random(2, 4) }
							elseif parseInt(randPark) <= 30 then
								itemSelect = { "silvercoin", math.random(3, 6) }
							end
						elseif Service == "CarWreck" then
							itemSelect = { "scrap", math.random(6, 12) }
						elseif Service == "Pumpjack" then
							local randOil = math.random(15)
							if parseInt(randOil) >= 0 and parseInt(randOil) <= 10 then
								TriggerClientEvent("vRP:Explosion", source, Coords)
								itemSelect = { "oilbarrel", 1 }
							end
						elseif Service == "Fruits" then
							local randFruits = math.random(40)
							if parseInt(randFruits) >= 31 and parseInt(randFruits) <= 40 then
								itemSelect = { "banana", math.random(3, 6) }
							elseif parseInt(randFruits) >= 21 and parseInt(randFruits) <= 30 then
								itemSelect = { "apple", math.random(3, 6) }
							elseif parseInt(randFruits) >= 11 and parseInt(randFruits) <= 20 then
								itemSelect = { "orange", math.random(3, 6) }
							elseif parseInt(randFruits) <= 10 then
								itemSelect = { "tange", math.random(3, 6) }
							end
						elseif Service == "Bricks" then
							local randBricks = math.random(15)
							if parseInt(randBricks) >= 0 and parseInt(randBricks) <= 10 then
								itemSelect = { "WEAPON_BRICK", math.random(3, 6) }
							end
						end
						if itemSelect[1] == "" then
							if Service == "Parkimeter" then
								local Players = vRPC.ClosestPeds(source, 5)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("Notify", v, "vermelho",
											"Um parquímetro próximo irá explodir em breve.", "Aviso", 10000)
									end)
								end
								SetTimeout(5000, function()
									TriggerClientEvent("vRP:Explosion", source, Coords)
								end)
							elseif Service == "Pumpjack" then
								TriggerClientEvent("Notify", source, "vermelho", "Bomba de vareta de sucção vazia.",
									"Aviso", 5000)
							else
								TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
							end
							vRP.UpgradeStress(Passport, 1)
						else
							if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
								if Service == "Pumpjack" then
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, 5)
								else
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, 1)
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
								Trashs[Model][Hash] = nil
								Pumpjack[Model][Hash] = nil
							end
						end
						verifyObjects[Passport] = nil
					end
					Wait(100)
				until not Active[Passport]
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Loot(Entity, Service)
	local source = source
	local Entity = tostring(Entity)
	local Passport = vRP.Passport(source)
	if Passport and LootItens[Service] then
		if not Loots[Passport] and not Active[Passport] then
			if not Boxes[Entity] then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][Passport] then
				if os.time() <= Boxes[Entity][Passport] then
					local Cooldown = MinimalTimers(Boxes[Entity][Passport] - os.time())
					TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
					return
				end
			end

			Loots[Passport] = Entity
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("Progress", source, "Vasculhando", 10000)
			Boxes[Entity][Passport] = os.time() + LootItens[Service]["Cooldown"]
			vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },
				true)

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.stopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					local randItem = math.random(#LootItens[Service]["List"])
					local randAmount = math.random(LootItens[Service]["List"][randItem]["min"],
						LootItens[Service]["List"][randItem]["max"])
					local itemSelect = { LootItens[Service]["List"][randItem]["item"], randAmount }

					if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
						if Buffs["Luck"][Passport] then
							if Buffs["Luck"][Passport] > os.time() then
								vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2] * 0.1, true)
								--[[ exports['logs']:customLogs('loot', {
									Passport = Passport,
									fields = {
										{ name = "Passport", value = Passport },
										{ name = "Item",     value = itemSelect[1] },
										{ name = "Amount",   value = itemSelect[2] * 0.1 }
									}
								}) ]]
							end
						else
							vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
							--[[ exports['logs']:customLogs('loot', {
								Passport = Passport,
								fields = {
									{ name = "Passport", value = Passport },
									{ name = "Item",     value = itemSelect[1] },
									{ name = "Amount",   value = itemSelect[2] }
								}
							}) ]]
						end
					else
						TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
						Boxes[Entity][Passport] = nil
					end

					Loots[Passport] = nil
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate", function(Entity)
	local source = source
	local consultItem = {}
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Plates[Plate] then
			consultItem = vRP.InventoryItemAmount(Passport, "plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x " .. itemName("plate") .. "</b>.",
					"Aviso", 5000)
				return
			end
		end

		local consultPliers = vRP.InventoryItemAmount(Passport, "pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x " .. itemName("pliers") .. "</b>.",
				"Aviso", 5000)
			return
		end

		if Plates[Plate] ~= nil then
			if os.time() < Plates[Plate][1] then
				local plateTimers = parseInt(Plates[Plate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify", source, "azul", "Aguarde " .. CompleteTimers(plateTimers) .. ".", false,
						5000)
				end

				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress", source, "Trocando", 10000)
		vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.stopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if not Plates[Plate] then
					if vRP.TakeItem(Passport, consultItem[2], 1, true) then
						local newPlate = vRP.GeneratePlate()
						TriggerEvent("plateEveryone", newPlate)
						Plates[newPlate] = { os.time() + 3600, Plate }

						local Network = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							SetVehicleNumberPlateText(Network, newPlate)
						end
					end
				else
					local Network = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						SetVehicleNumberPlateText(Network, Plates[Plate][2])
					end

					if math.random(100) >= 50 then
						vRP.GenerateItem(Passport, "plate", 1, true)
					else
						TriggerClientEvent("Notify", source, "azul", "Após remove-la a mesma quebrou.", false, 5000)
					end

					TriggerEvent("plateReveryone", Plate)
					Plates[Plate] = nil
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StealTrunk(Entity)
	local source = source
	local Plate = Entity[1]
	local Network = Entity[4]
	local vehModels = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Ped = GetPlayerPed(source)

		if not (GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_CROWBAR")) then
			TriggerClientEvent("Notify", source, "amarelo",
				"Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção", 5000)
			return
		end

		if not vRP.PassportPlate(Plate) then
			if not Trunks[Plate] then
				Trunks[Plate] = os.time()
			end

			if os.time() >= Trunks[Plate] then
				vRPC.playAnim(source, false,
					{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },
					true)
				Active[Passport] = os.time() + 100

				if vTASKBAR.Task(source, 4, 10500) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress", source, "Vasculhando", 20000)
					TriggerClientEvent("player:Residuals", source, "Resíduo de Ferro.")
					TriggerClientEvent("player:VehicleDoors", source, Network, "open")

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source, false)
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:VehicleDoors", source, Network, "close")

							if os.time() >= Trunks[Plate] then
								local randItens = math.random(#StealItens)
								if math.random(100) <= 50 then
									local randAmounts = math.random(StealItens[randItens]["Min"],
										StealItens[randItens]["Max"])

									if (vRP.InventoryWeight(Passport) + itemWeight(StealItens[randItens]["item"]) * randAmounts) <= vRP.GetWeight(Passport) then
										vRP.GenerateItem(Passport, StealItens[randItens]["item"], randAmounts, true)
										Trunks[Plate] = os.time() + 3600
										vRP.UpgradeStress(Passport, 2)
									else
										TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
									end
								else
									TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
									Trunks[Plate] = os.time() + 3600
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("inventory:vehicleAlarm", source, Network, Plate)
					vRPC.stopAnim(source, false)
					Active[Passport] = nil

					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources,
								{
									code = 31,
									title = "Roubo de Veículo",
									x = Coords["x"],
									y = Coords["y"],
									z = Coords["z"],
									vehicle = VehicleName(vehModels) .. " - " .. Plate,
									time = "Recebido às " .. os.date("%H:%M"),
									blipColor = 44
								})
						end)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Veículo protegido pela seguradora.", "Atenção", 1000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Animals(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			if not vCLIENT.checkWeapon(source, "WEAPON_SWITCHBLADE") then
				TriggerClientEvent("Notify", source, "amarelo",
					"Você precisa colocar o <b>" .. itemName("WEAPON_SWITCHBLADE") .. "</b> em mãos.", "Atenção",
					5000)
				return
			end

			local Model = Entity[2]
			local netObjects = Entity[3]

			if not Animals[Model] then
				Animals[Model] = {}
			end

			if not Animals[Model][netObjects] then
				Animals[Model][netObjects] = 0
			end

			if not verifyAnimals[Passport] and not Active[Passport] and Animals[Model][netObjects] < 5 then
				if (vRP.InventoryWeight(Passport) + 2.25) <= vRP.GetWeight(Passport) then
					if vTASKBAR.Task(source, 1, 10000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress", source, "Esfolando", 10000)

						if not vCLIENT.animalAnim(source) then
							vRPC.Destroy(source)
							vRPC.playAnim(source, false, { "amb@medic@standing@kneel@base", "base" }, true)
							vRPC.playAnim(source, true, { "anim@gangops@facility@servers@bodysearch@", "player_search" },
								true)
						end

						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close", source)
						verifyAnimals[Passport] = { Model, netObjects }
						Animals[Model][netObjects] = Animals[Model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								verifyAnimals[Passport] = nil
								Player(source)["state"]["Buttons"] = false

								if Animals[Model] then
									if Model == 1682622302 then
										coyoteList = { "coyote1star", "coyote2star", "coyote3star" }
										local coyoteRandom = math.random(#coyoteList)
										local coyoteSelects = coyoteList[coyoteRandom]
										vRP.GenerateItem(Passport, coyoteSelects, 1, true)
									elseif Model == 307287994 then
										mtlionList = { "mtlion1star", "mtlion2star", "mtlion3star" }
										local mtlionRandom = math.random(#mtlionList)
										local mtlionSelects = mtlionList[mtlionRandom]
										vRP.GenerateItem(Passport, mtlionSelects, 1, true)
									elseif Model == -832573324 then
										boarList = { "boar1star", "boar2star", "boar3star" }
										local boarRandom = math.random(#boarList)
										local boarSelects = boarList[boarRandom]
										vRP.GenerateItem(Passport, boarSelects, 1, true)
									elseif Model == -664053099 then
										deerList = { "deer1star", "deer2star", "deer3star" }
										local deerRandom = math.random(#deerList)
										local deerSelects = deerList[deerRandom]
										vRP.GenerateItem(Passport, deerSelects, 1, true)
									else
										otherList = { "animalpelt", "meat", "animalfat", "leather" }
										local otherRandom = math.random(#otherList)
										local otherSelects = otherList[otherRandom]
										vRP.GenerateItem(Passport, otherSelects, math.random(2, 4), true)
									end

									vRPC.Destroy(source)
									Animals[Model][netObjects] = nil
									TriggerEvent("DeletePed", netObjects)
								end

								local Experience = vRP.GetExperience(Passport, "Hunter")
								local Category = ClassCategory(Experience)
								local Valuation = 100

								if Category == 1 then
									Valuation = Valuation + 10
								elseif Category == 2 then
									Valuation = Valuation + 20
								elseif Category == 3 then
									Valuation = Valuation + 30
								elseif Category == 4 then
									Valuation = Valuation + 40
								elseif Category == 5 then
									Valuation = Valuation + 50
								elseif Category == 6 then
									Valuation = Valuation + 60
								elseif Category == 7 then
									Valuation = Valuation + 70
								elseif Category == 8 then
									Valuation = Valuation + 80
								elseif Category == 9 then
									Valuation = Valuation + 90
								elseif Category == 10 then
									Valuation = Valuation + 100
								end

								if Buffs["Dexterity"][Passport] then
									if Buffs["Dexterity"][Passport] > os.time() then
										Valuation = Valuation + (Valuation * 0.1)
									end
								end

								vRP.PutExperience(Passport, "Hunter", 1)
								vRPC.stopAnim(source, false)
							end

							Wait(100)
						until not Active[Passport]
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StoreObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Objects[Number] then
			if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.GetWeight(Passport) then
				vRP.GiveItem(Passport, Objects[Number]["item"], 1, true)
				TriggerClientEvent("objects:Remover", -1, Number)
				Objects[Number] = nil
			else
				TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GenerateObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Objects[Number] then
			if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.GetWeight(Passport) then
				vRP.GenerateItem(Passport, "oilgallon", 3, true)
				TriggerClientEvent("objects:Remover", -1, Number)
				Objects[Number] = nil
			else
				TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.MakeProducts(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Split = splitString(Table, "-")
		local Selected = Split[1]

		if Products[Selected] then
			if Selected == "cemitery" then
				if not vTASKBAR.Task(source, 1, 10500) then
					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush", Sources,
								{
									code = 20,
									title = "Roubo de Pertences",
									x = Coords["x"],
									y = Coords["y"],
									z = Coords["z"],
									criminal = "Alarme de segurança",
									time = "Recebido às " .. os.date("%H:%M"),
									blipColor = 16
								})
						end)
					end
				end
			end

			local Need = {}
			local Consult = {}
			local Number = math.random(#Products[Selected])

			if Products[Selected][Number]["item"] then
				if vRP.MaxItens(Passport, Products[Selected][Number]["item"], Products[Selected][Number]["itemAmount"]) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 3000)
					return
				end

				if (vRP.InventoryWeight(Passport) + itemWeight(Products[Selected][Number]["item"]) * Products[Selected][Number]["itemAmount"]) > vRP.GetWeight(Passport) then
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					return
				end
			end

			if Products[Selected][Number]["need"] then
				local needItem = Products[Selected][Number]["need"]

				if type(needItem) == "table" then
					for k, v in pairs(needItem) do
						Consult = vRP.InventoryItemAmount(Passport, v["item"])
						if Consult[1] < v["amount"] then
							TriggerClientEvent("Notify", source, "vermelho",
								"Necessário possuir <b>" .. v["amount"] .. "x " .. itemName(v["item"]) .. "</b>.",
								"Aviso", 5000)
							return
						end

						Need[k] = { Consult[2], v["amount"] }
					end
				else
					needAmount = Products[Selected][Number]["needAmount"]
					Consult = vRP.InventoryItemAmount(Passport, needItem)
					if Consult[1] < needAmount then
						TriggerClientEvent("Notify", source, "vermelho",
							"Necessário possuir <b>" .. needAmount .. "x " .. itemName(needItem) .. "</b>.", "Aviso",
							5000)
						return
					end
				end
			end

			Player(source)["state"]["Buttons"] = true
			Active[Passport] = os.time() + Products[Selected][Number]["timer"]
			TriggerClientEvent("Progress", source, "Produzindo", Products[Selected][Number]["timer"] * 1000)

			if Selected == "tablecoke" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)

				if vTASKBAR.Task(source, 5, 15000) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "paper" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)
			elseif Selected == "tablemeth" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)

				if vTASKBAR.Task(source, 5, 15000) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "tableweed" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)

				if vTASKBAR.Task(source, 5, 15000) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "milkBottle" then
				vRPC.playAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)
			elseif Selected == "cemitery" then
				vRPC.playAnim(source, false, { "amb@medic@standing@tendtodead@idle_a", "idle_a" }, true)
			elseif Selected == "fishfillet" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)
			elseif Selected == "marshmallow" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)
			elseif Selected == "animalmeat" then
				vRPC.playAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" },
					true)
			elseif Selected == "emptybottle" then
				vRPC.playAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)
			end

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Player(source)["state"]["Buttons"] = false
					Active[Passport] = nil
					local Points = 0

					if Selected ~= "scanner" then
						vRPC.stopAnim(source, false)
					end

					if Products[Selected][Number]["need"] then
						if type(Products[Selected][Number]["need"]) == "table" then
							for k, v in pairs(Need) do
								local Split = splitString(v[1], "-")
								if Split[1] == "weedbud" and Split[2] ~= nil then
									Points = Split[2]
								end

								vRP.RemoveItem(Passport, v[1], v[2], false)
							end
						else
							vRP.RemoveItem(Passport, Consult[2], needAmount, false)
						end
					end

					if Products[Selected][Number]["item"] then
						if Selected == "tableweed" then
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"] .. "-" .. Points,
								Products[Selected][Number]["itemAmount"], true)
						else
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"],
								Products[Selected][Number]["itemAmount"], true) -- dump agua

							if Selected == "milkBottle" then
								vRP.UpgradeStress(Passport, math.random(2))
							end
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismantle(Entity)
	local source = source
	local vehName = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Desmanchando", 60000)
		vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				TriggerEvent("garages:dismantleVehicle", Entity[4], Entity[1])
				TriggerClientEvent("player:Residuals", source, "Resíduo de Metal.")
				TriggerClientEvent("player:Residuals", source, "Resíduo de Alumínio.")

				local Class = 1
				if Dismantle[Passport] then
					Class = ClassCategory(Dismantle[Passport])
				end

				local AmountItens = math.random(100, 150)
				local VehSelected = "suspension"
				local VehParts = math.random(4)
				local VehRandom = 1000

				if Class == 1 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 2 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 3 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 4 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 5 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 6 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 7 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 8 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 9 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 10 then
					VehRandom = math.random(1500)
					AmountItens = math.random(350, 400)
				end

				if VehParts <= 1 then
					VehSelected = "engine"
				elseif VehParts == 2 then
					VehSelected = "transmission"
				elseif VehParts == 3 then
					VehSelected = "brake"
				end

				if VehRandom <= 10 then
					vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
				elseif VehRandom >= 10 and VehRandom <= 30 then
					vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
				elseif VehRandom >= 31 and VehRandom <= 60 then
					vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
				elseif VehRandom >= 61 and VehRandom <= 100 then
					vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
				elseif VehRandom >= 101 and VehRandom <= 150 then
					vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
				end

				local Members = exports["vrp"]:Party(Passport, source, 20)
				if #Members > 1 then
					for _, v in pairs(Members) do
						vRP.GenerateItem(v["Passport"], "dollars", AmountItens * #Members, true)
						vRP.PutExperience(v["Passport"], "Dismantle", 2)
					end
				else
					vRP.GenerateItem(Passport, "dollars", AmountItens, true)
					vRP.PutExperience(Passport, "Dismantle", 1)
				end

				vRP.GenerateItem(Passport, "dismantle", 1, true)

				if math.random(1000) <= 100 then
					vRP.GenerateItem(Passport, "plate", 1, true)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveTyres(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vRP.HasGroup(Passport, "Bennys") then
			if not vCLIENT.checkWeapon(source, "WEAPON_WRENCH") then
				TriggerClientEvent("Notify", source, "amarelo",
					"Você precisa colocar a <b>" .. itemName("WEAPON_WRENCH") .. "</b> em mãos.", "Atenção", 5000)
				return
			end
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source, Entity[4], Entity[5]) == 1000.0 then
				if vRP.MaxItens(Passport, "tyres", 1) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 3000)
					return
				end

				if vRP.PassportPlate(Entity[1]) then
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close", source)
					vRPC.playAnim(source, false,
						{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					if vTASKBAR.Task(source, 3, 70500) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress", source, "Removendo", 10000)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source, Entity[4], Entity[5]) == 1000.0 then
										TriggerClientEvent("inventory:explodeTyres", source, Entity[4], Entity[1],
											Entity[5])
										vRP.GenerateItem(Passport, "tyres", 1, true)
									end
								end
							end

							Wait(100)
						until not Active[Passport]
					end

					Player(source)["state"]["Buttons"] = false
					vRPC.Destroy(source)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)

		if Buffs["Luck"][Passport] then
			if Buffs["Luck"][Passport] > os.time() then
				Active[Passport] = os.time() + 5
				TriggerClientEvent("Progress", source, "Bebendo", 5000)
			end
		else
			Active[Passport] = os.time() + 10
			TriggerClientEvent("Progress", source, "Bebendo", 10000)
		end

		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		vRPC.createObjects(source, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "prop_plastic_cup_02", 49,
			28422)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil

				if Buffs["Luck"][Passport] then
					if Buffs["Luck"][Passport] > os.time() then
						vRP.UpgradeThirst(Passport, 30)
					end
				else
					vRP.UpgradeThirst(Passport, 15)
				end

				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false
			end
			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StealPeds()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(1, #StealPeds)
		local Amount = math.random(StealPeds[Rand]["Min"], StealPeds[Rand]["Max"])

		if not Amount then return end

		if (vRP.InventoryWeight(Passport) + itemWeight(StealPeds[Rand]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport, StealPeds[Rand]["Item"], Amount, true)

			if math.random(100) >= 65 then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Service = vRP.NumPermission("Policia")
				for Passports, Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush", Sources,
							{
								code = 32,
								title = "Assalto a mão armada",
								x = Coords["x"],
								y = Coords["y"],
								z = Coords["z"],
								criminal = "Ligação Anônima",
								time = "Recebido às " .. os.date("%H:%M"),
								blipColor = 16
							})
					end)
				end
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end
	TriggerClientEvent("Notify", source, "vermelho", "Função indisponivel no momento.", "Aviso", 5000)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for k, v in pairs(DrugsList) do
			local Amount = math.random(v["Amount"]["Min"], v["Amount"]["Max"])
			local Price = math.random(v["Price"]["Min"], v["Price"]["Max"])

			local Consult = vRP.InventoryItemAmount(Passport, k)
			if Consult[1] >= Amount then
				Drugs[Passport] = { Consult[2], Amount, Price * Amount }
				return true
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PaymentDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	local inInfluenceZone = false
	if Passport and Drugs[Passport] then
		local Points = 0
		local Percentage = 95
		local Split = splitString(Drugs[Passport][1], "-")
		if Split[2] ~= nil then
			Points = parseInt(Split[2])
		end

		if vRP.tryGetTimer(Passport, 'selldrugs') then
			vRP.BanPassport(Passport, 'Puxando dinheiro [SELLDRUGS]')
			return
		end

		vRP.setTimer(Passport, 'selldrugs', 5)

		if vRP.TakeItem(Passport, Drugs[Passport][1], Drugs[Passport][2], true) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local bonusFactor = 0

			for k, v in pairs(DrugsInfluence) do
				if hasPayed then return end
				local Distance = #(Coords - vec3(v[1], v[2], v[3]))
				if Distance <= v[4] then
					bonusFactor = bonusFactor + 0.10
				end
			end


			local Party, UsersAmount = exports['party']:PartyDistance(Passport, 10)

			if parseInt(UsersAmount) >= 2 then
				bonusFactor = bonusFactor + 0.05
			end

			bonusFactor = bonusFactor + vRP.calculateBonus(Passport, false, 20)
			::payment::
			local bonusPayment = ((Drugs[Passport][3] + (Points * 2)))
			vRP.GenerateItem(Passport, "dollars2", bonusPayment + bonusFactor, true)

			TriggerClientEvent("Notify", source, "verde",
				"Você recebeu um bônus de " .. tostring(bonusFactor) .. " Dólares!", "Sucesso", 5000)

			TriggerClientEvent("player:Residuals", source, "Resíduo Orgânico.")

			Percentage = Percentage - Points

			if Percentage <= 25 then
				Percentage = 25
			end

			if math.random(100) >= Percentage then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Service = vRP.NumPermission("Policia")
				for Passports, Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush", Sources,
							{
								code = 20,
								title = "Venda de Drogas",
								x = Coords["x"],
								y = Coords["y"],
								z = Coords["z"],
								criminal = "Ligação Anônima",
								time = "Recebido às " .. os.date("%H:%M"),
								blipColor = 16
							})
					end)
				end
			end

			Drugs[Passport] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.ConsultItem(Passport, "carjack", 1) then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 60
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("Progress", source, "Desvirando", 60000)
			vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)
					Player(source)["state"]["Buttons"] = false

					local Players = vRPC.Players(source)
					for _, v in pairs(Players) do
						async(function()
							TriggerClientEvent("target:RollVehicle", v, Entity[4])
						end)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você precisa de <b>1x " .. itemName("carjack") .. "</b>.",
				"Aviso", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RegistersTimers(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vCLIENT.checkWeapon(source, "WEAPON_CROWBAR") then
			TriggerClientEvent("Notify", source, "amarelo",
				"Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção", 5000)
			return false
		end

		if Registers[Number] then
			if GetGameTimer() < Registers[Number] then
				TriggerClientEvent("Notify", source, "vermelho", "Sistema indisponível no momento.", "Aviso", 5000)
				return false
			else
				InitRegisters(Number, source)
				return true
			end
		else
			InitRegisters(Number, source)
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INITREGISTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function InitRegisters(Number, source)
	Registers[Number] = GetGameTimer() + (20 * 60000)

	if math.random(100) >= 75 then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		local Service = vRP.NumPermission("Policia")
		for Passports, Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush", Sources,
					{
						code = 31,
						title = "Caixa Registradora",
						x = Coords["x"],
						y = Coords["y"],
						z = Coords["z"],
						criminal = "Alarme de segurança",
						time = "Recebido às " .. os.date("%H:%M"),
						blipColor = 16
					})
			end)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSPAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RegistersPay()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(1500, 3200)

		vRP.UpgradeStress(Passport, 2)
		vRP.GenerateItem(Passport, "dollars2", parseInt(Rand), true)

		TriggerEvent("Wanted", source, Passport, 300)
		TriggerClientEvent("player:Residuals", source, "Resíduo de Arrombamento.")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.MakePackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Pegando pacote", 10000)
		vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				if vRP.MaxItens(Passport, Service, 1) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
				else
					vRP.GenerateItem(Passport, Service, 1, true)

					if vCLIENT.TakePackage(source) then
						vCLIENT.CheckPackage(source)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DeliverPackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport, Service, 1, true) then
			vCLIENT.FinishPackage(source)

			local Experience = vRP.GetExperience(Passport, "Delivery")
			local Category = ClassCategory(Experience)
			local Valuation = 3500

			if Category == 1 then
				Valuation = Valuation + 10
			elseif Category == 2 then
				Valuation = Valuation + 20
			elseif Category == 3 then
				Valuation = Valuation + 30
			elseif Category == 4 then
				Valuation = Valuation + 40
			elseif Category == 5 then
				Valuation = Valuation + 50
			elseif Category == 6 then
				Valuation = Valuation + 60
			elseif Category == 7 then
				Valuation = Valuation + 70
			elseif Category == 8 then
				Valuation = Valuation + 80
			elseif Category == 9 then
				Valuation = Valuation + 90
			elseif Category == 10 then
				Valuation = Valuation + 100
			end

			if Buffs["Luck"][Passport] then
				if Buffs["Luck"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end
			end

			TriggerClientEvent("inventory:Update", source, "Backpack")
			vRP.GenerateItem(Passport, "dollars", Valuation, true)
			vRP.PutExperience(Passport, "Delivery", 1)
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você precisa de <b>1x " .. itemName(Service) .. "</b>.",
				"Aviso", 5000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ShotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		local services = { "Policia", "PoliciaNorte" }
		for _, service in ipairs(services) do
			local Service = vRP.NumPermission(service)
			for Passports, Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("NotifyPush", Sources,
						{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 6 })
				end)
			end
		end

		vRP.UpgradeStress(Passport, math.random(2, 4))
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience(Category)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return vRP.GetExperience(Passport, Category)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDLETTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:SendLetter")
AddEventHandler("inventory:SendLetter", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.ConsultItem(Passport, "notepad", 1) then
			local Keyboard = vKEYBOARD.Secondary(source, "Passaporte:", "Mensagem:")
			if Keyboard then
				if vRP.TakeItem(Passport, "notepad", 1, true) then
					local Time = os.time()
					vRP.SetSrvData("notepad-" .. Time, Keyboard[2])
					vRP.GenerateItem(Keyboard[1], "notepad-" .. Time, 1, true)
				end
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x " .. itemName("notepad") .. "</b>.",
				"Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer", function(source, Passport, Name, Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:" .. Name, source, Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Ammos[Passport] and Attachs[Passport] then
		if Temporary[Passport] then
			Ammos[Passport] = Temporary[Passport]["Ammos"]
			Attachs[Passport] = Temporary[Passport]["Attachs"]
			Temporary[Passport] = nil
		end

		vRP.Query("playerdata/SetData",
			{ Passport = Passport, dkey = "Attachs", dvalue = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Ammos", dvalue = json.encode(Ammos[Passport]) })
		Attachs[Passport] = nil
		Ammos[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if verifyObjects[Passport] then
		verifyObjects[Passport] = nil
	end

	if verifyAnimals[Passport] then
		verifyAnimals[Passport] = nil
	end

	if Loots[Passport] then
		Loots[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Scanners[Passport] then
		Scanners[Passport] = nil
	end

	if Carry[Passport] then
		if vRP.Passport(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry", Carry[Passport], nil, "Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
			vRPC.Destroy(Carry[Passport])
		end

		Carry[Passport] = nil
	end
	if Drugs[Passport] then
		Drugs[Passport] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET DROP
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ local clearDropsInterval = 1000 * 60 * AutoClearItemsTime
CreateThread(function()
	while true do
		Wait(clearDropsInterval - (1000 * 60 * 5))
		TriggerClientEvent("chat:ClientMessage", -1, 'Prefeitura', 'Os items do chão vão ser deletados em 5 minutos',
			'OOC')
		Wait(1000 * 60 * 4)
		TriggerClientEvent("chat:ClientMessage", -1, 'Prefeitura', 'Os items do chão vão ser deletados em 1 minuto',
			'OOC')
		Wait(1000 * 60 * 1)
		TriggerClientEvent("itemdrop:Remove", -1)
		Drops = {}
		TriggerClientEvent("chat:ClientMessage", -1, 'Prefeitura', 'Os items do chão foram deletados', 'OOC')
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	Ammos[Passport] = vRP.UserData(Passport, "Ammos")
	Attachs[Passport] = vRP.UserData(Passport, "Attachs")

	TriggerClientEvent("objects:Table", source, Objects)
	TriggerClientEvent("drops:Table", source, Drops)

	for Name, _ in pairs(Buffs) do
		if Buffs[Name][Passport] then
			if os.time() < Buffs[Name][Passport] then
				TriggerClientEvent("hud:" .. Name, source, Buffs[Name][Passport] - os.time())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buffs", function(Mode, Passport)
	return Buffs[Mode][Passport]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Silenced)
	local List = vRP.Players()
	for Passport, _ in pairs(List) do
		vRP.Query("playerdata/SetData",
			{ Passport = Passport, dkey = "Attachs", dvalue = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Ammos", dvalue = json.encode(Ammos[Passport]) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CleanWeapons", function(Passport, Clean)
	local source = vRP.Source(Passport)
	if source then
		local Ped = GetPlayerPed(source)
		local Weapon = GetSelectedPedWeapon(Ped)

		RemoveWeaponFromPed(Ped, Weapon)
		RemoveAllPedWeapons(Ped, false)
		SetPedAmmo(Ped, Weapon, 0)

		if Clean then
			Attachs[Passport] = {}
			Ammos[Passport] = {}
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}
function Creative.openStackChest(chestOpen, Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		local Chest = {}
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)

		for Index, v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["name"] = itemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>" .. v["name"] .. "</item>"

			local Split = splitString(v["item"])
			local Description = itemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"] .. "<br><description>" .. Description .. "</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Medic"] = "Inativo"
						v["Passport"] = Number
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Blood"] = Sanguine(Identity["blood"])
						v["Name"] = Identity["name"] .. " " .. Identity["name2"]

						if Identity["gunlicense"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["medicplan"] > os.time() then
								v["Medic"] = MinimalTimers(Identity["medicplan"] - os.time())
							end

							if Identity["premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["premium"] - os.time())
							end

							if Identity["rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"] ..
								"<br><description>Número: <green>" ..
								v["Passport"] ..
								"</green>.<br>Nome: <green>" ..
								v["Name"] ..
								"</green>.<br>Tipo Sangüineo: <green>" ..
								v["Blood"] .. "</green>.<br>Porte de Armas: <green>" .. v["Port"] ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Número: <green>" ..
								v["Passport"] ..
								"</green>.<br>Nome: <green>" ..
								v["Name"] ..
								"</green>.<br>Tipo Sangüineo: <green>" ..
								v["Blood"] ..
								"</green>.<br>Porte de Armas: <green>" ..
								v["Port"] ..
								"</green>.<br>Plano Médico: <green>" ..
								v["Medic"] ..
								"</green>.<br>Passe Mensal: <green>" ..
								v["Rolepass"] ..
								"</green>.<br>Premium: <green>" .. v["Premium"] .. "</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["name"] .. " " .. Identity["name2"]

						if Number == Passport then
							if Identity["driverlicense"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["driverlicense"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"] ..
							"<br><description>Número: <green>" ..
							v["Passport"] ..
							"</green>.<br>Nome: <green>" ..
							v["Name"] .. "</green>.<br>Habilitação: <green>" ..
							v["Driverlicense"] .. "</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"] ..
						"<br><description>Placa do Veículo: <green>" .. Split[2] .. "</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"] ..
						"<br><description>Saldo bancário disponível: <green>$" ..
						parseFormat(vRP.GetBank(source)) .. "</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"] .. "<br><description>" .. vRP.GetSrvData(v["item"]) .. ".</description>"
				end


				if Split[1] == "silverring" then
					if not v["desc"] then
						v["desc"] = "<br><description>Namorando com: <green>" .. vRP.FullName(Split[2]) ..
							"</green>.</description>"
					else
						v["desc"] = v["desc"] ..
							"<br><description>Namorando com: <green>" .. vRP.FullName(Split[2]) ..
							"</green>.</description>"
					end
				end

				if Split[1] == "goldring" then
					if not v["desc"] then
						v["desc"] = "<br><description>Casado com: <green>" .. vRP.FullName(Split[2]) ..
							"</green>.</description>"
					else
						v["desc"] = v["desc"] ..
							"<br><description>Casado com: <green>" .. vRP.FullName(Split[2]) ..
							"</green>.</description>"
					end
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"] .. "<br><description>" .. vRP.GetSrvData(v["item"]) .. ".</description>"
				end

				if Split[1] == "suitcase" or Split[1] == "protectorcase" then
					v["desc"] = v["desc"] ..
						"<br><description>Contém <green>$" .. parseFormat(Split[2]) .. "</green>.</description>"
				end

				if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
					v["desc"] = v["desc"] ..
						"<br><description>Tipo sanguíneo encontrado: <green>" ..
						Sanguine(vRP.Identity(Split[2])["blood"]) .. "</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"] ..
						"<br><description>A pureza " ..
						Item .. " se encontra em <green>" .. (Split[2] or 0) .. "%</green>.</description>"
				end
			end

			local Max = itemMaxAmount(v["item"])
			if not Max then
				Max = "S/L"
			end

			v["desc"] = v["desc"] ..
				"<br><legenda>Economia: <r>" .. itemEconomy(v["item"]) .. "</r> <s>|</s> Máximo: <r>" ..
				Max .. "</r></legenda>"

			if Split[2] then

				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				end
			end

			Inventory[Index] = v
		end

		local Result = vRP.GetSrvData(Open[Passport]["Name"])
		for Index, v in pairs(Result) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["name"] = itemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>" .. v["name"] .. "</item>"

			local Split = splitString(v["item"])
			local Description = itemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"] .. "<br><description>" .. Description .. "</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Medic"] = "Inativo"
						v["Passport"] = Number
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Blood"] = Sanguine(Identity["blood"])
						v["Name"] = Identity["name"] .. " " .. Identity["name2"]

						if Identity["gunlicense"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["medicplan"] > os.time() then
								v["Medic"] = MinimalTimers(Identity["medicplan"] - os.time())
							end

							if Identity["premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["premium"] - os.time())
							end

							if Identity["rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"] ..
								"<br><description>Número: <green>" ..
								v["Passport"] ..
								"</green>.<br>Nome: <green>" ..
								v["Name"] ..
								"</green>.<br>Tipo Sangüineo: <green>" ..
								v["Blood"] .. "</green>.<br>Porte de Armas: <green>" .. v["Port"] ..
								"</green>.</description>"
						else
							v["desc"] = v["desc"] ..
								"<br><description>Número: <green>" ..
								v["Passport"] ..
								"</green>.<br>Nome: <green>" ..
								v["Name"] ..
								"</green>.<br>Tipo Sangüineo: <green>" ..
								v["Blood"] ..
								"</green>.<br>Porte de Armas: <green>" ..
								v["Port"] ..
								"</green>.<br>Plano Médico: <green>" ..
								v["Medic"] ..
								"</green>.<br>Passe Mensal: <green>" ..
								v["Rolepass"] ..
								"</green>.<br>Premium: <green>" .. v["Premium"] .. "</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["name"] .. " " .. Identity["name2"]

						if Number == Passport then
							if Identity["driverlicense"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["driverlicense"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"] ..
							"<br><description>Número: <green>" ..
							v["Passport"] ..
							"</green>.<br>Nome: <green>" ..
							v["Name"] .. "</green>.<br>Habilitação: <green>" ..
							v["Driverlicense"] .. "</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"] ..
						"<br><description>Placa do Veículo: <green>" .. Split[2] .. "</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"] ..
						"<br><description>Saldo bancário disponível: <green>$" ..
						parseFormat(vRP.GetBank(source)) .. "</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"] .. "<br><description>" .. vRP.GetSrvData(v["item"]) .. ".</description>"
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"] .. "<br><description>" .. vRP.GetSrvData(v["item"]) .. ".</description>"
				end

				if Split[1] == "suitcase" or Split[1] == "protectorcase" then
					v["desc"] = v["desc"] ..
						"<br><description>Contém <green>$" .. parseFormat(Split[2]) .. "</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"] ..
						"<br><description>A pureza " ..
						Item .. " se encontra em <green>" .. (Split[2] or 0) .. "%</green>.</description>"
				end
			end

			local Max = itemMaxAmount(v["item"])
			if not Max then
				Max = "S/L"
			end

			v["desc"] = v["desc"] ..
				"<br><legenda>Economia: <r>" .. itemEconomy(v["item"]) .. "</r> <s>|</s> Máximo: <r>" ..
				Max .. "</r></legenda>"

			if Split[2] then

				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				end
			end

			Chest[Index] = v
		end

		return Chest, Open[Passport]["Weight"]
	end
end

function Creative.ChestPermissions(Name, Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Personal" then
			Open[Passport] = {
				["Name"] = "Personal:" .. Passport,
				["Weight"] = 50,
				["Logs"] = false,
				["Save"] = true,
				["Slots"] = 50
			}

			return true
		elseif Mode == "Tray" then
			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 25,
				["Logs"] = false,
				["Save"] = false,
				["Slots"] = 20
			}
			return true
		elseif Mode == "Custom" or Mode == "Trash" then
			if SplitOne(Name, ":") == "Helicrash" and Cooldown[Name] and Cooldown[Name] > os.time() then
				TriggerClientEvent("Notify", source, "amarelo", "Aguarde até que esfrie o compartimento.", "Atenção",
					10000)
				vRPC.DowngradeHealth(source, 50)

				return false
			end

			if Mode == "Trash" then
				Name = "Trash:" .. Name
			end

			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 50,
				["Logs"] = false,
				["Save"] = false,
				["Slots"] = 20
			}
			return true
		elseif Mode == "Lider" or Mode == '4' then
			Name = 'Lider' .. Name
			local Consult = vRP.Query("chests/GetChests", { name = Name })
			if Consult[1] and vRP.HasGroup(Passport, Consult[1]["Permission"], 2) then
				local Slots = Consult[1]["Slots"]
				local Weight = Consult[1]["Weight"]
				Open[Passport] = {
					["Slots"] = Slots,
					["Weight"] = Weight,
					["NameLogs"] = Name,
					["Name"] = "Chest:" .. Name,
					["Logs"] = Consult[1]["Logs"],
					["Permission"] = Consult[1]["Permission"],
					["Save"] = true
				}
				return true
			end
			return false
		elseif Mode == "Home" then
			local Consult = vRP.Query("chests/GetChests", { name = Name })
			if Consult[1] and vRP.HasGroup(Passport, Consult[1]["Permission"], 2) then
				local Slots = Consult[1]["Slots"]
				local Weight = Consult[1]["Weight"]
				Open[Passport] = {
					["Slots"] = Slots,
					["Weight"] = Weight,
					["NameLogs"] = Name,
					["Name"] = "Chest:" .. Name,
					["Logs"] = Consult[1]["Logs"],
					["Permission"] = Consult[1]["Permission"],
					["Save"] = true
				}
				return true
			end
			return false
		else
			local Consult = vRP.Query("chests/GetChests", { name = Name })
			local hasPerm = false
			if Consult[1] then
				if vRP.GroupType(Consult[1]["Permission"]) == "Org" then
					hasPerm = vRP.HasPermission(Passport, Consult[1]["Permission"], 4)
				else
					hasPerm = vRP.HasGroup(Passport, Consult[1]["Permission"])
				end
				if hasPerm then
					local Slots = Consult[1]["Slots"]
					local Weight = Consult[1]["Weight"]

					Open[Passport] = {
						["Slots"] = Slots,
						["Weight"] = Weight,
						["NameLogs"] = Name,
						["Name"] = "Chest:" .. Name,
						["Logs"] = Consult[1]["Logs"],
						["Permission"] = Consult[1]["Permission"],
						["Save"] = true
					}

					return true
				end
			end
		end
	end

	return false
end

function Creative.storeChestItem(Item, Slot, Amount, Target)
	local source = source
	local Amount = parseInt(Amount, true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		TriggerClientEvent("chest:Update", source, "Refresh")

		if Item == "diagram" and Open[Passport]["NameLogs"] then
			if vRP.TakeItem(Passport, Item, Amount, false) then
				Open[Passport]["Weight"] = Open[Passport]["Weight"] + (10 * Amount)

				local Result = vRP.GetSrvData(Open[Passport]["Name"])
				vRP.Query("chests/UpdateChests", { name = Open[Passport]["NameLogs"] })
				TriggerClientEvent("chest:Update", source, "Update", vRP.InventoryWeight(Passport),
					vRP.GetWeight(Passport), vRP.ChestWeight(Result), Open[Passport]["Weight"])
				TriggerClientEvent("chest:Update", source, "Refresh")
			end
		else
			local Item = SplitOne(Item)
			local Unique = Open[Passport]["Unique"]

			if Unique and ChestItens[Unique] and ((ChestItens[Item] and ChestItens[Item]["Block"]) or (ChestItens[Unique]["Itens"] and not ChestItens[Unique]["Itens"][Item])) then
				TriggerClientEvent("chest:Update", source, "Refresh")
				return false
			end

			if vRP.StoreChest(Passport, Open[Passport]["Name"], Amount, Open[Passport]["Weight"], Slot, Target) then
				TriggerClientEvent("chest:Update", source, "Refresh")
			else
				local Result = vRP.GetSrvData(Open[Passport]["Name"])
				TriggerClientEvent("chest:Update", source, "Update", vRP.InventoryWeight(Passport),
					vRP.GetWeight(Passport), vRP.ChestWeight(Result), Open[Passport]["Weight"])
				if Open[Passport]["Logs"] then
					--[[ exports['logs']:chestLog(source, Passport, itemName(Item), Amount, 5, (itemWeight(Item) * Amount),
						vRP.ChestWeight(Result), Open[Passport]["Weight"], 'Guardado', 'Baú', Open[Passport]["Name"],
						5763719) ]]
				end
			end
		end
	end
end

function Creative.takeChestItem(Item, Slot, Amount, Target)
	local source = source
	local Amount = parseInt(Amount, true)
	local Passport = vRP.Passport(source)

	if Passport and Open[Passport] then
		if vRP.TakeChest(Passport, Open[Passport]["Name"], Amount, Slot, Target) then
			TriggerClientEvent("chest:Update", source, "Refresh")
		else
			local Result = vRP.GetSrvData(Open[Passport]["Name"])
			TriggerClientEvent("chest:Update", source, "Update", vRP.InventoryWeight(Passport), vRP.GetWeight(Passport),
				vRP.ChestWeight(Result), Open[Passport]["Weight"])

			if string.sub(Open[Passport]["Name"], 1, 9) == "Helicrash" and json.encode(Result) == "[]" then
				TriggerClientEvent("chest:Close", source)
				exports["helicrash"]:Box()
			end

			if Open[Passport]["Item"] and json.encode(Result) == "[]" then
				vRP.RemoveItem(Passport, Open[Passport]["Item"], 1, false)
				TriggerClientEvent("chest:Update", source, "Refresh")
			end
			if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
				if Open[Passport]["Logs"] then
					--[[ exports['logs']:chestLog(source, Passport, itemName(Item), Amount, 5, (itemWeight(Item) * Amount),
						vRP.ChestWeight(Result),
						Open[Passport]["Weight"],
						'Retirado', 'Baú', Open[Passport]["Name"], 15548997) ]]
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local openPlayer = {}
local openSource = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runInspect")
AddEventHandler("police:runInspect", function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		openSource[Passport] = Entity[1]
		openPlayer[Passport] = vRP.Passport(Entity[1])

		TriggerClientEvent("player:Carry", Entity[1], source, "handcuff")
		TriggerClientEvent("player:Commands", Entity[1], true)
		TriggerClientEvent("inventory:Close", Entity[1])

		local myInventory = {}
		local inventory = vRP.Inventory(Passport)
		for k, v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"], "-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			if splitName[1] == "evidence01" or splitName[1] == "evidence02" or splitName[1] == "evidence03" or splitName[1] == "evidence04" and splitName[2] then
				if v["desc"] then
					v["desc"] = v["desc"] ..
						"<br><description>Tipo sanguíneo encontrado: <green>" ..
						Sanguine(vRP.Identity(splitName[2])["blood"]) .. "</green>.</description>"
				else
					v["desc"] = "<description>Tipo sanguíneo encontrado: <green>" ..
						Sanguine(vRP.Identity(splitName[2])["blood"]) .. "</green>.</description>"
				end
			end
			myInventory[k] = v
		end
		local otherInventory = {}
		local inventory = vRP.Inventory(openPlayer[Passport])
		for k, v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"], "-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			otherInventory[k] = v
		end

		vCLIENT.openInspect(source, myInventory, vRP.InventoryWeight(Passport), otherInventory,
			vRP.InventoryWeight(openPlayer[Passport]), openPlayer[Passport])
	end
end)


function Creative.resetInspect()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if openSource[Passport] then
			TriggerClientEvent("player:Commands", openSource[Passport], false)
			TriggerClientEvent("player:Carry", openSource[Passport], source)
			openSource[Passport] = nil
		end

		if openPlayer[Passport] then
			openPlayer[Passport] = nil
		end
	end
end

function Creative.storeInspectItem(Item, Slot, Amount, Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if openSource[Passport] then
			local Ped = GetPlayerPed(openSource[Passport])
			if DoesEntityExist(Ped) then
				if vRP.MaxItens(openPlayer[Passport], Item, Amount) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
					TriggerClientEvent("inspect:Update", source, "Request")
					return
				end

				if (vRP.InventoryWeight(openPlayer[Passport]) + (itemWeight(Item) * Amount)) <= vRP.GetWeight(openPlayer[Passport]) then
					if vRP.TakeItem(Passport, Item, Amount, true) then
						vRP.GiveItem(openPlayer[Passport], Item, Amount, true, Target)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					TriggerClientEvent("inspect:Update", source, "Request")
				end
			end
		end
	end
end

function Creative.takeInspectItem(Item, Slot, Amount, Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if openSource[Passport] then
			if DoesEntityExist(GetPlayerPed(openSource[Passport])) then
				if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * Amount)) <= vRP.GetWeight(Passport) then
					if vRP.TakeItem(openPlayer[Passport], Item, Amount, true) then
						vRP.GiveItem(Passport, Item, Amount, true, Target)
						TriggerClientEvent("inspect:Update", source, "Request")
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					TriggerClientEvent("inspect:Update", source, "Request")
				end
			end
		end
	end
end
