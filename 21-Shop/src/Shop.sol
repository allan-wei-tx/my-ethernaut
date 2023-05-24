// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBuyer} from "./interface/IBuyer.sol";

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        IBuyer _buyer = IBuyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}
