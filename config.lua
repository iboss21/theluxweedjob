Config = {}

-- General Job Configurations
Config.Debug = false -- Set to true for debug mode
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.PickupItem = "cannabis"
Config.ProcessingItem = "marijuana"
Config.SellItem = "packaged_marijuana"

-- Cooldown Settings
Config.ActionCooldown = 5000  -- 5 seconds cooldown
Config.AntiCheatLog = true    -- Enable logging for anti-cheat detection

-- Job Locations
Config.Locations = {
    { 
        name = "Farm 1", 
        pickup = vector3(-1392.21, -2650.47, 42.92),
        process = vector3(-1387.56, -2660.53, 42.92),
        sell = vector3(-1378.48, -2673.44, 42.92)
    },
    { 
        name = "Farm 2", 
        pickup = vector3(-1500.00, -2700.00, 40.00),
        process = vector3(-1505.00, -2710.00, 40.00),
        sell = vector3(-1495.00, -2720.00, 40.00)
    },
}

-- Prop Settings
Config.Props = {
    Pickup = "p_weed_bunch01x",
    Processing = "s_bri_weedsmudge"
}

-- NPC Settings
Config.NPCs = {
    TaskGiver = {model = "u_m_m_asbminer_01", scenario = "WORLD_HUMAN_SMOKE"},
    Processor = {model = "u_m_m_asbminer_01", scenario = "WORLD_HUMAN_CLIPBOARD"},
    Buyer = {model = "u_m_m_asbminer_01", scenario = "WORLD_HUMAN_SMOKE_CIGAR"}
}

-- Item Settings
Config.Items = {
    [Config.PickupItem] = {label = "Cannabis", weight = 100},
    [Config.ProcessingItem] = {label = "Marijuana", weight = 50},
    [Config.SellItem] = {label = "Packaged Marijuana", weight = 25}
}

-- Reward Settings
Config.Rewards = {
    PickupQuantity = 1,
    ProcessQuantity = 1,
    SellPrice = {min = 80, max = 120}
}
