// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    Reentrance public reentrance;
    Attack public attack;

    function setUp() public {
        reentrance = new Reentrance();
        vm.deal(address(reentrance), 1 ether);
        attack = new Attack(address(reentrance));
    }

    function test_Exploit() public {
        attack.attack{value: 1 ether}();
        assertEq(address(reentrance).balance, 0);
    }
}
