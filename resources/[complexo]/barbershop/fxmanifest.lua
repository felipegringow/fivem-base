fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

shared_scripts {
	"@vrp/lib/utils.lua",
	"@vrp/lib/Tunnel.lua",
	"@vrp/lib/Proxy.lua",
}

client_scripts {
	"client-side/*"
}

server_scripts {
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}