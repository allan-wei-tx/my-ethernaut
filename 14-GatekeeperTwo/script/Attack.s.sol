// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        GatekeeperTwo gatekeeper = GatekeeperTwo(vm.envAddress("GATEKEEPER_TWO"));
        Attack attack = new Attack(gatekeeper);

        vm.stopBroadcast();
    }
}
