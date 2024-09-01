fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'TheLux RDR Weed Job'
version '1.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua',
    'client/npcs.lua',
    'client/props.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
}

dependencies {
    'rsg-core',
    'rsg-target',
    'ox_lib',
    'vorp_core',
    'qbr-core',
    'syn_framework',
}

lua54 'yes'
