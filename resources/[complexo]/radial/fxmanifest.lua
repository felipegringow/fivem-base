fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web-side/ui.html"

shared_scripts {
    "@vrp/lib/utils.lua",
    "@vrp/lib/Proxy.lua",
    "@vrp/lib/Tunnel.lua",
    "shared/cfg.lua",
}

client_script "client-side/*"
server_script "server-side/*"

files {
	"web-side/*",
	"web-side/**/*"
}