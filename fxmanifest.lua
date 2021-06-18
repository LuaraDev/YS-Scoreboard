fx_version 'cerulean'
games { 'gta5' }

description 'YS Scoreboard, Modern UI and Awesome Performance'
version '0.0.3'
author 'dz-security.live'

client_script 'client/cl_main.lua'
server_script 'server/sv_main.lua'
server_script 'config.lua'

ui_page 'nui/index.html'
files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
}