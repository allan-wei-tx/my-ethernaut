// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Elevator} from "../src/Elevator.sol";
import {Building} from "../src/Building.sol";

contract CounterTest is Test {
    Elevator public elevator;
    Building public building;

    function setUp() public {
        elevator = new Elevator();
        building = new Building(elevator);
    }

    function test_Exploit() public {
        building.attack();
        assertEq(elevator.top(), true);
    }
}
