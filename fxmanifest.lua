fx_version 'cerulean'
game 'gta5'

ui_page 'nui/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    '@rs_base/import.lua',
    'config.lua'
}

client_script {
    'client/*.lua',
    'config.lua'

}

server_script {
    'server/*.lua',
}

files {
    'nui/index.html',
    'nui/css/*.css',
    'nui/js/*.js',
}

lua54 'yes'