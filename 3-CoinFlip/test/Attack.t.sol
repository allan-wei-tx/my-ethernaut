// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Attack} from "src/Attack.sol";
import {CoinFlip} from "src/CoinFlip.sol";

contract CounterTest is Test {
    Attack public attack;
    CoinFlip public coinFlip;

    function setUp() public {
        coinFlip = new CoinFlip();
        attack = new Attack(coinFlip);
    }

    function testFuzz_Attack(uint256 blockNumber) public {
        vm.assume(blockNumber > 0);
        vm.roll(blockNumber);
        bool succ = attack.attack();
        assertTrue(succ);
    }
}
