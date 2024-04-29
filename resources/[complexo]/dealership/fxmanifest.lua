fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/config/Vehicle.lua",
	"shared/*"
}

client_scripts {
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*",
	"client-side/classes/*"
}

server_scripts {
	"@vrp/config/Vehicle.lua",
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

ui_page "web/index.html"
files {
	"web/**/*"
}
