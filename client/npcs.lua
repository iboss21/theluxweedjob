local npcModels = {
    taskGiver = "u_m_m_asbminer_01", -- NPC for giving the weed picking task
    processor = "u_m_m_asbminer_01", -- NPC for processing the weed
    buyer = "u_m_m_asbminer_01", -- NPC for selling the processed weed
}

local npcLocations = {
    taskGiver = vector3(-1392.21, -2650.47, 42.92), -- Location of the task giver NPC
    processor = vector3(-1387.56, -2660.53, 42.92), -- Location of the processing NPC
    buyer = vector3(-1378.48, -2673.44, 42.92), -- Location of the buyer NPC
}

local spawnedNpcs = {}

-- Function to spawn an NPC
function spawnNpc(model, coords, heading)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end

    local npc = CreatePed(3, GetHashKey(model), coords.x, coords.y, coords.z, heading or 0.0, false, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetPedDiesWhenInjured(npc, false)
    SetPedCanPlayAmbientAnims(npc, true)
    SetPedCanRagdollFromPlayerImpact(npc, false)
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    table.insert(spawnedNpcs, npc)
    return npc
end

-- Spawn NPCs on resource start
Citizen.CreateThread(function()
    -- Spawn the task giver NPC
    spawnNpc(npcModels.taskGiver, npcLocations.taskGiver)

    -- Spawn the processing NPC
    spawnNpc(npcModels.processor, npcLocations.processor)

    -- Spawn the buyer NPC
    spawnNpc(npcModels.buyer, npcLocations.buyer)
end)

-- Function to handle NPC interactions
function handleNpcInteraction(npcType)
    if npcType == 'taskGiver' then
        -- Trigger the event to start picking weed task
        TriggerServerEvent('thelux_weedjob:startTask')
    elseif npcType == 'processor' then
        -- Trigger the event to process weed
        TriggerServerEvent('thelux_weedjob:process')
    elseif npcType == 'buyer' then
        -- Trigger the event to sell processed weed
        TriggerServerEvent('thelux_weedjob:sell')
    end
end

-- Detect player proximity to NPCs and show prompts
Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local nearby = false

        for npcType, location in pairs(npcLocations) do
            if GetDistanceBetweenCoords(coords, location, true) < 2.0 then
                nearby = true
                DisplayHelpTextThisFrame("Press [E] to interact with the " .. npcType)
                if IsControlJustReleased(0, 0xCEFD9220) then -- E key
                    handleNpcInteraction(npcType)
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

-- Clean up NPCs when resource stops
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, npc in ipairs(spawnedNpcs) do
            if DoesEntityExist(npc) then
                DeleteEntity(npc)
            end
        end
    end
end)

function DisplayHelpTextThisFrame(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
