// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Force} from "../src/Force.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    Force public force;
    Attack public attack;

    function setUp() public {
        force = new Force();
        attack = new Attack{value: 0.1 ether}(payable(address(force)));
    }

    function test_Exploit() public {
        assertTrue(address(force).balance != 0);
    }
}
