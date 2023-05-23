// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Attack} from "src/Attack.sol";
import {Denial} from "src/Denial.sol";

contract AttackTest is Test {
    Attack public attack;
    Denial public denial;

    function setUp() public {
        denial = new Denial();
        attack = new Attack(address(denial));
    }

    function test_Exploit() public {
        attack.attack();
        vm.prank(denial.owner());
        vm.expectRevert();
        denial.withdraw{gas: 1e6}();
    }
}
