local RSGCore = exports['rsg-core']:GetCoreObject()
local spawnedNpcs = {}

-- Function to spawn an NPC
local function spawnNpc(npcConfig, coords)
    local model = GetHashKey(npcConfig.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    local npc = CreatePed(model, coords.x, coords.y, coords.z - 1.0, coords.w, false, false, 0, 0)
    SetEntityAsMissionEntity(npc, true, true)
    SetPedCanBeTargetted(npc, false)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)

    if npcConfig.scenario then
        TaskStartScenarioInPlace(npc, npcConfig.scenario, 0, true)
    end

    return npc
end

-- Spawn NPCs
Citizen.CreateThread(function()
    for _, location in pairs(Config.Locations) do
        spawnedNpcs[#spawnedNpcs + 1] = spawnNpc(Config.NPCs.TaskGiver, location.pickup)
        spawnedNpcs[#spawnedNpcs + 1] = spawnNpc(Config.NPCs.Processor, location.process)
        spawnedNpcs[#spawnedNpcs + 1] = spawnNpc(Config.NPCs.Buyer, location.sell)
    end
end)

-- Clean up NPCs when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for _, npc in pairs(spawnedNpcs) do
        if DoesEntityExist(npc) then
            DeleteEntity(npc)
        end
    end
end)
