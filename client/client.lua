local RSGCore = exports['rsg-core']:GetCoreObject()
local currentLocation = nil
local cooldowns = {}

-- Helper function to check cooldown
local function isOnCooldown(action)
    if not cooldowns[action] then return false end
    return (GetGameTimer() - cooldowns[action]) < Config.ActionCooldown
end

-- Helper function to set cooldown
local function setCooldown(action)
    cooldowns[action] = GetGameTimer()
end

-- Initialize job locations
Citizen.CreateThread(function()
    currentLocation = Config.Locations[math.random(#Config.Locations)]
    if Config.Debug then
        print("Current location set to: " .. currentLocation.name)
    end
end)

-- Setup target interactions if enabled
if Config.UseTarget then
    Citizen.CreateThread(function()
        exports['rsg-target']:AddTargetModel({GetHashKey(Config.Props.Pickup), GetHashKey(Config.Props.Processing)}, {
            options = {
                {
                    type = "client",
                    event = "thelux_weedjob:interact",
                    icon = "fas fa-cannabis",
                    label = "Interact",
                },
            },
            distance = 2.5
        })
    end)
end

-- Interaction handler
RegisterNetEvent('thelux_weedjob:interact')
AddEventHandler('thelux_weedjob:interact', function(data)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local action

    if #(coords - currentLocation.pickup) < 3.0 then
        action = 'pickup'
    elseif #(coords - currentLocation.process) < 3.0 then
        action = 'process'
    elseif #(coords - currentLocation.sell) < 3.0 then
        action = 'sell'
    end

    if action and not isOnCooldown(action) then
        setCooldown(action)
        TriggerServerEvent('thelux_weedjob:' .. action)
    elseif isOnCooldown(action) then
        RSGCore.Functions.Notify(Lang:t('error.cooldown'), 'error')
    end
end)

-- Key-based interaction if target system is disabled
Citizen.CreateThread(function()
    while true do
        if not Config.UseTarget then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local sleep = 1000

            for action, loc in pairs({pickup = currentLocation.pickup, process = currentLocation.process, sell = currentLocation.sell}) do
                local dist = #(coords - loc)
                if dist < 2.0 then
                    sleep = 0
                    RSGCore.Functions.DrawText3D(loc.x, loc.y, loc.z, Lang:t('info.' .. action .. '_prompt'))
                    if IsControlJustReleased(0, 0xCEFD9220) and not isOnCooldown(action) then -- E key
                        setCooldown(action)
                        TriggerServerEvent('thelux_weedjob:' .. action)
                    elseif isOnCooldown(action) then
                        RSGCore.Functions.Notify(Lang:t('error.cooldown'), 'error')
                    end
                end
            end

            Citizen.Wait(sleep)
        else
            Citizen.Wait(1000)
        end
    end
end)
