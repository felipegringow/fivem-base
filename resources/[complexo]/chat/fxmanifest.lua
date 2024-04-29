fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "html/index.html"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/lib/Tunnel.lua",
	"@vrp/lib/Proxy.lua",
}

client_scripts {
	"suggestions.lua",
	"cl_chat.lua"
}

server_scripts {
	"sv_chat.lua"
}

files {
	"html/**/*",
}