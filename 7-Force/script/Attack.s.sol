// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Force} from "../src/Force.sol";
import {Attack} from "../src/Attack.sol";

contract CounterScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        address payable force = payable(vm.envAddress("FORCE"));
        Attack attack = new Attack{value: 0.001 ether}(force);
    }
}
