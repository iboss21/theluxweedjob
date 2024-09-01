
# TheLux Weed Job for RedM

A comprehensive and customizable weed farming job for RedM, designed to be compatible with multiple frameworks including `rsg-core`, `qbr`, and `vorp`. This resource features dynamic locations, configurable interactions, and advanced anti-cheat measures.

## Features

- **Multiple Framework Support**: Compatible with `rsg-core`, `qbr`, and `vorp` frameworks.
- **Dynamic Locations**: Randomized job locations for immersive and unpredictable gameplay.
- **Interaction Options**: Choose between using a targeting system or traditional key-based interactions.
- **Anti-Cheat Measures**: Cooldown management and anti-cheat logging to prevent exploitation.
- **Customizable Settings**: Easy-to-configure options for interaction methods, cooldowns, and more.

## Installation

1. **Download and Extract**: Download the latest version of the resource and extract it into your RedM server's `resources` directory.
2. **Ensure Dependencies**: Make sure you have the following dependencies installed on your server:
   ```
   - `rsg-core`
   - `rsg-target`
   - `ox_lib`
   - `vorp_core` (for VORP compatibility)
   - `qbr-core` (for QBR compatibility)

4. **Add to Server Config**: Add the resource to your `server.cfg`:

    - `ensure thelux_weedjob`


## Configuration

Edit the `config.lua` file to customize the behavior of the job:

- **General Job Settings**: Define items for pickup, processing, and selling.
- **Interaction Method**: Toggle between using a targeting system and key-based interactions.
- **Cooldown and Anti-Cheat**: Adjust cooldown times and enable/disable anti-cheat logging.
- **Dynamic Locations**: Enable dynamic job locations and define multiple job sites.

### Example Configuration (`config.lua`)

```lua
Config = {}

Config.JobName = "weedfarmer"
Config.PickupItem = "weed"
Config.ProcessingItem = "processed_weed"
Config.SellItem = "packaged_weed"

Config.UseTargetSystem = true  -- Set to true to use target system, false for key-based interactions

Config.ActionCooldown = 5000  -- 5 seconds cooldown
Config.AntiCheatLog = true    -- Enable logging for anti-cheat detection

Config.DynamicLocations = true  -- Enable dynamic locations for more immersive gameplay
Config.Locations = {
    { name = "Farm 1", pickup = vector3(-1392.21, -2650.47, 42.92), process = vector3(-1387.56, -2660.53, 42.92), sell = vector3(-1378.48, -2673.44, 42.92) },
    { name = "Farm 2", pickup = vector3(-1500.00, -2700.00, 40.00), process = vector3(-1505.00, -2710.00, 40.00), sell = vector3(-1495.00, -2720.00, 40.00) },
}

Config.PropPickup = "p_weed_bunch01x"
Config.PropProcessing = "s_bri_weedsmudge"

Config.Framework = 'rsg-core'  -- Can be 'qbr', 'vorp', etc.
```

## Usage

1. **Starting the Job**: Interact with the NPC or props to start the weed farming job.
2. **Picking Weed**: Go to the pickup location and collect raw weed using the specified interaction method (E key or target system).
3. **Processing Weed**: Bring raw weed to the processing location and convert it into processed weed.
4. **Selling Weed**: Sell the processed weed at the designated selling location to earn money.

## Anti-Cheat Measures

- **Cooldown System**: Each action (pickup, process, sell) is limited by a configurable cooldown period to prevent spamming.
- **Logging**: All suspicious actions are logged for monitoring and further investigation.

## Credits

- Developed by [TheLuxEmpire/Dev] https://discord.gg/Aj7KGKMDBU
- Contributions by [iBoss21] https://github.com/iboss21

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## Issues

If you encounter any issues, please open a new issue in the repository's issue tracker, and provide as much detail as possible about the problem and how to reproduce it.

## Support

For support, join our Discord server or contact [https://discord.gg/thelandofwolves].  | This is The Live Server.  The Land of Wolves Roleplay

## Future Plans

- **Enhanced NPC Interactions**: Implement dialogue and more complex interactions with NPCs.
- **Additional Jobs**: Expand the resource to include more jobs related to the RedM environment.
- **Economy Integration**: Tie earnings from the job more directly into the server's economy, with variable payouts and market dynamics.

```
