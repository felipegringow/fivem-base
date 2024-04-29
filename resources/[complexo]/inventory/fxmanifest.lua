fx_version "cerulean"
game "gta5"
lua54 "yes"

client_scripts {
    "@vrp/config/Native.lua",
    "@vrp/config/Vehicle.lua",
    "@vrp/config/Item.lua",
    "@PolyZone/client.lua",
    "@vrp/lib/Utils.lua",
    "client-side/*"
}

server_scripts {
    "@vrp/config/Vehicle.lua",
    "@vrp/config/Item.lua",
    "@vrp/config/Global.lua",
    "@vrp/lib/Utils.lua",
    "server-side/*"
}

ui_page "web-side/index.html"

files {
    "web-side/**/*"
}
