# TheLux Weed Job for RedM

![License](https://img.shields.io/badge/license-MIT-blue.svg)

A comprehensive and customizable weed farming job resource for RedM, designed to be compatible with the RSG-Core framework. This resource features dynamic locations, configurable interactions, and advanced anti-cheat measures.

## Features

- **RSG-Core Integration**: Seamlessly integrates with the RSG-Core framework for RedM.
- **Dynamic Locations**: Multiple job locations for diverse and unpredictable gameplay.
- **Flexible Interaction**: Support for both target-based and key-based interactions.
- **Anti-Cheat Measures**: Cooldown management and optional anti-cheat logging.
- **NPC Integration**: Automated NPC spawning for task giver, processor, and buyer roles.
- **Prop System**: Dynamic prop placement for visual job representation.
- **Localization Support**: Easy-to-configure locale system for multi-language support.

## Dependencies

- [RSG-Core](https://github.com/Rexshack-RedM/rsg-core)
- [RSG-Target](https://github.com/Rexshack-RedM/rsg-target)
- [ox_lib](https://github.com/overextended/ox_lib)

## Installation

1. Ensure you have all the dependencies installed and up-to-date.
2. Clone this repository into your server's `resources` directory:

   git clone https://github.com/iboss21/thelux-weedjob.git
   
3. Add the following line to your `server.cfg`:

   ensure thelux_weedjob

## Configuration

The `config.lua` file allows you to customize various aspects of the job:

- `Config.Debug`: Enable/disable debug mode
- `Config.UseTarget`: Toggle between target-based and key-based interactions
- `Config.Locations`: Define multiple job locations
- `Config.Props`: Customize prop models for pickup and processing
- `Config.NPCs`: Set NPC models and scenarios
- `Config.Items`: Define item properties
- `Config.Rewards`: Set reward quantities and sell prices

Refer to the comments in `config.lua` for detailed explanations of each option.

## Usage

1. Approach the task giver NPC to start the job.
2. Collect cannabis from the pickup locations.
3. Process the cannabis at the processing locations.
4. Sell the processed marijuana to the buyer NPC.

## Locale Support

To add or modify language support, edit the files in the `locales` directory. The resource currently supports English by default.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

- Developed by [TheLuxEmpire/Dev](https://discord.gg/Aj7KGKMDBU)
- Contributions by [iBoss21](https://github.com/iboss21)

## Support

For support, join our Discord server: [The Land of Wolves Roleplay](https://discord.gg/thelandofwolves)

## Acknowledgments

- RSG-Core team for the amazing framework ( Thank you )
- RedM community for continuous support and inspiration
