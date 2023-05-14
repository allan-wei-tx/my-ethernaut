// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Telephone} from "../src/Telephone.sol";
import {Attack} from "../src/Attack.sol";

contract AttackTest is Test {
    Telephone public telephone;
    Attack public attack;

    function setUp() public {
        telephone = new Telephone();
        attack = new Attack(telephone);
    }

    function test_Exploit() public {
        attack.attack(address(this));
        assertEq(telephone.owner(), address(this));
    }
}
