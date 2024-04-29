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
Tunnel.bindInterface("doors",Creative)
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	[1] = { Coords = vec3(431.41,-999.59,28.68), Hash = 2130672747, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[2] = { Coords = vec3(452.30,-1000.80,28.68), Hash = 2130672747, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[3] = { Coords = vec3(488.89,-1016.89,27.14), Hash = -1603817716, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[4] = { Coords = vec3(476.61,-1008.87,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[5] = { Coords = vec3(481.00,-1004.11,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[6] = { Coords = vec3(477.91,-1012.18,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[7] = { Coords = vec3(480.91,-1012.18,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[8] = { Coords = vec3(483.91,-1012.18,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[9] = { Coords = vec3(486.91,-1012.18,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[10] = { Coords = vec3(484.17,-1007.73,26.48), Hash = -53345114, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[11] = { Coords = vec3(440.52,-977.60,30.82), Hash = 2888281650, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[12] = { Coords = vec3(440.52,-986.23,30.82), Hash = 4198287975, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[13] = { Coords = vec3(479.75,-999.62,30.78), Hash = -692649124, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[14] = { Coords = vec3(487.43,-1000.18,30.78), Hash = -692649124, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[15] = { Coords = vec3(467.36,-1014.40,26.48), Hash = -692649124, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 16 },
	[16] = { Coords = vec3(469.77,-1014.40,26.48), Hash = -692649124, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 15 },
	[17] = { Coords = vec3(440.73,-998.74,30.81), Hash = -1547307588, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 18 },
	[18] = { Coords = vec3(443.06,-998.74,30.81), Hash = -1547307588, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 17 },
	[19] = { Coords = vec3(458.20,-972.25,30.81), Hash = -1547307588, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 20 },
	[20] = { Coords = vec3(455.88,-972.25,30.81), Hash = -1547307588, Lock = true, Text = true, Distance = 1.5, Perm = "Police", Other = 19 },
	[21] = { Coords = vec3(1844.99,2604.81,44.63), Hash = 741314661, Lock = true, Text = true, Distance = 7, Perm = "Emergency" },
	[22] = { Coords = vec3(1818.54,2604.40,44.61), Hash = 741314661, Lock = true, Text = true, Distance = 7, Perm = "Emergency" },
	[23] = { Coords = vec3(1837.91,2590.25,46.19), Hash = 539686410, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[24] = { Coords = vec3(1768.54,2498.41,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[25] = { Coords = vec3(1765.40,2496.59,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[26] = { Coords = vec3(1762.25,2494.77,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[27] = { Coords = vec3(1755.96,2491.14,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[28] = { Coords = vec3(1752.81,2489.33,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[29] = { Coords = vec3(1749.67,2487.51,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[30] = { Coords = vec3(1758.07,2475.39,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[31] = { Coords = vec3(1761.22,2477.20,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[32] = { Coords = vec3(1764.36,2479.02,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[33] = { Coords = vec3(1767.51,2480.84,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[34] = { Coords = vec3(1770.66,2482.65,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[35] = { Coords = vec3(1773.80,2484.47,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[36] = { Coords = vec3(1776.95,2486.29,45.88), Hash = 913760512, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	-- [37] = { Coords = vec3(383.40,798.29,187.61), Hash = 517369125, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	-- [38] = { Coords = vec3(382.96,796.82,187.61), Hash = 517369125, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	-- [39] = { Coords = vec3(378.75,796.83,187.61), Hash = 517369125, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[40] = { Coords = vec3(398.15,-1607.52,28.34), Hash = 1286535678, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[41] = { Coords = vec3(413.09,-1619.81,28.34), Hash = -1483471451, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[42] = { Coords = vec3(418.54,-1651.08,28.29), Hash = -1483471451, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[43] = { Coords = vec3(1861.75,3687.30,33.01), Hash = 1286535678, Lock = true, Text = true, Distance = 7, Perm = "Police" },
	[44] = { Coords = vec3(-443.64,6006.97,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[45] = { Coords = vec3(-442.24,6012.61,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[46] = { Coords = vec3(-445.94,6012.88,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[47] = { Coords = vec3(-448.91,6015.85,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[48] = { Coords = vec3(-446.36,6018.40,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[49] = { Coords = vec3(-443.39,6015.43,27.73), Hash = -594854737, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[51] = { Coords = vec3(369.06,-1605.68,29.94), Hash = -674638964, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[52] = { Coords = vec3(368.26,-1605.01,29.94), Hash = -674638964, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[53] = { Coords = vec3(375.07,-1598.43,25.34), Hash = -674638964, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[54] = { Coords = vec3(375.87,-1599.10,25.34), Hash = -674638964, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[55] = { Coords = vec3(1813.55,3675.05,34.39), Hash = 2010487154, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[56] = { Coords = vec3(1810.13,3676.46,34.39), Hash = 2010487154, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[57] = { Coords = vec3(1808.62,3679.06,34.39), Hash = 2010487154, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[58] = { Coords = vec3(1807.13,3681.66,34.39), Hash = 2010487154, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[59] = { Coords = vec3(391.86,-1636.07,29.97), Hash = -1156020871, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	-- [71] = { Coords = vec3(309.13,-597.75,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [72] = { Coords = vec3(307.11,-569.56,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Emergency" },
	-- [73] = { Coords = vec3(336.16,-580.14,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [74] = { Coords = vec3(340.78,-581.82,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [75] = { Coords = vec3(346.77,-584.00,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [76] = { Coords = vec3(339.00,-586.70,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [77] = { Coords = vec3(360.50,-588.99,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [78] = { Coords = vec3(358.72,-593.88,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [79] = { Coords = vec3(352.19,-594.14,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [80] = { Coords = vec3(350.83,-597.89,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [81] = { Coords = vec3(345.51,-597.35,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [82] = { Coords = vec3(346.88,-593.59,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [83] = { Coords = vec3(356.12,-583.36,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [84] = { Coords = vec3(357.49,-579.61,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [85] = { Coords = vec3(303.95,-572.55,43.43), Hash = 854291622, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic" },
	-- [86] = { Coords = vec3(324.23,-589.22,43.43), Hash = -434783486, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 87 },
	-- [87] = { Coords = vec3(326.65,-590.10,43.43), Hash = -1700911976, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 86 },
	-- [88] = { Coords = vec3(312.00,-571.34,43.43), Hash = -434783486, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 89 },
	-- [89] = { Coords = vec3(314.42,-572.22,43.43), Hash = -1700911976, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 88 },
	-- [90] = { Coords = vec3(317.84,-573.46,43.43), Hash = -434783486, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 91 },
	-- [91] = { Coords = vec3(320.26,-574.34,43.43), Hash = -1700911976, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 90 },
	-- [92] = { Coords = vec3(323.23,-575.42,43.43), Hash = -434783486, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 93 },
	-- [93] = { Coords = vec3(325.65,-576.30,43.43), Hash = -1700911976, Lock = true, Text = true, Distance = 1.5, Perm = "Paramedic", Other = 92 },
	[94] = { Coords = vec3(475.39,-989.82,26.35), Hash = -692649124, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[95] = { Coords = vec3(384.43,-1601.95,30.04), Hash = -1335406364, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[96] = { Coords = vec3(374.64,-1613.63,30.04), Hash = -1335406364, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[97] = { Coords = vec3(1776.2,2552.57,45.75), Hash = 1373390714, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[98] = { Coords = vec3(1791.6,2551.47,45.76), Hash = 1373390714, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[99] = { Coords = vec3(1819.08,2594.88,46.09), Hash = 1373390714, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	[100] = { Coords = vec3(1831.35,2595.0,46.04), Hash = -684929024, Lock = true, Text = true, Distance = 1.5, Perm = "Police" },
	-- [101] = { Coords = vec3(805.03,-747.97,27.25), Hash = 95403626, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis", Other = 102 },
	-- [102] = { Coords = vec3(803.98,-747.97,27.25), Hash = -49173194, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis", Other = 101 },
	-- [103] = { Coords = vec3(794.29,-757.62,27.25), Hash = 95403626, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis", Other = 104 },
	-- [104] = { Coords = vec3(794.28,-758.82,27.25), Hash = -49173194, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis", Other = 103 },
	[105] = { Coords = vec3(814.51,-763.74,27.25), Hash = -420112688, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[106] = { Coords = vec3(809.54,-756.22,27.25), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[107] = { Coords = vec3(811.95,-763.28,27.25), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[108] = { Coords = vec3(807.00,-765.66,27.25), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[109] = { Coords = vec3(805.30,-759.26,27.25), Hash = -357301147, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[110] = { Coords = vec3(804.42,-767.12,31.75), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[111] = { Coords = vec3(797.81,-763.26,31.75), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[112] = { Coords = vec3(797.92,-758.19,31.75), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[113] = { Coords = vec3(806.83,-764.04,31.75), Hash = 1984391163, Lock = true, Text = true, Distance = 1.5, Perm = "PizzaThis" },
	[120] = { Coords = vec3(835.61,-908.61,29.35), Hash = 2055788206, Lock = true, Text = true, Distance = 7, Perm = "Dracing" },
	[122] = { Coords = vec3(-197.44,-1339.14,31.47), Hash = -147325430, Lock = true, Text = true, Distance = 1.5, Perm = "Bennys" },
	[123] = { Coords = vec3(-197.44,-1322.07,31.47), Hash = -147325430, Lock = true, Text = true, Distance = 1.5, Perm = "Bennys" },
	[124] = { Coords = vec3(-1179.22,-891.5,14.1), Hash = -1300743830, Lock = true, Text = true, Distance = 1.5, Perm = "BurgerShot" },
	[125] = { Coords = vec3(-1193.97,-900.42,14.25), Hash = -1448591934, Lock = true, Text = true, Distance = 1.5, Perm = "BurgerShot" },
	[126] = { Coords = vec3(-1182.09,-895.49,14.14), Hash = 1042741067, Lock = true, Text = true, Distance = 1.5, Perm = "BurgerShot-2" },
	[127] = { Coords = vec3(-600.91,-1059.21,21.73), Hash = 522844070, Lock = true, Text = true, Distance = 7, Perm = "UwuCoffee" },
	[128] = { Coords = vec3(-600.88,-1055.13,22.72), Hash = 1099436502, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee" },
	[129] = { Coords = vec3(-591.76,-1066.97,22.54), Hash = -562476388, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee" },
	[130] = { Coords = vec3(-592.47,-1056.09,22.42), Hash = -60871655, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee" },
	[131] = { Coords = vec3(-594.41,-1049.76,22.5), Hash = 2089009131, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee-2" },
	[132] = { Coords = vec3(-575.01,-1062.38,26.77), Hash = 2089009131, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee-2" },
	[133] = { Coords = vec3(-575.01,-1063.78,26.77), Hash = 2089009131, Lock = true, Text = true, Distance = 1.5, Perm = "UwuCoffee-2" },

	[150] = { Coords = vec3(-1111.63,4938.29,218.52), Hash = 825709191, Lock = true, Text = true, Distance = 1.5, Perm = "Tribo" },
	[151] = { Coords = vec3(-1102.26,4940.41,218.52), Hash = 825709191, Lock = true, Text = true, Distance = 1.5, Perm = "Tribo" },
	[152] = { Coords = vec3(493.07,-1541.83,29.44), Hash = 903896222, Lock = true, Text = true, Distance = 1.5, Perm = "Aztecas" },
	[153] = { Coords = vec3(486.01,-1530.39,29.44), Hash = 2103001488, Lock = true, Text = true, Distance = 1.5, Perm = "Aztecas" },
	[154] = { Coords = vec3(-1.87,-1808.82,25.54), Hash = -1351120742, Lock = true, Text = true, Distance = 1.5, Perm = "Ballas" },
	[155] = { Coords = vec3(0.20,-1823.30,29.73), Hash = -1052955611, Lock = true, Text = true, Distance = 1.5, Perm = "Ballas" },
	[156] = { Coords = vec3(-152.02,-1622.64,33.83), Hash = 1381046002, Lock = true, Text = true, Distance = 1.5, Perm = "Families" },
	[157] = { Coords = vec3(99.63,3615.91,40.63), Hash = 190770132, Lock = true, Text = true, Distance = 1.5, Perm = "Lost" },
	[158] = { Coords = vec3(1250.21,-1583.80,54.73), Hash = -955445187, Lock = true, Text = true, Distance = 1.5, Perm = "Marabunta" },
	[159] = { Coords = vec3(1251.97,-1569.28,58.93), Hash = -658590816, Lock = true, Text = true, Distance = 1.5, Perm = "Marabunta" },
	[160] = { Coords = vec3(485.54,-96.34,63.32), Hash = 490866369, Lock = true, Text = true, Distance = 1.5, Perm = "Razors", Other = 161 },
	[161] = { Coords = vec3(487.79,-97.17,63.32), Hash = 1364395251, Lock = true, Text = true, Distance = 1.5, Perm = "Razors", Other = 160 },
	[162] = { Coords = vec3(-637.36,-1249.23,11.94), Hash = -636132164, Lock = true, Text = true, Distance = 1.5, Perm = "Triads", Other = 163 },
	[163] = { Coords = vec3(-639.82,-1248.90,11.94), Hash = 1215119726, Lock = true, Text = true, Distance = 1.5, Perm = "Triads", Other = 162 },
	[164] = { Coords = vec3(-643.14,-1229.26,11.68), Hash = 1215119726, Lock = true, Text = true, Distance = 1.5, Perm = "Triads", Other = 165 },
	[165] = { Coords = vec3(-644.47,-1227.16,11.68), Hash = -636132164, Lock = true, Text = true, Distance = 1.5, Perm = "Triads", Other = 164 },
	[166] = { Coords = vec3(324.71,-1991.08,24.36), Hash = 2118614536, Lock = true, Text = true, Distance = 1.5, Perm = "Vagos" },
	[167] = { Coords = vec3(336.74,-1991.84,24.36), Hash = 2118614536, Lock = true, Text = true, Distance = 1.5, Perm = "Vagos" },
	[168] = { Coords = vec3(153.87,-3023.88,10.74), Hash = -456733639, Lock = true, Text = true, Distance = 7, Perm = "Mechanic-3" },
	[169] = { Coords = vec3(153.43,-3034.05,10.94), Hash = -456733639, Lock = true, Text = true, Distance = 7, Perm = "Mechanic-3" },
	[170] = { Coords = vec3(-816.6,-694.39,28.21), Hash = 693644064, Lock = true, Text = true, Distance = 1.5, Perm = "YoungBoys" },
	[171] = { Coords = vec3(-816.6,-702.34,28.21), Hash = 693644064, Lock = true, Text = true, Distance = 1.5, Perm = "YoungBoys" },
	[172] = { Coords = vec3(-820.31,-703.12,28.21), Hash = 1403720845, Lock = true, Text = true, Distance = 1.5, Perm = "YoungBoys", Other = 173 },
	[173] = { Coords = vec3(-822.31,-703.12,28.21), Hash = 75593271, Lock = true, Text = true, Distance = 1.5, Perm = "YoungBoys", Other = 172 },
	[174] = { Coords = vec3(-816.22,-739.37,25.54), Hash = -700626879, Lock = true, Text = true, Distance = 7, Perm = "YoungBoys", Other = 172 },
	[175] = { Coords = vec3(-1146.69,-1991.94,16.17), Hash = -550347177, Lock = true, Text = true, Distance = 7, Perm = "Dracing" },
	[176] = { Coords = vec3(154.94,-3017.32,7.2), Hash = -2023754432, Lock = true, Text = true, Distance = 1.5, Perm = "Mechanic-3" },

	[200] = { Coords = vec3(1820.77,2620.78,45.96), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[201] = { Coords = vec3(1845.79,2698.63,45.96), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[202] = { Coords = vec3(1773.11,2759.7,45.89), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[203] = { Coords = vec3(1651.17,2755.44,45.88), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[204] = { Coords = vec3(1572.67,2679.2,45.73), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[205] = { Coords = vec3(1537.82,2586.0,45.69), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[206] = { Coords = vec3(1543.25,2471.3,45.72), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[207] = { Coords = vec3(1658.59,2397.73,45.72), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[208] = { Coords = vec3(1759.63,2412.84,45.72), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[209] = { Coords = vec3(1821.18,2476.27,45.69), Hash = -1033001619, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true },
	[210] = { Coords = vec3(29.58,-24.25,-23.91), Hash = 520341586, Lock = true, Text = false, Distance = 1.5, Perm = "Admin", Block = true }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DoorsPermission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not GlobalState["Doors"][Number]["Block"] then
		if GlobalState["Doors"][Number]["Perm"] then
			local Split = splitString(GlobalState["Doors"][Number]["Perm"],"-")

			if (Split[2] and not vRP.HasGroup(Passport,Split[1],parseInt(Split[2]))) or (not Split[2] and not vRP.HasService(Passport,GlobalState["Doors"][Number]["Perm"])) then
				local consultItem = vRP.InventoryItemAmount(Passport,"lockpick")
				if consultItem[1] <= 0 then
					return
				end

				if vRP.CheckDamaged(consultItem[2]) then
					TriggerClientEvent("Notify",source,"vermelho","<b>Lockpick de Alumínio</b> danificado.",false,5000)
					return
				end

				if not vTASKBAR.taskDoors(source) then
					if math.random(100) >= 60 then
						if vRP.TakeItem(Passport,consultItem[2],1,false) then
							vRP.GiveItem(Passport,"lockpick-0",1,false)
							TriggerClientEvent("itensNotify",source,{ "-","lockpick",1,"Lockpick de Alumínio" })
						end
					end
					return
				end

				local Coords = vRP.GetEntityCoords(source)
				local Service = vRP.NumPermission("Police")
				for Passports,Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "Tranca de Porta Violada", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end

		local Doors = GlobalState["Doors"]

		Doors[Number]["Lock"] = not Doors[Number]["Lock"]

		if Doors[Number]["Other"] ~= nil then
			local Second = Doors[Number]["Other"]
			Doors[Second]["Lock"] = not Doors[Second]["Lock"]
		end

		GlobalState:set("Doors",Doors,true)

		TriggerClientEvent("doors:Update",-1,Number,Doors[Number]["Lock"])

		vRPC.playAnim(source,true,{"anim@heists@keycard@","exit"},false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end