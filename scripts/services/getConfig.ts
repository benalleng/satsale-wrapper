// To utilize the default config system built, this file is required. It defines the *structure* of the configuration file. These structured options display as changeable UI elements within the "Config" section of the service details page in the Embassy UI.

import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
  "tor-address": {
    "name": "Tor Address",
    "description": "The Tor address of the network interface",
    "type": "pointer",
    "subtype": "package",
    "package-id": "lnbits",
    "target": "tor-address",
    "interface": "main",
  },
  "service-fee": {
      "type": "string",
      "name": "LNBits Bitcoin Default Service Fee",
      "description": "Fee that is charged when using LNBits",
      "default": "0.0",
      "nullable": false
  },
  "wallet": {
    "type": "union",
    "name": "Connection Settings",
    "description": "LNBits Connection Settings",
    "tag": {
        "id": "type",
        "name": "Select Lightning Node",
        "variant-names": {
            "LndRestWallet": "Lightning Network Daemon",
            "CLightningWallet": "Core Lightning",
        },
        "description":
            "The LN node to connect to",
        },
    "default": "LndRestWallet",
    "variants": {
      "LndRestWallet": {},
      "CLightningWallet":{},
    }
  }
});
