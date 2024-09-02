local RSGCore = exports['rsg-core']:GetCoreObject()

-- Helper function for anti-cheat logging
local function logAntiCheat(playerId, message)
    if Config.AntiCheatLog then
        print("[Anti-Cheat] Player ID: " .. playerId .. " - " .. message)
        -- Optionally log to a file or external system
    end
end

-- Helper function to check if player can carry item
local function canCarryItem(playerId, item, amount)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    if not Player then return false end
    
    local totalWeight = RSGCore.Player.GetTotalWeight(Player.PlayerData.items)
    local itemInfo = RSGCore.Shared.Items[item]
    if not itemInfo then return false end
    
    return (totalWeight + (itemInfo.weight * amount)) <= Config.MaxWeight
end

-- Pickup event handler
RegisterServerEvent('thelux_weedjob:pickup')
AddEventHandler('thelux_weedjob:pickup', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if canCarryItem(src, Config.PickupItem, Config.Rewards.PickupQuantity) then
        Player.Functions.AddItem(Config.PickupItem, Config.Rewards.PickupQuantity)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.PickupItem], "add")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.pickup'), 'success')
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.cant_carry'), 'error')
    end
end)

-- Process event handler
RegisterServerEvent('thelux_weedjob:process')
AddEventHandler('thelux_weedjob:process', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem(Config.PickupItem, 1) then
        if canCarryItem(src, Config.ProcessingItem, Config.Rewards.ProcessQuantity) then
            Player.Functions.AddItem(Config.ProcessingItem, Config.Rewards.ProcessQuantity)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.PickupItem], "remove")
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.ProcessingItem], "add")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.process'), 'success')
        else
            Player.Functions.AddItem(Config.PickupItem, 1) -- Give back the item if can't carry processed item
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.cant_carry'), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.no_item'), 'error')
    end
end)

-- Sell event handler
RegisterServerEvent('thelux_weedjob:sell')
AddEventHandler('thelux_weedjob:sell', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem(Config.ProcessingItem, 1) then
        local reward = math.random(Config.Rewards.SellPrice.min, Config.Rewards.SellPrice.max)
        Player.Functions.AddMoney('cash', reward, "weed-sold")
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.ProcessingItem], "remove")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.sell', {value = reward}), 'success')
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.no_item'), 'error')
    end
end)
