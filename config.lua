Config = {}

-- General Job Configurations
Config.JobName = "weedfarmer"
Config.PickupItem = "weed"
Config.ProcessingItem = "processed_weed"
Config.SellItem = "packaged_weed"

-- Interaction Settings
Config.UseTargetSystem = true  -- Set to true to use target system, false for key-based interactions

-- Cooldown Settings
Config.ActionCooldown = 5000  -- 5 seconds cooldown
Config.AntiCheatLog = true    -- Enable logging for anti-cheat detection

-- NPC and Job Locations (Dynamic Support)
Config.DynamicLocations = true  -- Enable dynamic locations for more immersive gameplay
Config.Locations = {
    { name = "Farm 1", pickup = vector3(-1392.21, -2650.47, 42.92), process = vector3(-1387.56, -2660.53, 42.92), sell = vector3(-1378.48, -2673.44, 42.92) },
    { name = "Farm 2", pickup = vector3(-1500.00, -2700.00, 40.00), process = vector3(-1505.00, -2710.00, 40.00), sell = vector3(-1495.00, -2720.00, 40.00) },
}

-- Prop Settings
Config.PropPickup = "p_weed_bunch01x"
Config.PropProcessing = "s_bri_weedsmudge"

-- Framework Settings
Config.Framework = 'rsg-core'  -- Can be 'qbr', 'vorp', etc.
