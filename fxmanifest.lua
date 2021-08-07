games {'gta5'}

fx_version 'cerulean'

description "Spontane Roleplay | Black Market System | 16.06.2021"

client_scripts {
  "client/cl_*.lua"
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "server/sv_*.lua"
}

files {
  'client/nui/index.html',
  'client/nui/assets/css/style.css',
  'client/nui/assets/js/app.js',
  'client/nui/assets/image/*.png',
}

ui_page "client/nui/index.html"