local lastActionTime = 0

-- Helper function to check cooldown
function isOnCooldown()
    return GetGameTimer() - lastActionTime < Config.ActionCooldown
end

-- Initialize job locations dynamically
local currentLocation = Config.Locations[math.random(#Config.Locations)]

Citizen.CreateThread(function()
    if Config.UseTargetSystem then
        -- Setup target system interaction
        exports['rsg-target']:AddTargetModel({GetHashKey(Config.PropPickup), GetHashKey(Config.PropProcessing)}, {
            options = {
                {
                    event = "thelux_weedjob:interact",
                    icon = "fas fa-seedling",
                    label = "Interact with Plant",
                    action = function(entity)
                        TriggerEvent('thelux_weedjob:interactWithProp', entity)
                    end,
                },
            },
            job = {'all'}, -- Allow all jobs to interact, customize as needed
            distance = 2.5
        })
    end
end)

RegisterNetEvent('thelux_weedjob:interactWithProp')
AddEventHandler('thelux_weedjob:interactWithProp', function(entity)
    local entityModel = GetEntityModel(entity)
    if isOnCooldown() then
        TriggerEvent('notification', Locales['en']['cooldown_message'])
        return
    end
    lastActionTime = GetGameTimer()

    if entityModel == GetHashKey(Config.PropPickup) then
        TriggerServerEvent('thelux_weedjob:pickup')
    elseif entityModel == GetHashKey(Config.PropProcessing) then
        TriggerServerEvent('thelux_weedjob:process')
    else
        TriggerServerEvent('thelux_weedjob:sell')
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local nearby = false

        if not Config.UseTargetSystem then
            -- Key-based interaction
            if GetDistanceBetweenCoords(coords, currentLocation.pickup, true) < 2.0 then
                nearby = true
                DisplayHelpTextThisFrame(Locales['en']['pickup_prompt'])
                if IsControlJustReleased(0, 0xCEFD9220) and not isOnCooldown() then -- E key
                    lastActionTime = GetGameTimer()
                    TriggerServerEvent('thelux_weedjob:pickup')
                end
            elseif GetDistanceBetweenCoords(coords, currentLocation.process, true) < 2.0 then
                nearby = true
                DisplayHelpTextThisFrame(Locales['en']['process_prompt'])
                if IsControlJustReleased(0, 0xCEFD9220) and not isOnCooldown() then -- E key
                    lastActionTime = GetGameTimer()
                    TriggerServerEvent('thelux_weedjob:process')
                end
            elseif GetDistanceBetweenCoords(coords, currentLocation.sell, true) < 2.0 then
                nearby = true
                DisplayHelpTextThisFrame(Locales['en']['sell_prompt'])
                if IsControlJustReleased(0, 0xCEFD9220) and not isOnCooldown() then -- E key
                    lastActionTime = GetGameTimer()
                    TriggerServerEvent('thelux_weedjob:sell')
                end
            end
        end

        if not nearby then
            Citizen.Wait(500)
        else
            Citizen.Wait(0)
        end
    end
end)

function DisplayHelpTextThisFrame(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
