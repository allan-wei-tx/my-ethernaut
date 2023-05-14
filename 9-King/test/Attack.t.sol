// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {King} from "../src/King.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    King public king;
    Attack public attack;

    function setUp() public {
        king = new King{value: 0.1 ether}();
        attack = new Attack(king);
    }

    function test_Exploit() public {
        assertEq(king.owner(), address(this));
        assertEq(king._king(), address(this));
        assertEq(king.prize(), 0.1 ether);

        attack.attack{value: 0.2 ether}();

        assertEq(king._king(), address(attack));
        assertEq(king.prize(), 0.2 ether);

        vm.expectRevert();
        address(king).call{value: 0.3 ether}("");
    }

    receive() external payable {}
}
