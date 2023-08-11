// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {DetectionBot} from "src/DetectionBot.sol";
import {DoubleEntryPoint} from "src/DoubleEntryPoint.sol";
import {Forta} from "src/Forta.sol";
import {LegacyToken} from "src/LegacyToken.sol";

contract DetectionBotScript is Script {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        DoubleEntryPoint det = DoubleEntryPoint(0x3d9475a8cDEAe257b354B72c37930523A775e0f0);
        address vault = det.cryptoVault();
        Forta forta = det.forta();
        DetectionBot bot = new DetectionBot(vault);

        forta.setDetectionBot(address(bot));

        vm.stopBroadcast();
    }
}
