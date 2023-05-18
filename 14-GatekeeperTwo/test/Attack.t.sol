// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {Attack} from "../src/Attack.sol";

contract AttackTest is Test {
    GatekeeperTwo public gatekeeper;
    Attack public attack;

    function setUp() public {
        gatekeeper = new GatekeeperTwo();
        attack = new Attack(gatekeeper);
    }

    function test_Exploit() public {
        assertEq(gatekeeper.entrant(), tx.origin);
    }
}
