// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    GatekeeperOne public gatekeeperOne;
    Attack public attack;

    function setUp() public {
        gatekeeperOne = new GatekeeperOne();
        attack = new Attack(gatekeeperOne);
    }

    function test_Exploit() public {
        attack.attack();
        assertEq(gatekeeperOne.entrant(), msg.sender);
    }
}
