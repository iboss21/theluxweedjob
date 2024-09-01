local playerCooldowns = {}
local actionCooldown = Config.ActionCooldown

function isPlayerOnCooldown(playerId)
    local currentTime = os.time() * 1000
    if playerCooldowns[playerId] and currentTime - playerCooldowns[playerId] < actionCooldown then
        return true
    end
    playerCooldowns[playerId] = currentTime
    return false
end

function logAntiCheat(playerId, message)
    if Config.AntiCheatLog then
        print("[Anti-Cheat] Player ID: " .. playerId .. " - " .. message)
        -- Optionally log to a file or external system
    end
end

RegisterServerEvent('thelux_weedjob:pickup')
AddEventHandler('thelux_weedjob:pickup', function()
    local source = source
    if isPlayerOnCooldown(source) then
        TriggerClientEvent('notification', source, Locales['en']['cooldown_message'])
        logAntiCheat(source, 'Attempted to spam pickup action')
        return
    end

    local xPlayer = GetPlayerFromId(source)
    local framework = Config.Framework

    if xPlayer then
        if framework == 'rsg-core' then
            if xPlayer.canCarryItem(Config.PickupItem, 1) then
                xPlayer.addInventoryItem(Config.PickupItem, 1)
                TriggerClientEvent('notification', source, Locales['en']['success_pickup'])
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_pickup'])
            end

        elseif framework == 'qbr' then
            if exports['qbr-core']:CanCarryItem(source, Config.PickupItem, 1) then
                exports['qbr-core']:AddItem(source, Config.PickupItem, 1)
                TriggerClientEvent('notification', source, Locales['en']['success_pickup'])
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_pickup'])
            end

        elseif framework == 'vorp' then
            local Character = VorpCore.getUser(source).getUsedCharacter
            if Character.canCarryItem(Config.PickupItem, 1) then
                Character.addInventoryItem(Config.PickupItem, 1)
                TriggerClientEvent('vorp:Tip', source, Locales['en']['success_pickup'], 3000)
            else
                TriggerClientEvent('vorp:Tip', source, Locales['en']['fail_pickup'], 3000)
            end

        else
            TriggerClientEvent('notification', source, 'Framework not supported or not set properly.')
        end
    else
        TriggerClientEvent('notification', source, 'Player not found.')
    end
end)

RegisterServerEvent('thelux_weedjob:process')
AddEventHandler('thelux_weedjob:process', function()
    local source = source
    if isPlayerOnCooldown(source) then
        TriggerClientEvent('notification', source, Locales['en']['cooldown_message'])
        logAntiCheat(source, 'Attempted to spam process action')
        return
    end

    local xPlayer = GetPlayerFromId(source)
    local framework = Config.Framework

    if xPlayer then
        if framework == 'rsg-core' then
            if xPlayer.getInventoryItem(Config.PickupItem).count >= 1 then
                if xPlayer.canCarryItem(Config.ProcessingItem, 1) then
                    xPlayer.removeInventoryItem(Config.PickupItem, 1)
                    xPlayer.addInventoryItem(Config.ProcessingItem, 1)
                    TriggerClientEvent('notification', source, Locales['en']['success_process'])
                else
                    TriggerClientEvent('notification', source, Locales['en']['fail_process'])
                end
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_no_weed'])
            end

        elseif framework == 'qbr' then
            if exports['qbr-core']:GetItemCount(source, Config.PickupItem) >= 1 then
                if exports['qbr-core']:CanCarryItem(source, Config.ProcessingItem, 1) then
                    exports['qbr-core']:RemoveItem(source, Config.PickupItem, 1)
                    exports['qbr-core']:AddItem(source, Config.ProcessingItem, 1)
                    TriggerClientEvent('notification', source, Locales['en']['success_process'])
                else
                    TriggerClientEvent('notification', source, Locales['en']['fail_process'])
                end
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_no_weed'])
            end

        elseif framework == 'vorp' then
            local Character = VorpCore.getUser(source).getUsedCharacter
            if Character.getInventoryItem(Config.PickupItem).count >= 1 then
                if Character.canCarryItem(Config.ProcessingItem, 1) then
                    Character.removeInventoryItem(Config.PickupItem, 1)
                    Character.addInventoryItem(Config.ProcessingItem, 1)
                    TriggerClientEvent('vorp:Tip', source, Locales['en']['success_process'], 3000)
                else
                    TriggerClientEvent('vorp:Tip', source, Locales['en']['fail_process'], 3000)
                end
            else
                TriggerClientEvent('vorp:Tip', source, Locales['en']['fail_no_weed'], 3000)
            end

        else
            TriggerClientEvent('notification', source, 'Framework not supported or not set properly.')
        end
    else
        TriggerClientEvent('notification', source, 'Player not found.')
    end
end)

RegisterServerEvent('thelux_weedjob:sell')
AddEventHandler('thelux_weedjob:sell', function()
    local source = source
    if isPlayerOnCooldown(source) then
        TriggerClientEvent('notification', source, Locales['en']['cooldown_message'])
        logAntiCheat(source, 'Attempted to spam sell action')
        return
    end

    local xPlayer = GetPlayerFromId(source)
    local framework = Config.Framework

    if xPlayer then
        if framework == 'rsg-core' then
            if xPlayer.getInventoryItem(Config.ProcessingItem).count >= 1 then
                xPlayer.removeInventoryItem(Config.ProcessingItem, 1)
                xPlayer.addMoney(100) -- Example payout
                TriggerClientEvent('notification', source, Locales['en']['success_sell'])
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_sell'])
            end

        elseif framework == 'qbr' then
            if exports['qbr-core']:GetItemCount(source, Config.ProcessingItem) >= 1 then
                exports['qbr-core']:RemoveItem(source, Config.ProcessingItem, 1)
                exports['qbr-core']:AddMoney(source, 100) -- Example payout
                TriggerClientEvent('notification', source, Locales['en']['success_sell'])
            else
                TriggerClientEvent('notification', source, Locales['en']['fail_sell'])
            end

        elseif framework == 'vorp' then
            local Character = VorpCore.getUser(source).getUsedCharacter
            if Character.getInventoryItem(Config.ProcessingItem).count >= 1 then
                Character.removeInventoryItem(Config.ProcessingItem, 1)
                Character.addMoney(100) -- Example payout
                TriggerClientEvent('vorp:Tip', source, Locales['en']['success_sell'], 3000)
            else
                TriggerClientEvent('vorp:Tip', source, Locales['en']['fail_sell'], 3000)
            end

        else
            TriggerClientEvent('notification', source, 'Framework not supported or not set properly.')
        end
    else
        TriggerClientEvent('notification', source, 'Player not found.')
    end
end)
