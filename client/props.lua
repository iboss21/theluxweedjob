local RSGCore = exports['rsg-core']:GetCoreObject()
local spawnedProps = {}

-- Function to create a prop
local function createProp(propName, coords)
    local model = GetHashKey(propName)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    local prop = CreateObject(model, coords.x, coords.y, coords.z - 1.0, false, false, true)
    SetEntityHeading(prop, coords.w)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)
    SetModelAsNoLongerNeeded(model)
    
    return prop
end

-- Spawn necessary props
Citizen.CreateThread(function()
    for _, location in pairs(Config.Locations) do
        spawnedProps[#spawnedProps + 1] = createProp(Config.Props.Pickup, location.pickup)
        spawnedProps[#spawnedProps + 1] = createProp(Config.Props.Processing, location.process)
    end
end)

-- Clean up props when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for _, prop in pairs(spawnedProps) do
        if DoesEntityExist(prop) then
            DeleteObject(prop)
        end
    end
end)
