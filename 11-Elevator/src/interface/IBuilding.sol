// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBuilding {
    function isLastFloor(uint256) external returns (bool);
}
