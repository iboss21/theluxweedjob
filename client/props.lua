local spawnedProps = {}

-- Function to create a prop
function createProp(propName, coords)
    local prop = CreateObject(GetHashKey(propName), coords.x, coords.y, coords.z, false, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    table.insert(spawnedProps, prop)
    return prop
end

-- Function to remove all spawned props
function removeAllProps()
    for _, prop in pairs(spawnedProps) do
        if DoesEntityExist(prop) then
            DeleteObject(prop)
        end
    end
    spawnedProps = {}
end

-- Spawn necessary props at the start
Citizen.CreateThread(function()
    createProp(Config.PropPickup, currentLocation.pickup)
    createProp(Config.PropProcessing, currentLocation.process)
end)

-- Clean up props when resource stops
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        removeAllProps()
    end
end)
