fx_version "adamant"
game "gta5" 

server_scripts {
   "@vrp/lib/Utils.lua",
   "server.lua"
}

client_scripts {
   "@vrp/lib/Utils.lua",
   "client.lua"
}

files {
   "nui/**/*",
}
ui_page "nui/index.html"